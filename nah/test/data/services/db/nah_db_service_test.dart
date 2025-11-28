import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/services/db/db_helper.dart';
import 'package:nah/data/services/db/nah_db_parameters.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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

    database.execute('''
       CREATE TABLE $tableHymnal (
          hymnal_id INTEGER PRIMARY KEY,
          hymnal_title TEXT NOT NULL,
          hymnal_language TEXT NOT NULL
        );
     ''');

    database.execute('''
       CREATE TABLE $tableHymn (
          hymn_id INTEGER,
          hymn_title TEXT NOT NULL,
          hymn_details TEXT,
          hymn_lyrics TEXT NOT NULL,
          hymnal_id INTEGER NOT NULL,
          PRIMARY KEY(hymn_id, hymnal_id),
          FOREIGN KEY (hymnal_id) REFERENCES hymnal (hymnal_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
        );
      ''');

    /// Create hymn_collection table
    await database.execute('''
        CREATE TABLE hymn_collection (
	        hymn_collection_id INTEGER PRIMARY KEY,
	        hymn_collection_title TEXT NOT NULL UNIQUE,
      	  hymn_collection_description TEXT
        );
      ''');

    /// Create hymn_bookmark table
    await database.execute('''
        CREATE TABLE hymn_bookmark (
	        hymn_bookmark_id INTEGER NOT NULL,
	        hymn_bookmark_title TEXT NOT NULL,
	        hymn_collection_id INTEGER NOT NULL,
	        hymnal_id INTEGER NOT NULL,
          PRIMARY KEY (hymn_bookmark_id, hymn_collection_id)
	        FOREIGN KEY (hymn_collection_id) REFERENCES hymn_collection (hymn_collection_id)
	          ON UPDATE CASCADE
	          ON DELETE CASCADE,
	        FOREIGN KEY (hymnal_id) REFERENCES hymnal (hymnal_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
        );
      ''');

    final batch = database.batch();
    for (var i = 1; i <= hymnalLength; i++) {
      batch.insert('hymnal', {
        'hymnal_id': i,
        'hymnal_title': 'HYMNAL_$i',
        'hymnal_language': 'en',
      });

      for (var j = 1; j <= hymnLength; j++) {
        batch.insert('hymn', {
          'hymn_id': j,
          'hymn_title': 'HYMN_$j',
          'hymn_details': jsonEncode({'meta': 'm$j'}),
          'hymn_lyrics': jsonEncode({'verse': 'v$j'}),
          'hymnal_id': i,
        });
      }
    }

    for (var k = 1; k <= hymnCollectionLength; k++) {
      batch.insert('hymn_collection', {
        'hymn_collection_id': k,
        'hymn_collection_title': "HYMN_COLLECTION_$k",
        'hymn_collection_description': "DESCRIPTION",
      });

      for (var m = 1; m <= hymnBookmarkLength; m++) {
        batch.insert('hymn_bookmark', {
          'hymn_bookmark_id': m,
          'hymn_bookmark_title': 'HYMN_BOOKMARK_$m',
          'hymn_collection_id': k,
          'hymnal_id': 1,
        });
      }
    }

    await batch.commit(noResult: true);
  });

  tearDownAll(() async {
    await database.close();
  });

  group('nah_db_service', () {
    test('should get hymnals', () async {
      final hymnalMaps = await database.query(tableHymnal);
      final hymnals = mapper<Hymnal>(hymnalMaps);

      expect(hymnals.first, isA<Hymnal>());
      expect(hymnals.length, hymnalLength);
      expect(hymnals.first.title, "HYMNAL_1");
    });

    test('should get hymns given a hymnal id', () async {
      final hymnMaps = await database.rawQuery(
        'SELECT * FROM $tableHymn WHERE hymnal_id = ?',
        [1],
      );
      final hymns = mapper<Hymn>(hymnMaps);

      expect(hymns.first, isA<Hymn>());
      expect(hymns.length, hymnLength);
    });
    test('should get a hymns given a hymnal id and hymnal id', () async {
      final hymnMaps = await database.rawQuery(
        'SELECT * FROM $tableHymn WHERE hymn_id = ? AND hymnal_id = ?',
        [5, 2],
      );

      final hymns = mapper<Hymn>(hymnMaps);

      expect(hymns.first, isA<Hymn>());
      expect(hymns.length, 1);
      expect(hymns.first.id, 5);
    });

    test('should get hymn collections', () async {
      final collectionMaps = await database.query(tableHymnCollection);

      final hymnCollections = mapper<HymnCollection>(collectionMaps);

      expect(hymnCollections.first, isA<HymnCollection>());
      expect(hymnCollections.length, hymnCollectionLength);
    });
  });
}
