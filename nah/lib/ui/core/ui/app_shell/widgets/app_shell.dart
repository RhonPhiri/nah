import 'package:flutter/material.dart';
import 'package:nah/routing/delegate/inner_router_delegate.dart';
import 'package:nah/ui/core/ui/app_shell/view_model/app_state.dart';
import 'package:nah/ui/core/ui/app_shell/widgets/navigators/bottom_nav_bar.dart';
import 'package:nah/ui/core/ui/app_shell/widgets/navigators/nav_rail.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.appState});
  final AppState appState;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late InnerRouterDelegate _routerDelegate;
  late ChildBackButtonDispatcher _buttonDispatcher;

  static const double compact = 600.0;
  static const double medium = 840.0;
  static const double large = 1200.0;
  static const double extraLarge = 1600.0;

  bool isCompact = false;
  bool isMedium = false;
  bool isExpanded = false;
  bool isLarge = false;
  bool isExtraLarge = false;

  @override
  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.sizeOf(context).width;
    isCompact = width < compact;
    isMedium = width >= compact && width < medium;
    isExpanded = width >= medium && width < large;
    isLarge = width >= large && width < extraLarge;
    isExtraLarge = width >= extraLarge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (isMedium || isExpanded || isLarge || isExtraLarge)
            NavRail(
              key: ValueKey("APP_SHELL_NAVIGATION_RAIL"),
              isExtended: isLarge || isExtraLarge,
              selectedIdx: widget.appState.selectedIdx,
              onDestinationSelected: widget.appState.updateSelectedIdx,
            ),
          Expanded(
            flex: isExtraLarge ? 2 : 1,
            child: Container(
              color: Colors.amber,
              child: Center(child: Text("Hymns")),
            ),
          ),
          if (isExpanded || isLarge || isExtraLarge)
            Expanded(
              flex: isExtraLarge ? 3 : 1,
              child: Container(
                color: Colors.lightBlue,
                child: Center(child: Text("Hymn Details")),
              ),
            ),
          if (isExtraLarge)
            Expanded(
              flex: isExtraLarge ? 2 : 1,
              child: Container(
                color: Colors.green,
                child: Center(child: Text("Hymnals")),
              ),
            ),
        ],
      ),
      // body: Router(routerDelegate: _routerDelegate),
      bottomNavigationBar: isCompact
          ? BottomNavBar(
              selectedIdx: widget.appState.selectedIdx,
              onDestinationSelected: widget.appState.updateSelectedIdx,
            )
          : SizedBox.shrink(),
    );
  }
}
