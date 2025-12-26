import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/ui/about/widgets/about_page.dart';
import 'package:nah/ui/home/widgets/home_shell.dart';
import 'package:nah/ui/hymn_collection/widgets/hymn_collection_page.dart';
import 'package:nah/ui/hymn_details/widgets/details_screen.dart';
import 'package:nah/ui/hymnal/viewmodel/hymnal_view_model.dart';
import 'package:nah/ui/hymnal/widgets/hymnal_screen.dart';
import 'package:nah/ui/hymn/viewmodel/hymn_view_model.dart';
import 'package:nah/ui/hymn/widgets/hymn_page.dart';
import 'package:provider/provider.dart';

typedef HymnAndViewModel = ({Hymn hymn, HymnViewModel viewModel});

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "root",
);

final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "sectionANav");

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,

  navigatorKey: _rootNavigatorKey,

  initialLocation: "/",

  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/hymnals",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: HymnalScreen(viewModel: context.read()),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCirc,
              ),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 560),
          reverseTransitionDuration: Duration(milliseconds: 560),
        );
      },
    ),
    StatefulShellRoute(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/hymns",
              builder: (context, state) {
                return HymnPage(
                  viewModel: context.read(),
                  secondScreen: DetailsScreen(viewModel: context.read()),
                  thirdScreen: HymnalScreen(viewModel: context.read()),
                );
              },
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: "details",
                  builder: (context, state) {
                    return DetailsScreen(viewModel: context.read());
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/hymn_collections",
              builder: (context, state) {
                return HymnCollectionPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/about",
              builder: (context, state) {
                return AboutPage();
              },
            ),
          ],
        ),
      ],

      /// Intending to build a custom navigation shell container with a pageview
      navigatorContainerBuilder: (context, navigationShell, children) {
        return HomeShell(navigationShell: navigationShell, children: children);
      },

      /// Returning the whole navigation shell which has been prebuilt
      builder: (context, state, navigationShell) {
        return navigationShell;
      },
    ),

    /// Redirect to the hymn screen upon
    GoRoute(path: "/", redirect: (context, state) => "/hymnals"),
  ],
);
