import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nah/config/dependencies.dart';
import 'package:nah/routing/router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the Db & the Shared Preferences
  await configureDependencies();
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.blueGrey,
        ),
      ),
      themeMode: ThemeMode.light,
    );
  }
}
