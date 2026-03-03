import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/material.dart';

class ACTSnackBar {
  final String message;
  final int duration;
  final Widget? icon;
  final bool isError;
  OverlayEntry? _overlayEntry;

  ACTSnackBar({
    required this.message,
    this.duration = 3,
    this.icon,
    this.isError = false,
  });

  void show(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    Future.delayed(Duration(seconds: duration), () {
      _overlayEntry?.remove();
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    AppColorTheme colorTheme = sl.themeCubit.state.main.colorTheme;
    AppTheme theme = colorTheme.theme;
    return OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isError ? theme.error : theme.green,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: colorTheme.textStyles.text4,
                  ),
                ),
                ?icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
