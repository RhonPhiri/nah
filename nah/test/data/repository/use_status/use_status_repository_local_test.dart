import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/repository/on_boarding/on_boarding_repository.dart';
import 'package:nah/data/repository/on_boarding/on_boarding_repository_local.dart';
import '../../../../testing/fakes/models/hymnal.dart';
import '../../../../testing/fakes/services/fake_shared_preferences_service.dart';

void main() {
  group('OnBoardingRepository tests', () {
    late FakeSharedPreferencesService fakeSharedPrefServices;
    late OnBoardingRepository onBoardingRepository;
    setUp(() {
      fakeSharedPrefServices = FakeSharedPreferencesService();
      onBoardingRepository = OnBoardingRepositoryLocal(
        sharedPrefService: fakeSharedPrefServices,
      );
    });
    test('Test fetching stored hymnal language', () async {
      expect(
        await onBoardingRepository.isInitialLaunch,
        true,
        reason:
            "First time to open the app, expected that the user hasn't clicked any hymnal & stored the language",
      );
      await onBoardingRepository.enterApp(language: kHymnal.language);
      expect(
        await onBoardingRepository.isInitialLaunch,
        false,
        reason:
            "The user has clicked a hymnal and its language has been stored in the device",
      );
    });
  });
}
