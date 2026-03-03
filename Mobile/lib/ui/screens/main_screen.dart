import 'package:altcointrader/barrel_file.dart';
import 'package:altcointrader/ui/widgets/act_background.dart';
import 'package:altcointrader/ui/widgets/act_app_bar.dart';
import 'package:altcointrader/ui/widgets/profile_image_widget.dart';
import 'package:altcointrader/ui/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenControllerCubit, MasterState<ScreenControllerState>>(
      bloc: sl.screenControllerCubit,
      builder: (context, state) {
        return ACTBackground(
          appBar: ACTAppBar(
            state.main.currentScreen.displayName,
            leading: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  ProfileImageWidget(),
                  Transform.translate(
                    offset: const Offset(50, 8),
                    child: TitleWidget(title: 'Dean', size: TitleSize.extraSmall),
                  ),
                ],
              ),
            ),
          ),
          body: state.main.currentScreen.view,
        );
      },
    );
  }
}
