import 'package:flutter/material.dart';

class HymnCollectionPage extends StatelessWidget {
  const HymnCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text("H Y M N  C O L L E C T I O N  P A G E"),
          ),
        ],
      ),
    );
  }
}
