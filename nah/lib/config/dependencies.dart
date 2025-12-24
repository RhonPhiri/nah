import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/data/repositories/hymn/hymn_repository_dev.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/data/services/db/nah_db_service.dart';
import 'package:nah/data/services/shared_pref_service.dart';
import 'package:nah/ui/hymns/viewmodel/hymn_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Instantiating the get_it package
final getIt = GetIt.instance;

/// Method configuring services using get_it
Future<void> configureDependencies() async {
  // Registering the database using the lazy singleton soo that it is only instantiated once
  getIt.registerSingletonAsync<DataService>(
    () async {
      // Instantiate the Db
      final db = NahDbService();

      // Opening the Db
      await db.database;
      return db;
    },
    onCreated: (instance) => debugPrint("NahDb DataService Created"),
    dispose: (db) => db.close(),
  );

  // Force the asyncronous DataService register to be run before accessed
  await getIt.isReady<DataService>();

  // Registering the SharedPrefService
  getIt.registerFactory<SharedPrefService>(() => SharedPrefService());
}

List<SingleChildWidget> get providers {
  return [
    // Repositories
    Provider<HymnalRepository>(
      create: (context) => HymnalRepositoryDev(
        dataService: getIt<DataService>(),
        prefs: getIt<SharedPrefService>(),
      ),
    ),

    Provider<HymnRepository>(
      create: (context) => HymnRepositoryDev(dataService: getIt<DataService>()),
    ),

    ChangeNotifierProvider(
      create: (context) => HymnViewModel(
        hymnRepository: context.read(),
        hymnalRepository: context.read(),
      ),
    ),
  ];
}
