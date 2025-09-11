import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/routing/routes.dart';
import 'package:nah/ui/core/theme/colors.dart';
import 'package:nah/ui/core/ui/my_sliver_app_bar.dart';
import 'package:nah/ui/home/view_models/home_view_model.dart';
import 'package:nah/ui/home/widgets/search/search_hymn_delegate.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.homeViewModel});
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final color = isLightTheme ? AppColors.blue1 : null;
    return MySliverAppBar(
      key: ValueKey("HOME_APP_BAR"),
      title: homeViewModel.hymnalTitle,
      leading: Builder(
        builder: (context) {
          // Menu icon button.
          return Center(
            child: IconButton(
              key: ValueKey("HOME_APP_BAR_MENU"),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(color),
              ),
              onPressed: () => handleDrawerButton(context),
              icon: Icon(Icons.menu),
            ),
          );
        },
      ),

      actions: [
        IconButton(
          key: ValueKey("HOME_SEARCH_CUTTON"),
          onPressed: () => showSearch(
            context: context,
            delegate: SearchHymnDelegate(
              searchingHymnId: false,
              homeViewModel: homeViewModel,
            ),
          ),
          icon: Icon(Icons.search),
        ),
        IconButton(
          key: ValueKey("HOME_HYMNAL_BUTTON"),
          onPressed: () => context.go(Routes.hymnalRelativePath),
          icon: Icon(Icons.book),
        ),
      ],
    );
  }

  /// Method to handle the opening & closing of the drawer.
  void handleDrawerButton(BuildContext context) {
    Scaffold.of(context).isDrawerOpen
        ? Scaffold.of(context).closeDrawer()
        : Scaffold.of(context).openDrawer();
  }
}
