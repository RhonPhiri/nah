import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/data/services/db/nah_db_service.dart';
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
}

final providers = [
  // TODO: Review the provider get it DI below
  Provider(
    create: (context) =>
        HymnalRepositoryDev(dataService: getIt.get<NahDbService>()),
  ),
  ChangeNotifierProvider(
    create: (context) => HymnalViewModel(hymnalRepository: context.read()),
  ),
  ChangeNotifierProvider<HomeViewModel>(create: (context) => HomeViewModel()),
];
