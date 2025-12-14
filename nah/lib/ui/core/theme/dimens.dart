import 'package:flutter/material.dart';

class Dimens {
  Dimens(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    isCompact = width < 600;
    isMedium = width >= 600 && width < 840;
    isExpanded = width >= 840 && width < 1200;
    isLarge = width >= 1200 && width < 1600;
    isExtraLarge = width >= 1600;
  }
  late bool isCompact;
  late bool isMedium;
  late bool isExpanded;
  late bool isLarge;
  late bool isExtraLarge;
}
