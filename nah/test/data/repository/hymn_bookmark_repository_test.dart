import 'package:flutter_test/flutter_test.dart';
import 'package:nah/config/dependencies.dart';
import 'package:nah/data/repositories/hymn_bookmark/hymn_bookmark_repository.dart';
import 'package:nah/data/repositories/hymn_bookmark/hymn_bookmark_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';
import '../../../testing/fakes/data/service/fake_data_service.dart';
import '../../../testing/fakes/domain/models/hymn_bookmark.dart';
import '../../../testing/fakes/domain/models/hymn_collection.dart';
import '../../../testing/utils/result.dart';

void main() {
  group('HymnBookmarkRepository tests', () {
    late HymnBookmarkRepository bookmarkRepository;

    setUpAll(() {
      configureDependencies();
    });

    setUp(() {
      // Create a new scope so tests can register test-specific singletons and hide any previous registrations (NAH_DB_SERVICE) of the same type [DataService]
      getIt.pushNewScope();
      // Register the fake as the active DataService for this scope
      getIt.registerSingleton<DataService>(FakeDataService());

      // Instantiate repository after registering the fake service so it uses the fake
      bookmarkRepository = HymnBookmarkRepositoryDev(
        dataService: getIt<DataService>(),
      );
    });

    tearDown(() {
      // Remove the test scope and its registrations
      getIt.popScope();
    });

    test('Should create a hymnbookmark', () async {
      await bookmarkRepository.createHymnBookmark(kHymnBookmark);

      final ds = getIt<DataService>() as FakeDataService;

      expect(ds.hymnBookmarks.length, 1);
      expect(ds.hymnBookmarks.first, kHymnBookmark);
    });
    test('Should delete a hymnbookmark', () async {
      await bookmarkRepository.createHymnBookmark(kHymnBookmark);

      final ds = getIt<DataService>() as FakeDataService;

      expect(ds.hymnBookmarks.length, 1);

      await bookmarkRepository.deleteHymnBookmark(kHymnBookmark);

      expect(ds.hymnBookmarks.isEmpty, true);
    });
    test('Should fetch bookmarks', () async {
      await bookmarkRepository.createHymnBookmark(kHymnBookmark);

      final ds = getIt<DataService>() as FakeDataService;

      expect(ds.hymnBookmarks.length, 1);

      final result = await bookmarkRepository.getHymnBookmarks(
        kHymnCollection.id,
      );

      expect(result, isA<Success>());
      expect(result.asSuccess.data.first.title, "HYMN_BOOKMARK");
    });
  });
}
