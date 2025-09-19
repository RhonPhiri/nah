import 'package:flutter/material.dart';
import 'package:nah/routing/path/app_route_path.dart';
import 'package:nah/ui/about/about_screen.dart';
import 'package:nah/ui/core/ui/app_shell/view_model/app_state.dart';
import 'package:nah/ui/error/widgets/unkown_screen.dart';
import 'package:nah/ui/hymn/hymn_screen.dart';
import 'package:nah/ui/hymn_collections/hymn_collection_screen.dart';

/// [InnerRouterDelegate] is taken up by the [AppRouterDelegate]
/// Using the selected tab index, determines the screen to be shown between [HymnScreen], [HymnCollectionScreen] or [AboutScreen]
/// No need to implement the [setNewRoutePath] because this has been handled in the [AppRouterDelegate] and does not parse [Route]
class InnerRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  AppState _appState;

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  InnerRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        switch (_appState.selectedIdx) {
          0 => MaterialPage(key: ValueKey("HYMN_SCREEN"), child: HymnScreen()),
          1 => MaterialPage(
            key: ValueKey("HYMN_COLLECTION_SCREEN"),
            child: HymnCollectionScreen(),
          ),
          2 => MaterialPage(
            key: ValueKey("ABOUT_SCREEN"),
            child: AboutScreen(),
          ),
          _ => MaterialPage(child: UnkownScreen()),
        },
      ],
      onDidRemovePage: (page) {},
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}
