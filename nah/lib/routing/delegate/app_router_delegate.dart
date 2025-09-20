import 'package:flutter/material.dart';
import 'package:nah/routing/path/app_route_path.dart';
import 'package:nah/ui/core/ui/app_shell/view_model/app_state.dart';
import 'package:nah/ui/core/ui/app_shell/widgets/app_shell.dart';
import 'package:nah/ui/error/widgets/unkown_screen.dart';

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
  AppRoutePath? get currentConfiguration {
    // if (appState.selectedIdx == 2) {
    //   return AboutScreenPath();
    // } else if (appState.selectedIdx == 1) {
    //   return HymnCollectionScreenPath();
    // } else if (appState.selectedIdx == 0) {
    //   return HymnScreenPath();
    // } else {
    //   return UnknownScreenPath();
    // }

    switch (appState.selectedIdx) {
      case 2:
        return AboutScreenPath();
      case 1:
        return HymnCollectionScreenPath();
      case 0:
        return HymnScreenPath();
      default:
        return UnknownScreenPath();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        // This is the "/" page
        MaterialPage(
          key: ValueKey("APP_SHELL_PAGE"),
          child: AppShell(appState: appState),
        ),
        if (appState.show404)
          MaterialPage(
            key: ValueKey("UNKNOWN_SCREEN_PAGE"),
            child: UnkownScreen(),
          ),
      ],
      onDidRemovePage: (page) {
        // On popping from the Error "Unknown" Screen, set the tab to home
        appState
          ..updateSelectedIdx(0)
          ..updateShow404(false);

        // notifyListeners();
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    // if (path is UnknownScreenPath) {
    //   appState.updateShow404(true);
    //   return;
    // }
    // if (path is AboutScreenPath) {
    //   appState.updateSelectedIdx(2);
    // } else if (path is HymnCollectionScreenPath) {
    //   appState.updateSelectedIdx(1);
    // } else if (path is HymnScreenPath) {
    //   appState.updateSelectedIdx(0);
    // }

    switch (path) {
      case UnknownScreenPath():
        appState.updateShow404(true);
        break;
      case AboutScreenPath():
        appState.updateSelectedIdx(2);
      case HymnCollectionScreenPath():
        appState.updateSelectedIdx(1);
      case HymnScreenPath():
        appState.updateSelectedIdx(0);
    }

    appState.updateShow404(false);
  }
}
