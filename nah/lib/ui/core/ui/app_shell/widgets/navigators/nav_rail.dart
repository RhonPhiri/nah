import 'package:flutter/material.dart';
import 'package:nah/ui/core/ui/app_shell/widgets/navigators/nav_items.dart';

class NavRail extends StatelessWidget {
  const NavRail({
    super.key,
    // required this.fab,
    required this.selectedIdx,
    required this.onDestinationSelected,
    required this.isExtended,
  });
  // final Widget fab;
  final int selectedIdx;
  final bool isExtended;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      leading: Column(
        children: [
          SizedBox(height: 24),
          isExtended
              ? FloatingActionButton.extended(
                  extendedIconLabelSpacing: 16,
                  icon: Icon(Icons.dialpad_rounded),
                  onPressed: () {},
                  label: Text("Hymn Id"),
                )
              : FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.dialpad_rounded),
                ),
        ],
      ),
      groupAlignment: -0.95,
      labelType: isExtended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.selected,
      destinations: NavItems.values
          .map<NavigationRailDestination>(
            (item) => NavigationRailDestination(
              padding: EdgeInsets.only(top: isExtended ? 32 : 16),
              icon: item.icon,
              label: Text(item.label),
            ),
          )
          .toList(),
      selectedIndex: selectedIdx,
      selectedLabelTextStyle: TextStyle(
        fontWeight: FontWeight.w900,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onDestinationSelected: onDestinationSelected,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(4),
      ),
      extended: isExtended,
    );
  }
}
