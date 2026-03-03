import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ACTButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool isLoading;
  final bool isSecondary;
  final bool isDisabled;
  final double maxWidth;

  const ACTButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.isSecondary = false,
    this.maxWidth = 400,
  });

  Widget _primaryStyle(BuildContext context, AppTheme theme) {
    return Align(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: kIsWeb ? maxWidth : double.infinity),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.sizes.buttonRadius),
            color: theme.buttonPrimary,
          ),
          child: _buildButton(context, theme.buttonPrimary),
        ),
      ),
    );
  }

  Widget _secondaryStyle(BuildContext context, AppTheme theme) {
    return Align(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: kIsWeb ? maxWidth : double.infinity),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.sizes.buttonRadius),
            color: (isDisabled || isLoading) ? theme.tileSecondary : theme.buttonSecondary,
            border: isDisabled || isLoading ? null : Border.all(color: theme.tile, width: 1),
          ),
          child: _buildButton(context, theme.buttonSecondary),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, Color hoverColor) {
    AppTextTheme textTheme = sl.themeCubit.state.main.colorTheme.textStyles;
    AppTheme theme = sl.themeCubit.state.main.colorTheme.theme;
    return ElevatedButton(
      onPressed: (isDisabled || isLoading) ? null : onPressed,
      child: Builder(
        builder: (context) {
          if (isLoading) return const SizedBox(height: 20, width: 20, child: CircularProgressIndicator());
          return Text(text, style: textTheme.text3B.copyWith(color: theme.textColors.button));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl.themeCubit.state.main.colorTheme.theme;
    return Builder(
      builder: (context) {
        if (isSecondary || isDisabled || isLoading) return _secondaryStyle(context, theme);
        return _primaryStyle(context, theme);
      },
    );
  }
}
