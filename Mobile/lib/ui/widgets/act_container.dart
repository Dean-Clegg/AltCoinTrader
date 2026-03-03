import 'dart:ui';

import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/material.dart';

enum ContainerType {
  primary,
  disabled,
  warning,
  secondary,
  selected,
  url,
  qr,
  noContainer,
  error,
  borderOnly,
  errorInput,
  iconContainer,
  accent,
  label;

  const ContainerType();

  Color get backgroundColor {
    AppTheme colors = sl.themeCubit.state.main.colorTheme.theme;
    switch (this) {
      case ContainerType.primary:
      case ContainerType.disabled:
        return colors.grey;
      case ContainerType.warning:
        return colors.warning.withValues(alpha: 0.2);
      case ContainerType.errorInput:
        return colors.error.withAlpha(60);
      case ContainerType.error:
        return colors.error;
      case ContainerType.secondary:
        return colors.primary;
      case ContainerType.selected:
        return colors.grey;
      case ContainerType.url:
        return colors.primary.withValues(alpha: 0.1);
      case ContainerType.qr:
        return colors.white;
      case ContainerType.iconContainer:
        return colors.info;
      case ContainerType.accent:
        return colors.primary.withValues(alpha: 0.1);
      case ContainerType.label:
      case ContainerType.noContainer:
      case ContainerType.borderOnly:
        return Colors.transparent;
    }
  }

  Color get borderColor {
    AppTheme colors = sl.themeCubit.state.main.colorTheme.theme;
    switch (this) {
      case ContainerType.primary:
      case ContainerType.disabled:
      case ContainerType.errorInput:
        return colors.white_06;
      case ContainerType.borderOnly:
        return colors.white_20;
      case ContainerType.warning:
        return colors.warning.withValues(alpha: 0.2);
      case ContainerType.error:
        return colors.error;
      case ContainerType.secondary:
        return colors.primary;
      case ContainerType.selected:
        return colors.selected;
      case ContainerType.url:
        return colors.primary.withValues(alpha: 0.1);
      case ContainerType.qr:
        return colors.white_20;
      case ContainerType.iconContainer:
        return colors.info;
      case ContainerType.accent:
        return colors.primary;
      case ContainerType.label:
      case ContainerType.noContainer:
        return Colors.transparent;
    }
  }
}

class ACTContainer extends StatelessWidget {
  final Widget child;
  final double? blurSigma;
  final EdgeInsets? padding;
  final double? borderRadius;
  final BorderRadius? borderRadiusGeometry;
  final void Function()? onTap;
  final ContainerType? type;
  final BoxShape? shape;
  final double? height;
  final double? width;
  final Color? splashColor;
  final Color? containerColor;
  final Color? color;

  const ACTContainer({
    super.key,
    required this.child,
    this.blurSigma,
    this.padding,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.onTap,
    this.type = ContainerType.primary,
    this.shape,
    this.height,
    this.width,
    this.splashColor,
    this.containerColor,
    this.color,
  });

  Function()? _onTap() {
    switch (type) {
      case ContainerType.disabled:
        return null;
      default:
        return onTap;
    }
  }

  Color? _getBackgroundColor() {
    if (color != null) return color;
    if (containerColor != null) {
      if (type == ContainerType.label) return containerColor!.withValues(alpha: 0.12);
      return containerColor;
    }
    return type?.backgroundColor;
  }

  Color? _getBorderColor() {
    if (type == ContainerType.iconContainer && containerColor != null) return containerColor;
    if (type == ContainerType.label && containerColor != null) return containerColor!.withValues(alpha: 0.12);
    return type?.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    AppTheme colors = sl.themeCubit.state.main.colorTheme.theme;

    EdgeInsets effectivePadding;

    if (padding != null) {
      effectivePadding = padding!;
    } else {
      effectivePadding = switch (type) {
        ContainerType.noContainer => EdgeInsets.zero,
        ContainerType.iconContainer => const EdgeInsets.all(8),
        ContainerType.label => const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        _ => const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      };
    }

    final effectiveBorderRadius = borderRadiusGeometry ?? (shape == BoxShape.circle ? BorderRadius.circular(1000) : BorderRadius.circular(borderRadius ?? colors.sizes.buttonRadius));

    Widget container = Opacity(
      opacity: type == ContainerType.disabled ? 0.5 : 1,
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: InkWell(
          customBorder: shape == BoxShape.circle ? const CircleBorder() : RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          splashColor: splashColor,
          onTap: _onTap(),
          child: Container(
            height: height,
            width: width,
            padding: effectivePadding,
            decoration: shape == null
                ? BoxDecoration(
                    color: _getBackgroundColor(),
                    borderRadius: effectiveBorderRadius,
                    border: Border.all(color: _getBorderColor() ?? colors.white_06),
                  )
                : BoxDecoration(
                    shape: shape!,
                    color: _getBackgroundColor(),
                    border: Border.all(color: _getBorderColor() ?? colors.white_06),
                  ),
            child: child,
          ),
        ),
      ),
    );

    if (blurSigma != null) {
      return ClipRRect(
        borderRadius: shape == BoxShape.circle ? BorderRadius.circular(100) : BorderRadius.circular(colors.sizes.buttonRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma!, sigmaY: blurSigma!),
          child: Container(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(colors.sizes.buttonRadius),
              border: Border.all(color: _getBorderColor() ?? colors.white_06),
            ),
            child: child,
          ),
        ),
      );
    }

    return container;
  }
}
