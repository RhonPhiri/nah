import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/data/repository/on_boarding/on_boarding_repository.dart';
import 'package:nah/routing/routes.dart';
import 'package:nah/ui/home/view_models/home_view_model.dart';
import 'package:nah/ui/home/widgets/home_screen.dart';
import 'package:nah/ui/hymnal/widgets/hymnal_screen.dart';
import 'package:nah/ui/on_boarding/view_model/on_boarding_view_model.dart';
import 'package:nah/ui/on_boarding/widgets/on_boarding_screen.dart';
import 'package:provider/provider.dart';

GoRouter router(OnBoardingRepository useStatusRepository) => GoRouter(
  debugLogDiagnostics: true,
  initialLocation: Routes.homePath,
  redirect: _redirect,
  //This is to influence the go_router package to re-eveluate the redirect logic
  //Whether it's on the correct route or not.
  //Doesn't automatically perform the navigation
  refreshListenable: useStatusRepository,
  routes: [
    GoRoute(
      path: Routes.onBoardingPath,
      builder: (context, state) {
        final viewModel = OnBoardingViewModel(
          hymnalRepository: context.read(),
          useStatusRepository: context.read(),
        );
        return OnBoardingScreen(onBoardingViewModel: viewModel);
      },
    ),
    GoRoute(
      path: Routes.homePath,
      builder: (context, state) {
        final viewModel = HomeViewModel(loadHymnUseCase: context.read());
        return HomeScreen(homeViewModel: viewModel);
      },
      routes: [
        GoRoute(
          path: Routes.hymnalsPath,
          builder: (context, state) => HymnalScreen(),
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // Get the use status of the user.
  final isFirstTime = await context
      .read<OnBoardingRepository>()
      .isInitialLaunch;

  // Varibale to hold the current state, if the user has selected a hymnal and stored the hymnal language
  // but is still on the startup hymnal page
  final isEnteringApp = state.matchedLocation == Routes.hymnalsPath;

  if (isFirstTime) {
    return Routes.onBoardingPath;
  }

  if (isEnteringApp) {
    return Routes.homePath;
  }

  //If no need to redrect
  return null;
}
