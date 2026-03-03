import 'dart:io';

import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ACTBottomNavBar extends StatelessWidget {
  const ACTBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme colors = sl.themeCubit.state.main.colorTheme.theme;
    AppTextTheme styles = sl.themeCubit.state.main.colorTheme.textStyles;
    return BlocBuilder<ScreenControllerCubit, MasterState<ScreenControllerState>>(
      bloc: sl.screenControllerCubit,
      builder: (context, screenState) {
        MainScreens selectedScreen = screenState.main.currentScreen;
        return Padding(
          padding: EdgeInsets.only(bottom: Platform.isAndroid ? 24.0 : 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: screenState.main.availableScreens.map((screen) {
              bool isSelected = screen == selectedScreen;
              return IconButton(
                tooltip: screen.displayName,
                onPressed: () => sl.screenControllerCubit.go(screen),
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(screen.icon, size: 20, color: isSelected ? colors.white : colors.grey),
                    Transform.translate(
                      offset: Offset(0, 20),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Text(screen.displayName, style: styles.text7.copyWith(color: isSelected ? colors.white : colors.grey, fontSize: 8)),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
