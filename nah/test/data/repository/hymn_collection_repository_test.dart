import 'package:flutter_test/flutter_test.dart';
import 'package:nah/config/dependencies.dart';
import 'package:nah/data/repositories/hymn_collection/hymn_collection_repository.dart';
import 'package:nah/data/repositories/hymn_collection/hymn_collection_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';
import '../../../testing/fakes/data/service/fake_data_service.dart';
import '../../../testing/fakes/domain/models/hymn_collection.dart';
import '../../../testing/utils/result.dart';

void main() {
  group('HymnCollectionRepository Tests', () {
    late HymnCollectionRepository hymnCollectionRepository;
    setUpAll(() {
      configureDevDependencies();
    });

    setUp(() {
      // Create a new scope so tests can register test-specific singletons
      getIt.pushNewScope();
      // Register the fake as the active DataService for this scope
      getIt.registerSingleton<DataService>(FakeDataService());

      // Instantiate repository after registering the fake service so it uses the fake
      hymnCollectionRepository = HymnCollectionRepositoryDev(
        dataService: getIt<DataService>(),
      );
    });

    tearDown(() {
      // Remove the test scope and its registrations
      getIt.popScope();
    });
    test('Should create a hymnCollection', () async {
      await hymnCollectionRepository.createHymnCollection(kHymnCollection);

      final ds = getIt<DataService>() as FakeDataService;
      expect(ds.hymnCollections.length, 1);
      expect(ds.hymnCollections.first, kHymnCollection);
    });

    test('Should edit an existing hymnCollection using copyWith', () async {
      // insert initial
      await hymnCollectionRepository.createHymnCollection(kHymnCollection);

      final updated = kHymnCollection.copyWith(
        title: 'NEW_TITLE',
        description: 'NEW_DESCRIPTION',
      );

      await hymnCollectionRepository.editHymnCollection(updated);

      final ds = getIt<DataService>() as FakeDataService;
      expect(ds.hymnCollections.length, 1);
      expect(ds.hymnCollections.first.title, 'NEW_TITLE');
      expect(ds.hymnCollections.first.description, 'NEW_DESCRIPTION');
    });

    test('Should delete an existing hymnCollection', () async {
      await hymnCollectionRepository.createHymnCollection(kHymnCollection);

      await hymnCollectionRepository.deleteHymnCollection(kHymnCollection);

      final ds = getIt<DataService>() as FakeDataService;
      expect(ds.hymnCollections, isEmpty);
    });

    test('Should get hymnCollections', () async {
      await hymnCollectionRepository.createHymnCollection(kHymnCollection);

      final ds = getIt<DataService>() as FakeDataService;

      expect(ds.hymnCollections.length, 1);

      final result = await hymnCollectionRepository.getHymnCollections();

      expect(result, isA<Success>());
      expect(result.asSuccess.data.first.title, "TITLE");
    });
  });
}
