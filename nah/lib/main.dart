import 'package:flutter/material.dart';
import 'package:nah/config/dependencies.dart';
import 'package:nah/routing/router.dart';
import 'package:provider/provider.dart';

void main() {
  configureDependencies();
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      themeMode: ThemeMode.light,
    );
  }
}
