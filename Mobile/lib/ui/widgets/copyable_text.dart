import 'dart:async';

import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CopyableText extends StatefulWidget {
  final String copyText;
  final double? iconSize;
  final Widget? child;
  final TextStyle? copyTheme;

  const CopyableText({
    super.key,
    required this.copyText,
    this.iconSize,
    this.child,
    this.copyTheme,
  });

  @override
  State<CopyableText> createState() => _CopyableTextState();
}

class _CopyableTextState extends State<CopyableText> {
  bool copied = false;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: widget.copyText));
        HapticFeedback.heavyImpact();
        setState(() {
          copied = true;
          _timer?.cancel();
          _timer = Timer(
            const Duration(seconds: 1),
            () => setState(() => copied = false),
          );
        });
      },
      child: copied ? Text('Copied!', style: widget.copyTheme ?? sl.themeCubit.state.main.colorTheme.textStyles.text4B) : widget.child ?? Icon(LucideIcons.copy, size: widget.iconSize ?? 20),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
