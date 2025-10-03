/// [AppLayout] defines the screen size limits
class AppLayout {
  static const double cLimit = 600.0; // compact
  static const double mLimit = 840.0; // medium
  static const double largeLimit = 1200.0; //large
  static const double xLargeLimit = 1600.0; // extraLarge

  final bool isCompact;
  final bool isMedium;
  final bool isExpanded;
  final bool isLarge;
  final bool isExtraLarge;

  AppLayout(double width)
    : isCompact = width < cLimit,
      isMedium = width >= cLimit && width < mLimit,
      isExpanded = width >= mLimit && width < largeLimit,
      isLarge = width >= largeLimit && width < xLargeLimit,
      isExtraLarge = width >= xLargeLimit;
}
