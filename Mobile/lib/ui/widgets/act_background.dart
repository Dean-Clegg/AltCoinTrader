import 'package:altcointrader/barrel_file.dart';
import 'package:altcointrader/generated/assets.gen.dart';
import 'package:altcointrader/ui/widgets/act_drawer.dart';
import 'package:flutter/material.dart';

class ACTBackground extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool showDrawer;
  final bool? showLogo;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const ACTBackground({super.key, this.appBar, required this.body, this.bottomNavigationBar, this.floatingActionButton, this.showLogo = true, this.showDrawer = true, this.floatingActionButtonLocation});

  @override
  Widget build(BuildContext context) {
    AppTheme colorTheme = sl.themeCubit.state.main.colorTheme.theme;
    return Scaffold(
      backgroundColor: colorTheme.background,
      appBar: appBar,
      endDrawer: showDrawer ? ACTDrawer() : null,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: Offstage(
        offstage: bottomNavigationBar == null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorTheme.background,
                border: Border(top: BorderSide(color: colorTheme.white_20, width: 1)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: SafeArea(child: bottomNavigationBar ?? SizedBox()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Offstage(
              offstage: !showLogo!,
              child: Image.asset(
                Assets.png.logoAct.path,
                color: colorTheme.white.withAlpha(1),
                colorBlendMode: BlendMode.srcIn,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            body,
          ],
        ),
      ),
    );
  }
}
