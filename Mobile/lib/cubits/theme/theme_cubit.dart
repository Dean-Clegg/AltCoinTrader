import 'package:altcointrader/barrel_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<MasterState<ThemeState>> {
  ThemeCubit() : super(const Initial(ThemeState()));

  void reset() {
    emit(const Initial(ThemeState()));
  }

  void setTheme(AppColorTheme colorTheme) {
    emit(Loading(state.main));
    emit(Loaded(state.main.copyWith(colorTheme: colorTheme)));
  }
}
