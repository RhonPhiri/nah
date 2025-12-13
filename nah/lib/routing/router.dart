import 'package:go_router/go_router.dart';
import 'package:nah/routing/routes.dart';
import 'package:nah/ui/about/widgets/about_page.dart';
import 'package:nah/ui/home/widgets/home_screen.dart';
import 'package:nah/ui/hymn_collections/widgets/hymn_collection_page.dart';
import 'package:nah/ui/hymn_details/widgets/details_screen.dart';
import 'package:nah/ui/hymnals/widgets/hymnal_screen.dart';
import 'package:nah/ui/hymns/widgets/hymn_page.dart';
import 'package:provider/provider.dart';

GoRouter get router {
  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return HomeScreen(
            viewModel: context.read(),
            pages: [
              HymnPage(
                secondScreen: DetailsScreen(),
                thirdScreen: HymnalScreen(viewModel: context.read()),
              ),
              HymnCollectionPage(),
              AboutPage(),
            ],
          );
        },
        routes: [
          GoRoute(
            path: Routes.hymnals,
            builder: (context, state) {
              return HymnalScreen(viewModel: context.read());
            },
          ),
          GoRoute(
            path: Routes.details,
            builder: (context, state) {
              return DetailsScreen();
            },
          ),
        ],
      ),
    ],
  );
}
