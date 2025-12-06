import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HymnPage extends StatelessWidget {
  const HymnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text("Hymnal Title"),
            scrolledUnderElevation: 0,
            elevation: 0,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),

              IconButton(
                onPressed: () => context.go("/hymnals"),
                icon: Icon(Icons.menu_book),
              ),
            ],
          ),
          SliverList.builder(
            itemCount: 50,
            itemBuilder: (context, index) =>
                ListTile(title: Text("Tile"), onTap: () {}),
          ),
        ],
      ),
    );
  }
}
