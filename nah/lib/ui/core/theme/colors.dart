import 'package:flutter/material.dart';

abstract final class AppColors {
  static const blue1 = Color(0xFF005290);
  static const blue2 = Color(0xFF0168B5);
  static const blue3 = Color(0xFF007BD8);
  static const blue4 = Color(0xFF0089F1);
  static const blue5 = Color(0xFF89BBDC);

  ///This is the [blue2] color with Alpha of 0.4
  static const blue2A0_4 = Color(0x660167B5);

  ///This is the [blue4] color with Alpha of 0.4
  static const blue4A0_4 = Color(0x660089F1);

  static const black = Color(0xFF000000);
  static const black1 = Color(0xFF212121);

  static const white = Color(0xFFFFFFFF);
  static const white1 = Color(0xFFCFD8DC);

  static const red = Color(0xFFF44336);

  static const lightColorScheme = ColorScheme.light(
    primary: AppColors.blue2,
    onPrimary: AppColors.black,
    secondary: AppColors.blue3,
    onSecondary: AppColors.black,
    tertiary: AppColors.blue4,
    onTertiary: AppColors.black,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.black,
    surfaceContainerLow: AppColors.blue4A0_4,
    surfaceContainerLowest: AppColors.blue2A0_4,
  );

  static const darkColorScheme = ColorScheme.dark(
    primary: AppColors.blue2,
    onPrimary: AppColors.white,
    secondary: AppColors.blue3,
    onSecondary: AppColors.white,
    tertiary: AppColors.blue4,
    onTertiary: AppColors.white,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.black,
    onSurface: AppColors.white,
    surfaceContainerLow: AppColors.blue4A0_4,
    surfaceContainerLowest: AppColors.blue2A0_4,
  );
}
