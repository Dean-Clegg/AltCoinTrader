import 'package:altcointrader/cubits/theme/theme_cubit.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final AppTextColors textColors;
  final AppSizes sizes;
  final Color primary;
  final Color secondary;
  final Color background;
  final Color icon;
  final Color tile;
  final Color tileSecondary;
  final Color warning;
  final Color disabled;
  final Color error;
  final Color green;
  final Color border;
  final Color drawer;
  final Color grey;
  final Color navigation;
  final Color white;
  final Color white_20;
  final Color white_50;
  final Color white_06;
  final Color info;
  final Color selected;
  final Color buttonPrimary;
  final Color buttonSecondary;
  final Color buttonDisabled;
  final Color oppositeBackground;
  final Color scrollColor;

  const AppTheme({
    required this.primary,
    required this.icon,
    required this.secondary,
    required this.background,
    required this.textColors,
    required this.sizes,
    required this.tile,
    required this.tileSecondary,
    required this.disabled,
    required this.error,
    required this.green,
    required this.border,
    required this.drawer,
    required this.warning,
    required this.grey,
    required this.navigation,
    required this.white,
    required this.white_20,
    required this.white_50,
    required this.white_06,
    required this.info,
    required this.selected,
    required this.buttonPrimary,
    required this.buttonSecondary,
    required this.buttonDisabled,
    required this.oppositeBackground,
    required this.scrollColor,
  });
}

class AppTextColors {
  final Color body;
  final Color hint;
  final Color error;
  final Color link;
  final Color button;
  final Color supportInfo;
  final Color orange;

  const AppTextColors({required this.body, required this.hint, required this.error, required this.link, required this.button, required this.supportInfo, required this.orange});
}

class AppSizes {
  final double buttonRadius;

  const AppSizes({required this.buttonRadius});
}

class AppTextTheme {
  final TextStyle text1;
  final TextStyle text2;
  final TextStyle text3;
  final TextStyle text4;
  final TextStyle text5;
  final TextStyle text6;
  final TextStyle text7;
  final TextStyle text1B;
  final TextStyle text2B;
  final TextStyle text3B;
  final TextStyle text4B;
  final TextStyle text5B;
  final TextStyle text6B;
  final TextStyle text7B;
  final TextStyle text4ER;
  final TextStyle text6W_20;
  final TextStyle text7O;
  final TextStyle text6O;
  final TextStyle text6W_50;
  final TextStyle text7W_50;
  final TextStyle text5BW_50;
  final TextStyle text8O;
  final TextStyle text8W_50;

  const AppTextTheme({
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.text7,
    required this.text1B,
    required this.text2B,
    required this.text3B,
    required this.text4B,
    required this.text5B,
    required this.text6B,
    required this.text7B,
    required this.text4ER,
    required this.text6W_20,
    required this.text7O,
    required this.text6O,
    required this.text6W_50,
    required this.text7W_50,
    required this.text5BW_50,
    required this.text8O,
    required this.text8W_50,
  });
}

