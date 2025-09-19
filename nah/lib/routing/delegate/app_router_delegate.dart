import 'package:flutter/material.dart';
import 'package:nah/routing/path/app_route_path.dart';
import 'package:nah/ui/core/ui/app_shell/view_model/app_state.dart';
import 'package:nah/ui/core/ui/app_shell/widgets/app_shell.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  @override
  GlobalKey<NavigatorState> navigatorKey;

  AppState appState;

  AppRouterDelegate(this.appState)
    : navigatorKey = GlobalKey<NavigatorState>() {
    // Notify all app listeners of changes
    appState.addListener(notifyListeners);
  }

  @override
  AppRoutePath? get currentConfiguration {}

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        // This is the "/" page
        MaterialPage(
          key: ValueKey("APP_SHELL"),
          child: AppShell(appState: appState),
        ),
      ],
      onDidRemovePage: (page) {},
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {}
}
