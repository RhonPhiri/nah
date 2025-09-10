/// [Routes] keeping route constants
abstract final class Routes {
  //OBSERVATIONS: if a GoRouter is the highest, its path starts with "/"
  //While if a GoRouter is a child route, it doesn'r start with "/"
  //The relative path is the one passed in the context
  //
  //Names
  static const home = "home";
  static const onBoarding = "onBoarding";
  static const hymnals = "hymnals";

  //Paths
  static const onBoardingPath = "/onBoarding";
  static const homePath = "/";
  static const hymnalsPath = hymnals;

  //Relative Path
  static const hymnalRelativePath = "/$hymnals";
}
