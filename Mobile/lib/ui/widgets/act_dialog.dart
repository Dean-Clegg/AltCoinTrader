import 'dart:ui';

import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ACTDialog extends StatefulWidget {
  final String title;
  final String description;
  final Widget? child;
  final TextAlign? descriptionAlign;
  final Color? backgroundColor;
  final Color? borderColor;
  final Icon? icon;
  final bool isDismissible;

  const ACTDialog({
    super.key,
    this.title = '',
    this.description = '',
    this.descriptionAlign,
    this.child,
    this.backgroundColor,
    this.icon,
    this.isDismissible = true,
    this.borderColor,
  });

  @override
  State<ACTDialog> createState() => _ACTDialogState();

  void showSheet(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: isDismissible ? () => Navigator.of(context).pop() : null,
          child: _infoText(context),
        );
      },
    );
  }

  Widget _infoText(BuildContext context) {
    ThemeState themeState = sl.themeCubit.state.main;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: kIsWeb ? const BoxConstraints(maxWidth: 400) : const BoxConstraints(),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor ?? themeState.colorTheme.theme.primary, width: 0.4),
                      color: backgroundColor ?? themeState.colorTheme.theme.background.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        if (title.isNotEmpty || description.isNotEmpty || child != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                if (title.isNotEmpty) Text(title, style: themeState.colorTheme.textStyles.text2, textAlign: TextAlign.center),
                                if (description.isNotEmpty) const SizedBox(height: 8),
                                if (description.isNotEmpty) Text(description, style: themeState.colorTheme.textStyles.text4, textAlign: descriptionAlign ?? TextAlign.center),
                                if (child != null) const SizedBox(height: 16),
                                ?child,
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ACTDialogState extends State<ACTDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.showSheet(context),
      child: widget.icon ?? const Icon(Icons.info_outline, size: 20),
    );
  }
}
