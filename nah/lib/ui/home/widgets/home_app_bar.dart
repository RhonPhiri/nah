import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/routing/routes.dart';
import 'package:nah/ui/core/theme/colors.dart';
import 'package:nah/ui/core/ui/my_sliver_app_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final color = isLightTheme ? AppColors.blue1 : null;
    return MySliverAppBar(
      title: title,
      leading: Builder(
        builder: (context) {
          // Menu icon button.
          return Center(
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(color),
              ),
              onPressed: () => handleDrawerButton(context),
              icon: Icon(Icons.menu),
            ),
          );
        },
      ),

      actions: ActionButtons.values
          .map(
            (button) => IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(color),
              ),
              onPressed: () => button.onPressed(context),
              icon: Icon(button.icon),
            ),
          )
          .toList(),
    );
  }

  /// Method to handle the opening & closing of the drawer.
  void handleDrawerButton(BuildContext context) {
    Scaffold.of(context).isDrawerOpen
        ? Scaffold.of(context).closeDrawer()
        : Scaffold.of(context).openDrawer();
  }
}

///Enum to hold the trailing action buttons of the hymnScreen appBar
enum ActionButtons {
  search,
  hymnal;

  IconData get icon {
    switch (this) {
      case ActionButtons.search:
        return Icons.search;
      case ActionButtons.hymnal:
        return Icons.book;
    }
  }

  void onPressed(BuildContext context) {
    switch (this) {
      case ActionButtons.search:
        // showSearch(
        //   context: context,
        //   delegate: SearchHymnDelegate(searchingHymnId: false),
        // );
        print("Search button pressed");
      case ActionButtons.hymnal:
        context.go(Routes.hymnals);
    }
  }
}
