import 'dart:ui';

import 'package:altcointrader/constants/colors.dart';
import 'package:altcointrader/constants/navigation.dart';
import 'package:altcointrader/core/dependency_injection.dart';
import 'package:altcointrader/cubits/screen_controller/screen_controller_cubit.dart';
import 'package:altcointrader/cubits/theme/theme_cubit.dart';
import 'package:altcointrader/ui/widgets/social_media_links.dart';
import 'package:altcointrader/ui/widgets/terms_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ACTDrawer extends StatelessWidget {
  const ACTDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AppColorTheme theme = sl.themeCubit.state.main.colorTheme;
    AppTheme colorTheme = theme.theme;
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: colorTheme.white_20, width: 1)),
      ),
      child: Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
          child: SafeArea(
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: _mainScreen(context, theme)),
          ),
        ),
      ),
    );
  }

  Widget _mainScreen(BuildContext context, AppColorTheme colorTheme) {
    AppTextTheme textTheme = colorTheme.textStyles;
    AppTheme colors = colorTheme.theme;
    return Column(
      children: [
        Row(
          children: [
            Text('Menu', style: textTheme.text3),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(colors.sizes.buttonRadius),
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(colors.sizes.buttonRadius),
                  border: Border.all(color: colors.white_20, width: 1),
                ),
                child: Icon(Icons.close, color: colors.icon.withValues(alpha: 0.6)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _menuItem(colorTheme, LucideIcons.circleUser, 'Profile', () {
          Navigator.pop(context);
          context.pushNamed(Routes.profile.name);
        }),
        const Divider(),
        _menuItem(colorTheme, DrawerScreens.news.icon, DrawerScreens.news.displayName, () {
          Navigator.pop(context);
        }),
        const Divider(),
        _menuItem(colorTheme, DrawerScreens.history.icon, DrawerScreens.history.displayName, () {
          Navigator.pop(context);
        }),
        Spacer(),
        const SocialMediaLinks(),
        const SizedBox(height: 16),
        const TermsWidget(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _menuItem(AppColorTheme appTheme, IconData icon, String label, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(icon, color: appTheme.theme.white, size: 16),
            const SizedBox(width: 16),
            Text(label, style: appTheme.textStyles.text5),
            const Spacer(),
            Icon(LucideIcons.chevronRight, color: appTheme.theme.icon.withValues(alpha: 0.6), size: 16),
          ],
        ),
      ),
    );
  }
}
