part of 'theme_cubit.dart';

enum AppColorTheme { dark, light }

class ThemeState extends GlobalVars with EquatableMixin {
  final AppColorTheme colorTheme;

  const ThemeState({this.colorTheme = AppColorTheme.dark});

  @override
  List<Object?> get props => [colorTheme];

  ThemeState copyWith({AppColorTheme? colorTheme}) {
    return ThemeState(colorTheme: colorTheme ?? this.colorTheme);
  }
}
