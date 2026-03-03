import 'package:altcointrader/barrel_file.dart';
import 'package:altcointrader/ui/widgets/act_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum ImageSize {
  xxs(14),
  xs(18),
  s(25),
  m(40),
  l(50),
  xl(60),
  xxl(80),
  xxxl(100),
  xxxxl(300);

  final double value;

  const ImageSize(this.value);
}

class ProfileImageWidget extends StatelessWidget {
  final ImageSize size;

  const ProfileImageWidget({super.key, this.size = ImageSize.m});

  @override
  Widget build(BuildContext context) {
    AppTheme colors = sl.themeCubit.state.main.colorTheme.theme;
    return ACTContainer(
      splashColor: Colors.transparent,
      type: ContainerType.noContainer,
      shape: BoxShape.circle,
      onTap: () => context.pushNamed(Routes.profile.name),
      child: SizedBox(
        width: size.value,
        height: size.value,
        child: ACTContainer(
          shape: BoxShape.circle,
          padding: EdgeInsets.zero,
          type: ContainerType.secondary,
          child: Icon(LucideIcons.user, color: colors.icon, size: size.value * 0.6),
        ),
      ),
    );
  }
}
