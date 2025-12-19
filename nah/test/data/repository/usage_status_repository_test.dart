import 'package:flutter_test/flutter_test.dart';
import 'package:nah/config/dependencies.dart';
import 'package:nah/data/repositories/usage_status_repository.dart/usage_status_repository.dart';
import 'package:nah/data/repositories/usage_status_repository.dart/usage_status_repository_dev.dart';
import 'package:nah/data/services/shared_pref_service.dart';

import '../../../testing/fakes/data/service/fake_shared_preference_service.dart';

void main() {
  late UsageStatusRepository usageStatusRepo;
  group('UsageStatusRepository tests', () {
    setUp(() async {
      getIt.pushNewScope();

      getIt.registerFactory<SharedPrefService>(
        () => FakeSharedPreferenceService(),
      );

      usageStatusRepo = UsageStatusRepositoryDev(
        sharedPrefService: getIt<SharedPrefService>(),
      );
    });

    tearDown(() {});

    test('Should return true for isFirstTime on first start up', () async {
      final status = await usageStatusRepo.isFirstTimeUser;

      expect(status, true);
    });

    test(
      'Should return false for isFirstTime after the first entry into app',
      () async {
        await usageStatusRepo.enterApp();

        final status = await usageStatusRepo.isFirstTimeUser;

        expect(status, false);
      },
    );
  });
}
