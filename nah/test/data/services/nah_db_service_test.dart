import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/services/db/nah_db_parameters.dart';
import 'package:nah/data/services/db/nah_db_utils.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_bookmark/hymn_bookmark.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../../testing/fakes/domain/models/hymn_collection.dart';

Future<void> main() async {
  const hymnalLength = 5;
  const hymnLength = 10;
  const hymnCollectionLength = 5;
  const hymnBookmarkLength = 10;

  late Database database;

  setUpAll(() async {
    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;
    database = await databaseFactory.openDatabase(inMemoryDatabasePath);

    await database.execute('PRAGMA foreign_keys = ON;');

    database.execute('''
      CREATE TABLE hymnal (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        language TEXT NOT NULL
     );
     ''');

    database.execute('''
      CREATE TABLE hymn (
        id INTEGER NOT NULL,
        title TEXT NOT NULL,
        details TEXT,
        lyrics TEXT NOT NULL,
        hymnalId INTEGER NOT NULL,
        PRIMARY KEY(id, hymnalId),
        FOREIGN KEY (hymnalId) REFERENCES hymnal (id)
          ON UPDATE CASCADE
          ON DELETE CASCADE
        );
      ''');

    /// Create hymn_collection table
    await database.execute('''
      CREATE TABLE hymn_collection (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL UNIQUE,
        description TEXT
      );
      ''');

    /// Create hymn_bookmark table
    await database.execute('''
      CREATE TABLE hymn_bookmark (
	      id INTEGER NOT NULL,
	      title TEXT NOT NULL,
	      hymnCollectionId INTEGER NOT NULL,
	      hymnalId INTEGER NOT NULL,
        PRIMARY KEY (id, hymnCollectionId)
	      FOREIGN KEY (hymnCollectionId) REFERENCES hymn_collection (id)
	        ON UPDATE CASCADE
	        ON DELETE CASCADE,
        FOREIGN KEY (hymnalId) REFERENCES hymnal (id)
          ON UPDATE CASCADE
          ON DELETE CASCADE
      );
      ''');

    final batch = database.batch();
    for (var i = 1; i <= hymnalLength; i++) {
      batch.insert('hymnal', {'id': i, 'title': 'HYMNAL_$i', 'language': 'en'});

      for (var j = 1; j <= hymnLength; j++) {
        batch.insert(
          'hymn',

          hymnMapper(
            Hymn(
              id: j,
              title: 'HYMN_$j',
              details: {
                "sourceRef": "$j NEH",
                "sourceTitle": "TITLE",
                "composer": "TEST_COMPOSER",
              },
              lyrics: {'verse': 'v$j'},
            ),
            i,
          ),
        );
      }
    }

    for (var k = 1; k <= hymnCollectionLength; k++) {
      batch.insert('hymn_collection', {
        'id': k,
        'title': "HYMN_COLLECTION_$k",
        'description': "DESCRIPTION",
      });

      for (var m = 1; m <= hymnBookmarkLength; m++) {
        batch.insert('hymn_bookmark', {
          'id': m,
          'title': 'HYMN_BOOKMARK_$m',
          'hymnCollectionId': k,
          'hymnalId': 1,
        });
      }
    }

    await batch.commit(noResult: true);
  });

  tearDownAll(() async {
    await database.close();
  });

  group('hymnals & hymns', () {
    test('should get hymnals', () async {
      final hymnalMaps = await database.query(tableHymnal);

      final hymnals = hymnalMaps.map(Hymnal.fromJson).toList();

      expect(hymnals.first, isA<Hymnal>());
      expect(hymnals.length, hymnalLength);
      expect(hymnals.first.title, "HYMNAL_1");
    });

    test('should get hymns given a hymnal id', () async {
      final hymnMaps = await database.query(
        tableHymn,
        where: "hymnalId = ?",
        whereArgs: [1],
      );
      final hymns = hymnMaps.map(hymnFromMap).toList();

      expect(hymns.first, isA<Hymn>());
      expect(hymns.length, hymnLength);
    });
    test('should get a hymns given a hymnal id and hymnal id', () async {
      final hymnMaps = await database.query(
        tableHymn,
        where: "id = ? AND hymnalId = ?",
        whereArgs: [3, 2],
      );

      final hymns = hymnMaps.map(hymnFromMap).toList();

      expect(hymns.first, isA<Hymn>());
      expect(hymns.length, 1);
      expect(hymns.first.id, 3);
    });
  });

  group('hymn collections and bookmarks', () {
    test('should get hymn collections', () async {
      final hymnCollectionMaps = await database.query(tableHymnCollection);

      final hymnCollections = hymnCollectionMaps
          .map(HymnCollection.fromJson)
          .toList();

      expect(hymnCollections.first, isA<HymnCollection>());
      expect(hymnCollections.length, hymnCollectionLength);
    });

    test(
      'should get a list of hymn_bookmarks given a hymn collection id',
      () async {
        final hymnBookmarkMaps = await database.query(
          tableHymnBookmark,
          where: 'hymnCollectionId = ?',
          whereArgs: [3],
        );

        final hymnBookmarks = hymnBookmarkMaps
            .map(HymnBookmark.fromJson)
            .toList();

        expect(hymnBookmarks.first, isA<HymnBookmark>());
        expect(hymnBookmarks.length, hymnBookmarkLength);
        expect(hymnBookmarks.first.hymnCollectionId, 3);
      },
    );

    test('should delete a bookmark', () async {
      final no = await database.delete(
        tableHymnBookmark,
        where: 'id = ? AND hymnCollectionId = ?',
        whereArgs: [1, 3],
      );

      expect(no, 1);
      final hymnBookmarkMaps = await database.query(
        tableHymnBookmark,
        where: 'hymnCollectionId = ?',
        whereArgs: [3],
      );

      final hymnBookmarks = hymnBookmarkMaps
          .map(HymnBookmark.fromJson)
          .toList();

      expect(hymnBookmarks.first, isA<HymnBookmark>());
      expect(
        hymnBookmarks.length,
        hymnBookmarkLength - 1,
        reason: "One bookmark has been deleted",
      );
    });

    test('should delete a hymn collection', () async {
      final no = await database.delete(
        tableHymnCollection,
        where: 'id = ?',
        whereArgs: [3],
      );

      expect(no, 1, reason: "Only one collection is deleted");

      final collectionMaps = await database.query(tableHymnCollection);

      final hymnCollections = collectionMaps
          .map(HymnCollection.fromJson)
          .toList();

      expect(
        hymnCollections.length,
        hymnCollectionLength - 1,
        reason: "One collection deleted",
      );
    });

    test(
      'should delete all bookmarks whose hymn collection has been deleted',
      () async {
        final hymnBookmarkMaps = await database.query(
          tableHymnBookmark,
          where: 'hymnCollectionId = ?',
          whereArgs: [3],
        );

        final hymnBookmarks = hymnBookmarkMaps
            .map(HymnBookmark.fromJson)
            .toList();

        expect(
          hymnBookmarks.isEmpty,
          true,
          reason: "ON DELETE CASCADE functionality worked",
        );
      },
    );

    test('Should edit a hymn collection', () async {
      final no = await database.update(
        tableHymnCollection,
        kHymnCollection.toJson(),
        where: 'id = ?',
        whereArgs: [kHymnCollection.id],
        conflictAlgorithm: .abort,
      );

      expect(no, 1, reason: "Only one hymn collection has been edited");

      final collectionMaps = await database.query(tableHymnCollection);

      final hymnCollections = collectionMaps
          .map(HymnCollection.fromJson)
          .toList();

      expect(hymnCollections.first, isA<HymnCollection>());
      expect(
        hymnCollections.length,
        hymnCollectionLength - 1,
        reason: "One hymn collection was deleted in the earlier test",
      );
      expect(hymnCollections.first.title, kHymnCollection.title);
    });
  });
}
