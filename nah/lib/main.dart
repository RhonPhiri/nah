import 'package:flutter/material.dart';
import 'package:nah/routing/router.dart';
import 'package:nah/ui/core/theme/theme.dart';
import 'package:provider/provider.dart';
import 'main_development.dart' as dev;

void main() {
  dev.main();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router(context.read()),
    );
  }
}
