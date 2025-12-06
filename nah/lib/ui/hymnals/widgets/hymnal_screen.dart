import 'package:flutter/material.dart';

class HymnalScreen extends StatelessWidget {
  const HymnalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [SliverAppBar.medium(title: Text("H Y M N A L  S C R E E N"))],
      ),
    );
  }
}
