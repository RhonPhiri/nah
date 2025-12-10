import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/data/services/db/nah_db_service.dart';
import 'package:nah/data/services/shared_pref_service.dart';
import 'package:nah/ui/home/view_model/home_view_model.dart';
import 'package:nah/ui/hymnals/view_model/hymnal_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Instantiating the get_it package
final getIt = GetIt.instance;

/// Method configuring the dependencies using get_it
Future<void> configureDependencies() async {
  // Registering the database using the lazy singleton soo that it is only instantiated once
  getIt.registerSingletonAsync<DataService>(
    () async {
      final db = NahDbService();
      await db.database;
      return db;
    },
    onCreated: (instance) => debugPrint("NahDb DataService Created"),
    dispose: (db) => db.close(),
  );

  await getIt.isReady<DataService>();

  getIt.registerSingleton<SharedPrefService>(SharedPrefService());

  getIt.registerFactory<HymnalRepository>(
    () => HymnalRepositoryDev(
      dataService: getIt<DataService>(),
      prefs: getIt<SharedPrefService>(),
    ),
  );
}

List<SingleChildWidget> get providers {
  return [
    ChangeNotifierProvider<HomeViewModel>(create: (context) => HomeViewModel()),

    ChangeNotifierProvider<HymnalViewModel>(
      create: (context) =>
          HymnalViewModel(hymnalRepository: getIt<HymnalRepository>()),
    ),
  ];
}