extension AppColorThemes on AppColorTheme {
  AppTheme get theme {
    switch (this) {
      case AppColorTheme.dark:
        return AppTheme(
          primary: const Color(0xFF52C0F8),
          secondary: const Color(0xFF958800),
          background: const Color(0xFF0A0F1E),
          disabled: const Color(0xff808080),
          icon: const Color(0xffffffff),
          textColors: const AppTextColors(
            body: Color(0xffffffff),
            hint: Color(0xff808080),
            error: Color(0xffff0000),
            link: Color(0xff5a8bb2),
            button: Color(0xFF000000),
            supportInfo: Color(0xFFB8860B),
            orange: Color(0xFFFFA500),),

          sizes: const AppSizes(buttonRadius: 24),
          error: const Color(0xffff0000),
          green: const Color(0xff00ff00),
          tile: const Color(0xFF1E1E1E),
          tileSecondary: const Color(0xFF2C2C2C),
          border: const Color(0x1AA8B9FF),
          drawer: const Color(0xFF1E1E1E),
          warning: const Color(0xFFFFA500),
          grey: const Color(0xff808080),
          navigation: const Color(0xFF1E1E1E),
          white: const Color(0xffffffff),
          white_20: const Color(0xffffffff).withValues(alpha: 0.2),
          white_50: const Color(0xffffffff).withValues(alpha: 0.5),
          white_06: const Color(0xffffffff).withValues(alpha: 0.06),
          info: Color(0xFFA8B9FF).withValues(alpha: 0.10),
          selected: Color(0xff15ffab),
          buttonPrimary: const Color(0xFF52C0F8),
          buttonSecondary: const Color(0xFF7C62A6),
          buttonDisabled: const Color(0x1AA8B9FF),
          oppositeBackground: const Color(0xffffffff),
          scrollColor: const Color(0xffffffff),
        );
      case AppColorTheme.light:
        return AppTheme(
          primary: const Color(0xFFF9B332),
          secondary: const Color(0xFF958800),
          background: const Color(0xFFFAFAFA),
          disabled: const Color(0xff808080),
          icon: const Color(0xFF000000),
          textColors: const AppTextColors(
            body: Color(0xFF000000),
            hint: Color(0xff808080),
            error: Color(0xffff0000),
            link: Color(0xff0000ff),
            button: Color(0xffffffff),
            supportInfo: Color(0xFFB8860B),
            orange: Color(0xFFFFA500),),
          sizes: const AppSizes(buttonRadius: 24),
          error: const Color(0xffff0000),
          green: const Color(0xff00ff00),
          tile: const Color(0xFFEFEFEF),
          tileSecondary: const Color(0xFFD8D8D8),
          border: const Color(0x1AA8B9FF),
          drawer: const Color(0xFFEFEFEF),
          warning: const Color(0xFFFFA500),
          grey: const Color(0xff808080),
          navigation: const Color(0xFFD8D8D8),
          white: const Color(0xffffffff),
          white_20: const Color(0xffffffff).withValues(alpha: 0.2),
          white_50: const Color(0xffffffff).withValues(alpha: 0.5),
          white_06: const Color(0xffffffff).withValues(alpha: 0.06),
          info: Color(0xFFA8B9FF).withValues(alpha: 0.10),
          selected: Color(0xff15ffab),
          buttonPrimary: const Color(0xFF000000),
          buttonSecondary: const Color(0xFF000000),
          buttonDisabled: const Color(0xFF000000),
          oppositeBackground: const Color(0xFF000000),
          scrollColor: const Color(0xFF000000),
        );
    }
  }

  AppTextTheme get textStyles {
    AppTextColors colors = theme.textColors;
    return AppTextTheme(
      text1: TextStyle(color: colors.body, fontSize: 32, fontWeight: FontWeight.normal),
      text2: TextStyle(color: colors.body, fontSize: 24, fontWeight: FontWeight.normal),
      text3: TextStyle(color: colors.body, fontSize: 20, fontWeight: FontWeight.normal),
      text4: TextStyle(color: colors.body, fontSize: 18, fontWeight: FontWeight.normal),
      text5: TextStyle(color: colors.body, fontSize: 16, fontWeight: FontWeight.normal),
      text6: TextStyle(color: colors.body, fontSize: 14, fontWeight: FontWeight.normal),
      text7: TextStyle(color: colors.body, fontSize: 12, fontWeight: FontWeight.normal),
      text1B: TextStyle(color: colors.body, fontSize: 32, fontWeight: FontWeight.bold),
      text2B: TextStyle(color: colors.body.withValues(alpha: 0.7), fontSize: 24, fontWeight: FontWeight.bold),
      text3B: TextStyle(color: colors.body, fontSize: 20, fontWeight: FontWeight.bold),
      text4B: TextStyle(color: colors.body, fontSize: 18, fontWeight: FontWeight.bold),
      text5B: TextStyle(color: colors.body, fontSize: 16, fontWeight: FontWeight.bold),
      text6B: TextStyle(color: colors.body, fontSize: 14, fontWeight: FontWeight.bold),
      text7B: TextStyle(color: colors.body, fontSize: 12, fontWeight: FontWeight.bold),
      text4ER: TextStyle(color: colors.error, fontSize: 16, fontWeight: FontWeight.normal),
      text6W_20: TextStyle(color: colors.body.withValues(alpha: 0.2), fontSize: 16, fontWeight: FontWeight.normal),
      text7O: TextStyle(color: colors.orange, fontSize: 12, fontWeight: FontWeight.normal),
      text6O: TextStyle(color: colors.orange, fontSize: 14, fontWeight: FontWeight.normal),
      text6W_50: TextStyle(color: theme.white_06, fontSize: 14, fontWeight: FontWeight.normal),
      text7W_50: TextStyle(color: theme.white_50, fontSize: 12, fontWeight: FontWeight.normal),
      text5BW_50: TextStyle(color: theme.white_50, fontSize: 16, fontWeight: FontWeight.bold),
      text8O: TextStyle(color: colors.orange, fontSize: 10, fontWeight: FontWeight.normal),
      text8W_50: TextStyle(color: theme.white_50, fontSize: 10, fontWeight: FontWeight.normal),
    );
  }
}
