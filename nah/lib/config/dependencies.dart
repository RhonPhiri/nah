import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/data/services/dev/dev_data_service.dart';

/// Instantiating the get_it package
final getIt = GetIt.instance;

/// Method configuring the dependencies using get_it
void configureDevDependencies() {
  getIt.registerLazySingleton<DataService>(
    () => DevDataService(),
    onCreated: (instance) => debugPrint("Dev DataService Created"),
    dispose: (param) => param.close(),
  );
}
