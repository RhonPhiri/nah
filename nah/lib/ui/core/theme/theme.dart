import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nah/ui/core/theme/colors.dart';

abstract final class AppTheme {
  static ThemeData light() {
    return ThemeData(
      appBarTheme: _Shared.appBarTheme(true),
      bottomSheetTheme: _Shared.botSheetTheme(true),
      colorScheme: AppColors.lightColorScheme,
      dividerTheme: _Shared.dividerThemeData(true),
      drawerTheme: _Shared.drawerThemeData(true),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: AppColors.white,
      ),
      sliderTheme: _Shared.sliderTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      appBarTheme: _Shared.appBarTheme(false),
      bottomSheetTheme: _Shared.botSheetTheme(false),
      colorScheme: AppColors.darkColorScheme,
      dialogTheme: DialogThemeData(backgroundColor: AppColors.black1),
      dividerTheme: _Shared.dividerThemeData(false),
      drawerTheme: _Shared.drawerThemeData(false),
      sliderTheme: _Shared.sliderTheme,
    );
  }
}

abstract final class _Shared {
  /// Returns a shared AppBarTheme based on the given brightness.
  /// This method ensures consistent styling for app bars in both light and dark themes.
  static AppBarTheme appBarTheme(bool isLightTheme) {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: isLightTheme ? AppColors.blue2 : AppColors.black,
      foregroundColor: AppColors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: AppColors.white1,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        // statusBarIconBrightness: isLightTheme
        //     ? Brightness.dark
        //     : Brightness.light,
        // statusBarColor: color,
        systemNavigationBarColor: isLightTheme
            ? AppColors.blue1
            : AppColors.black,
      ),
    );
  }

  /// Returns a shared SliderThemeData so that the text color is maintained in both light & dark modes
  static const SliderThemeData sliderTheme = SliderThemeData(
    valueIndicatorTextStyle: TextStyle(color: AppColors.white),
  );

  /// returns a shared DivderThemeData depending on the brightness
  static DividerThemeData dividerThemeData(bool isLightTheme) =>
      DividerThemeData(
        thickness: 1,
        color: isLightTheme ? AppColors.white1 : AppColors.black1,
      );

  static DrawerThemeData drawerThemeData(bool isLightTheme) => DrawerThemeData(
    backgroundColor: isLightTheme ? AppColors.white1 : AppColors.blue2,
  );

  static BottomSheetThemeData botSheetTheme(bool isLightTheme) =>
      BottomSheetThemeData(
        modalBackgroundColor: isLightTheme
            ? AppColors.white1
            : AppColors.black1,
      );
}
