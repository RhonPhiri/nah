import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/data/services/shared_pref_service.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';
import '../../../testing/fakes/data/service/fake_data_service.dart';
import '../../../testing/fakes/data/service/fake_shared_preference_service.dart';
import '../../../testing/fakes/domain/models/hymnal.dart';
import '../../../testing/utils/result.dart';

void main() {
  group('HymnalRepository tests', () {
    late DataService dataService;
    late HymnalRepository hymnalRepository;
    late SharedPrefService sharedPrefs;

    setUpAll(() {
      dataService = FakeDataService();
      sharedPrefs = FakeSharedPreferenceService();
      hymnalRepository = HymnalRepositoryDev(
        dataService: dataService,
        prefs: sharedPrefs,
      );
    });

    test('should get hymnals', () async {
      final result = await hymnalRepository.getHymnals();

      expect(result, isA<Success>());
      expect(result.asSuccess.data.length, 1);
      expect(result.asSuccess.data.first.language, "LANGUAGE");
    });

    test('should store the selected hymnal', () async {
      final result = await hymnalRepository.storeSelectedHymnal(
        jsonEncode(kHymnal.toJson()),
      );

      expect(result, isA<Success>());
    });

    test('should get the previously stored hymnal id', () async {
      final result = await hymnalRepository.getStoredHymnal();

      expect(result, isA<Success>());

      final hymnal = Hymnal.fromJson(jsonDecode(result.asSuccess.data!));
      expect(hymnal.id, kHymnal.id);
    });
  });
}
