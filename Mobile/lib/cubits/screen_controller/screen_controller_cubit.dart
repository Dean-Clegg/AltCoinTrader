import 'package:altcointrader/ui/screens/screens/home/home_screen.dart';
import 'package:altcointrader/ui/screens/screens/market/market_screen.dart';
import 'package:altcointrader/ui/screens/screens/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:altcointrader/barrel_file.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

part 'screen_controller_state.dart';

class ScreenControllerCubit extends Cubit<MasterState<ScreenControllerState>> {
  ScreenControllerCubit() : super(const Initial(ScreenControllerState()));

  void go(MainScreens screen) {
    if (state.main.availableScreens.contains(screen)) emit(Message(state.main.copyWith(currentScreen: screen)));
  }

  void reset() {
    emit(const Initial(ScreenControllerState()));
  }

  void updateAvailableScreens() {
    List<MainScreens> screens = MainScreens.values.toList();
    emit(Message(state.main.copyWith(availableScreens: screens)));
  }
}
