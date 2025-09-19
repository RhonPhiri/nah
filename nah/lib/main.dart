import 'package:flutter/material.dart';
import 'package:nah/config/dependencies.dart';
import 'package:nah/routing/delegate/app_router_delegate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.blue,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.blue,
        ),
      ),
      themeMode: ThemeMode.light,
      routerDelegate: AppRouterDelegate(context.read()),
    );
  }
}
