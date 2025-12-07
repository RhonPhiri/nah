import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/routing/routes.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) context.go(Routes.home);
      },
      child: Scaffold(
        appBar: AppBar(title: Text("H Y M N  D E T A I L S")),
        body: Center(child: Container(color: Colors.amber)),
      ),
    );
  }
}
