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

/// Instantiating the get_it package
final getIt = GetIt.instance;

/// Method configuring the dependencies using get_it
void configureDependencies() {
  getIt.registerLazySingleton<DataService>(
    () => NahDbService(),
    onCreated: (instance) => debugPrint("NahDb DataService Created"),
    dispose: (param) => param.close(),
  );

  getIt.registerSingleton<SharedPrefService>(SharedPrefService());
}

final providers = [
  // TODO: Review the provider get it DI below
  Provider<HymnalRepository>(
    create: (context) => HymnalRepositoryDev(
      dataService: getIt<DataService>(),
      prefs: getIt<SharedPrefService>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => HymnalViewModel(hymnalRepository: context.read()),
  ),
  ChangeNotifierProvider<HomeViewModel>(create: (context) => HomeViewModel()),
];
