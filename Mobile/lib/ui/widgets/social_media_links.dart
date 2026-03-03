import 'package:altcointrader/core/dependency_injection.dart';
import 'package:altcointrader/cubits/general/general_cubit.dart';
import 'package:flutter/material.dart';

class SocialMediaLinks extends StatelessWidget {
  final double spacing;
  final double runSpacing;
  final double iconSize;

  const SocialMediaLinks({super.key, this.spacing = 12, this.runSpacing = 8, this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: spacing,
      runSpacing: runSpacing,
      children: SocialLink.values.map((link) => _SocialIconButton(link: link, size: iconSize)).toList(),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final SocialLink link;
  final double size;

  const _SocialIconButton({required this.link, required this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => sl.generalCubit.launchUrl(link.url),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(link.icon, size: size),
      ),
    );
  }
}
