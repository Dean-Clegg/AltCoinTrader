import 'package:flutter/material.dart';
import 'package:altcointrader/barrel_file.dart';

class ACTThemes {
  final AppColorTheme selectedTheme;

  ACTThemes(this.selectedTheme);

  ThemeData get(BuildContext context) {
    AppTheme themes = selectedTheme.theme;
    AppTextTheme textStyles = selectedTheme.textStyles;
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, scrolledUnderElevation: 0),
      splashColor: themes.primary.withValues(alpha: 0.5),
      scaffoldBackgroundColor: themes.background,
      primaryColor: themes.primary,
      disabledColor: themes.disabled,
      colorScheme: Theme.of(context).colorScheme.copyWith(primary: themes.primary, secondary: themes.secondary, error: themes.error),
      textTheme: TextTheme(
        titleLarge: textStyles.text1,
        titleMedium: textStyles.text2,
        titleSmall: textStyles.text3,
        bodyLarge: textStyles.text4,
        bodyMedium: textStyles.text4,
        bodySmall: textStyles.text5,
        displayLarge: textStyles.text4,
        displayMedium: textStyles.text4,
        displaySmall: textStyles.text4,
        headlineLarge: textStyles.text4,
        headlineMedium: textStyles.text4,
        headlineSmall: textStyles.text4,
        labelLarge: textStyles.text4,
        labelMedium: textStyles.text4,
        labelSmall: textStyles.text4,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(themes.sizes.buttonRadius))),
          enableFeedback: true,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) return themes.disabled;
            if (states.contains(WidgetState.hovered)) return Colors.transparent;
            return Colors.transparent;
          }),
          shadowColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) return Colors.transparent;
            if (states.contains(WidgetState.hovered)) return Colors.transparent;
            return Colors.transparent;
          }),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(themes.sizes.buttonRadius))),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) return themes.buttonPrimary;
            return themes.buttonSecondary;
          }),
          side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
            return BorderSide(color: themes.tile, width: 1);
          }),
          foregroundColor: WidgetStateProperty.all(themes.textColors.button),
        ),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: themes.drawer),
      iconTheme: IconThemeData(color: themes.icon),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: WidgetStateProperty.all(themes.icon))),
      dialogTheme: DialogThemeData(backgroundColor: themes.background),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: themes.tileSecondary,
        labelStyle: textStyles.text3,
        floatingLabelStyle: textStyles.text2,
        hintStyle: textStyles.text5.copyWith(color: themes.textColors.hint),
        errorStyle: textStyles.text4ER,
        helperStyle: textStyles.text4.copyWith(fontSize: 13),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themes.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themes.error, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themes.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themes.border, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themes.disabled, width: 0.4),
        ),
        isDense: true,
        filled: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: themes.navigation, selectedItemColor: themes.icon, unselectedItemColor: themes.icon.withValues(alpha: 0.5), elevation: 0),
      listTileTheme: ListTileThemeData(dense: true, iconColor: themes.icon, contentPadding: EdgeInsets.zero),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textStyles.text4,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: themes.tileSecondary,
          filled: true,
          isDense: true,
          iconColor: themes.icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: themes.border, width: 1),
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(themes.tile),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: themes.border, width: 1),
            ),
          ),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(thumbColor: WidgetStateProperty.all(themes.scrollColor.withValues(alpha: 0.5))),
    );
  }
}
