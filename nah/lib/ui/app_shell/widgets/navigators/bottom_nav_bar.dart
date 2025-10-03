import 'package:flutter/material.dart';
import 'package:nah/ui/app_shell/widgets/navigators/nav_items.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIdx,
    required this.onDestinationSelected,
  });

  final int selectedIdx;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: NavItems.values
          .map<NavigationDestination>(
            (item) => NavigationDestination(icon: item.icon, label: item.label),
          )
          .toList(),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(4),
      ),
      selectedIndex: selectedIdx,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
