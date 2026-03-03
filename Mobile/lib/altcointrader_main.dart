import 'package:altcointrader/constants/navigation.dart';
import 'package:altcointrader/constants/themes.dart';
import 'package:altcointrader/core/dependency_injection.dart';
import 'package:altcointrader/core/extensions/master_state.dart';
import 'package:altcointrader/cubits/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AltCoinTraderMain extends StatefulWidget {
  const AltCoinTraderMain({super.key});

  @override
  State<AltCoinTraderMain> createState() => _AltCoinTraderMainState();
}

class _AltCoinTraderMainState extends State<AltCoinTraderMain> {
  GoRouter routerConfig = Navigation.router;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!FocusScope.of(context).hasPrimaryFocus) FocusManager.instance.primaryFocus!.unfocus();
      },
        child: BlocBuilder<ThemeCubit, MasterState<ThemeState>>(
          bloc: sl.themeCubit,
          builder: (context, themeState) {
            AppColorTheme selectedTheme = themeState.main.colorTheme;
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ACTThemes(selectedTheme).get(context),
              routerConfig: routerConfig,
            );
          },
        ),
    );
  }
}
