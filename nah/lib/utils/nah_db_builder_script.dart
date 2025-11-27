import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'package:sqlite3/sqlite3.dart';

void main(List<String> args) {
  stderr.writeln("Running script");

  // Prefer working directory, but fall back to script location if necessary.
  var projectRoot = Directory.current.path;
  // If running from home or other unexpected cwd, try to derive from the script location.

  /// projectroot/assets
  final assetsDir = join(projectRoot, 'assets');

  /// projectroot/assets/hymnals/hymnals.json
  final hymnalsJsonPath = join(assetsDir, 'hymnals', 'hymnals.json');

  /// projectroot/assets/hymns
  final hymnsDir = join(assetsDir, 'hymns');

  /// projectroot/assets => Where the database will be placed
  final outDir = join(projectRoot, 'assets');

  /// projectroot/assets/nah_prebuilt.db
  final outFile = join(outDir, 'nah_prebuilt.db');

  // Ensure output directory exists so sqlite3 can create the DB file inside it.
  if (!Directory(outDir).existsSync()) {
    Directory(outDir).createSync(recursive: true);
  }

  // The [File] holds the path on which operations can performed
  // Also contains methods to manipulate a file
  // First, check if the file exists & delete it
  if (File(outFile).existsSync()) {
    stderr.writeln('Removing existing $outFile');
    File(outFile).deleteSync();
  }

  // Provides Dart bindings to SQLite via dart:ffi.
  try {
    final db = sqlite3.open(outFile);

    stderr.writeln("Opened sqlite3...");
    // enable foreign keys
    db.execute('PRAGMA foreign_keys = ON;');

    // create schema (
    db.execute('''
  CREATE TABLE hymnal (
    hymnal_id INTEGER PRIMARY KEY,
    hymnal_title TEXT NOT NULL,
    hymnal_language TEXT NOT NULL
  );
  ''');

    db.execute('''
      CREATE TABLE hymn (
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

    db.execute('''
  CREATE TABLE hymn_collection (
    hymn_collection_id INTEGER PRIMARY KEY,
    hymn_collection_title TEXT NOT NULL UNIQUE,
    hymn_collection_description TEXT
  );
  ''');

    db.execute('''
  CREATE TABLE hymn_bookmark (
    hymn_bookmark_id INTEGER PRIMARY KEY,
    hymn_bookmark_title TEXT NOT NULL,
    hymn_collection_id INTEGER NOT NULL,
    hymnal_id INTEGER NOT NULL,
    FOREIGN KEY (hymn_collection_id) REFERENCES hymn_collection (hymn_collection_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
    FOREIGN KEY (hymnal_id) REFERENCES hymnal (hymnal_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
  );
  ''');

    // load hymnals. Used the File().readAsStringSync() method because it is going to run outside the flutter engine; Dart CLI
    // Rootbundle.loadString(asset) is only available in flutter, for runtime flutter apps
    final hymnalsJson = File(hymnalsJsonPath).readAsStringSync();
    final hymnalsMapList = (jsonDecode(hymnalsJson) as List)
        .cast<Map<String, dynamic>>();

    stderr.writeln("Beginging transaction... 🥰");

    // transaction + prepared statements
    db.execute('BEGIN TRANSACTION;');

    /// Creating the hymnal table and populating it with hymnals
    final insertHymnal = db.prepare(
      'INSERT INTO hymnal (hymnal_id, hymnal_title, hymnal_language) VALUES (?, ?, ?);',
    );
    for (final map in hymnalsMapList) {
      final id = map['id'];
      final title = map['title'];
      final lang = map['language'];
      insertHymnal.execute([id, title, lang]);
    }
    insertHymnal.close();

    /// Creating the hymn table and populating it with hymns
    final insertHymn = db.prepare(
      'INSERT INTO hymn (hymn_id, hymn_title, hymn_details, hymn_lyrics, hymnal_id) VALUES (?, ?, ?, ?, ?);',
    );

    // For every hymnal, load a hymn json file from the assets
    for (final hymnal in hymnalsMapList) {
      final lang = hymnal['language'] as String;
      final hymnsPath = join(hymnsDir, '${lang.toLowerCase()}.json');

      // Checking if the file exists
      if (!File(hymnsPath).existsSync()) {
        stderr.writeln('WARNING: missing $hymnsPath :(');
        continue;
      }

      // Loading the hymn json file based on the language
      final hymnsJson = File(hymnsPath).readAsStringSync();
      final hymnsMapList = (jsonDecode(hymnsJson) as List)
          .cast<Map<String, dynamic>>();
      for (final h in hymnsMapList) {
        final id = h['id'];
        final title = h['title'];
        final details = jsonEncode(h['details']);
        final lyrics = jsonEncode(h['lyrics']);
        insertHymn.execute([id, title, details, lyrics, hymnal['id']]);
      }
    }
    insertHymn.close();

    db.execute('COMMIT;');
    stderr.writeln("Commited Transaction...");

    stderr.writeln("Creating Indices...");
    // create indexes after bulk insert
    db.execute(
      'CREATE INDEX IF NOT EXISTS idx_hymn_hymnal_id ON hymn (hymnal_id);',
    );
    db.execute(
      'CREATE INDEX IF NOT EXISTS idx_bookmark_collection_id ON hymn_bookmark (hymn_collection_id);',
    );

    db.close();
    stderr.writeln('Prebuilt DB written to $outFile');
  } on Exception catch (e, stackTrace) {
    stderr.writeln("Failed to open Database: $e\n$stackTrace");
  }
}

// // Method to run during database initialization; Copying the prebuilt database into the device
// Future<void> _ensurePrebuiltDbCopied(String destPath) async {
//   // Path on the device obtained using the getFatabasesPath() method & loading it itno FILE()
//   final destFile = File(destPath);
//   // Stop the function if the file laredy exists
//   if (await destFile.exists()) return;
//   // Since flutter is now running, rootbundle can now be used and loaded inform of bytes
//   final data = await rootBundle.load('assets/nah_prebuilt.db');
//   final bytes = data.buffer.asUint8List();
//   // Recursive true; Creates the file and libraries if not created yet
//   await destFile.create(recursive: true);
//   await destFile.writeAsBytes(bytes, flush: true);
// }

// To run the script, run; dart run lib/utils/nah_db_builder_script.dart
