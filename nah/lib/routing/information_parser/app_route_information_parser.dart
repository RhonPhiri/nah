import 'package:flutter/material.dart';
import 'package:nah/routing/path/app_route_path.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == "about") {
      return AboutScreenPath();
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == "collections") {
      return HymnCollectionScreenPath();
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == "hymns") {
      return HymnScreenPath();
    } else {
      return UnknownScreenPath();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration is AboutScreenPath) {
      return RouteInformation(uri: Uri.parse("/about"));
    }
    if (configuration is HymnCollectionScreenPath) {
      return RouteInformation(uri: Uri.parse("/collections"));
    }
    if (configuration is HymnScreenPath) {
      return RouteInformation(uri: Uri.parse("/hymns"));
    }
    return null;
  }
}
