///NahDb class to manage the database for the hymns & hymnals
///Will use the singleton pattern to allow only a single instanciation of the databsehelper class
///and use the instance grobally
library;

import 'package:nah/data/db/nah_db_parameters.dart';
import 'package:nah/data/models/hymnal_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NahDb {
  ///variable to hold the database name
  final String dbName = 'nah.db';

  ///Creating a private constructor to prevent external instantiation of the class
  NahDb._internal();

  ///creating a private instance to hold instance of this class & supply it globally
  static final NahDb _instance = NahDb._internal();

  ///factory constructor returning an existing instance of a class hence instead of making instance public, instance is private, not to be accessed outside too
  ///But when the user calls NahDb(), they are calling a factory constructor because it can be unnamed
  factory NahDb() => _instance;

  ///property to cache the database so that it doesn't reopen when called, static makes it lazy
  static Database? _db;

  ///lazy opening of the database
  ///check if the database is already open, assign a database if not, & return it
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase(dbName);
    return _db!;
  }

  ///Method to create the tables for the hymnals & hymns respectively
  Future<void> _createDB(Database db, int version) async {
    //create hymnal table
    await db.execute('''
      CREATE TABLE $hymnalTable (
        $hymnalId        INTEGER PRIMARY KEY,
        $hymnalTitle     TEXT NOT NULL,
        $hymnalLanguage  TEXT NOT NULL
      )
    ''');

    //create hymn table
    await db.execute('''
      CREATE TABLE $hymnTable (
        $hymnId      INTEGER NOT NULL,
        $hymnalId    INTEGER NOT NULL,
        $hymnTitle   TEXT NOT NULL,
        $hymnDetails TEXT,
        $lyrics      TEXT NOT NULL,

        PRIMARY KEY ($hymnId, $hymnalId),
        FOREIGN KEY ($hymnalId) REFERENCES $hymnalTable ($hymnalId) ON DELETE RESTRICT
      )
    ''');

    //Create hymn_collection table
    await db.execute('''
      CREATE TABLE $hymnCollectionTable (
        $hymnCollectionId          INTEGER PRIMARY KEY,
        $hymnCollectionTitle       TEXT NOT NULL,
        $hymnCollectionDescription TEXT,
        $hymnCollectionDatetime    DATETIME DEFAULT (DATETIME('now','localtime'))
      )
    ''');

    //create collection_hymn table
    await db.execute('''
      CREATE TABLE $collectionHymnTable (
         $hymnId INTEGER NOT NULL,
         $hymnalId INTEGER NOT NULL,
         $hymnCollectionId INTEGER NOT NULL,

         PRIMARY KEY ($hymnId, $hymnalId, $hymnCollectionId),
         FOREIGN KEY ($hymnId, $hymnalId) REFERENCES $hymnTable ($hymnId, $hymnalId) ON DELETE RESTRICT,
         FOREIGN KEY ($hymnCollectionId) REFERENCES $hymnCollectionTable ($hymnCollectionId) ON DELETE CASCADE
      )
     ''');
  }

  ///Method to open the database or create one
  Future<Database> _initDatabase(String fileName) async {
    ///first access the device storage files using sqflite
    final dbPath = await getDatabasesPath();

    ///the open database method by sqflite requires the path of the database
    ///Path package provides the correct format of representing the native path
    return openDatabase(
      join(dbPath, fileName),
      version: 1,

      ///oncreate allows creation of the database if opendatabase found a non existing database
      onCreate: (db, version) async => await _createDB(db, version),
      onOpen: (db) async {
        //Enable Foreign Keys whenever the database is opened. This willenable enforcement of foreign key relationship
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
  }

  //Method to insert hymnals into the database
  Future<void> insertHymnals(List<Hymnal> hymnals) async {
    final db = await database;
    final batch = db.batch();
    for (Hymnal hymnal in hymnals) {
      batch.rawInsert(
        'INSERT INTO $hymnalTable ($hymnalId, $hymnalTitle, $hymnalLanguage) VALUES (?, ?, ?)',
        [hymnal.id, hymnal.title, hymnal.language],
      );
    }
    await batch.commit(noResult: false);
  }

  //Method to querry hymnals from the database
}
