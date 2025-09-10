import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(24, 0, 24, 24),
      child: Material(
        key: ValueKey("DrawerTileMaterial_$title"),
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          key: ValueKey("DrawerTileInkWell_$title"),
          onTap: onTap,
          splashColor: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            key: ValueKey("DrawerTileContainer_$title"),
            margin: const EdgeInsets.all(24),
            child: Row(
              children: [Icon(icon), const SizedBox(width: 16), Text(title)],
            ),
          ),
        ),
      ),
    );
  }
}
