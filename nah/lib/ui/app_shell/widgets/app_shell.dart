import 'package:flutter/material.dart';
import 'package:nah/routing/delegate/inner_router_delegate.dart';
import 'package:nah/utils/app_layout.dart';
import 'package:nah/ui/app_shell/view_model/app_state.dart';
import 'package:nah/ui/app_shell/widgets/navigators/bottom_nav_bar.dart';
import 'package:nah/ui/app_shell/widgets/navigators/nav_rail.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.appState});
  final AppState appState;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late InnerRouterDelegate _routerDelegate;
  late ChildBackButtonDispatcher _buttonDispatcher;

  @override
  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);
  }

  @override
  Widget build(BuildContext context) {
    final layout = AppLayout(MediaQuery.sizeOf(context).width);
    return Scaffold(
      body: Row(
        children: [
          if (layout.isMedium ||
              layout.isExpanded ||
              layout.isLarge ||
              layout.isExtraLarge)
            NavRail(
              key: ValueKey("APP_SHELL_NAVIGATION_RAIL"),
              isExtended: layout.isLarge || layout.isExtraLarge,
              selectedIdx: widget.appState.selectedIdx,
              onDestinationSelected: widget.appState.updateSelectedIdx,
            ),
          Flexible(
            fit: FlexFit.loose,
            child: Router(routerDelegate: _routerDelegate),
          ),
        ],
      ),
      // body: Router(routerDelegate: _routerDelegate),
      bottomNavigationBar: layout.isCompact
          ? BottomNavBar(
              key: ValueKey("APP_SHELL_BOTTOM_NAVIGATION_BAR"),
              selectedIdx: widget.appState.selectedIdx,
              onDestinationSelected: widget.appState.updateSelectedIdx,
            )
          : SizedBox.shrink(key: ValueKey("APP_SHELL_BOTTOM_SIZED_BOX")),
    );
  }
}
