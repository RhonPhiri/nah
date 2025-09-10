import 'package:flutter/material.dart';
import 'package:nah/config/dependencies.dart';
import 'package:nah/main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: devProviders, child: const MyApp()));
}
