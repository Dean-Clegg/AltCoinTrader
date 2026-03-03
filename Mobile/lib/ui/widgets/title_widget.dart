import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum TitleSize { extraSmall, small, medium, large, extraLarge }

class TitleWidget extends StatelessWidget {
  final String? title;
  final Widget? wTitle;
  final String? subtitle;
  final Widget? child;
  final bool isWarning;
  final TitleSize size;
  final TextOverflow? overflow;
  final CrossAxisAlignment align;
  final TextAlign? textAlign;
  final bool isHyperText;
  final Color? subtitleColor;
  final MainAxisSize mainAxisSize;
  final FontWeight? fontWeight;
  final double? titleSubtitleSpacing;

  const TitleWidget({
    super.key,
    this.title,
    this.wTitle,
    this.subtitle,
    this.subtitleColor,
    this.align = CrossAxisAlignment.start,
    this.textAlign,
    this.isWarning = false,
    this.size = TitleSize.medium,
    this.overflow,
    this.child,
    this.isHyperText = false,
    this.mainAxisSize = MainAxisSize.max,
    this.fontWeight,
    this.titleSubtitleSpacing,
  });

  @override
  Widget build(BuildContext context) {
    AppTextTheme styles = sl.themeCubit.state.main.colorTheme.textStyles;

    TextStyle titleStyle;
    switch (size) {
      case TitleSize.small:
        titleStyle = styles.text6B;
        break;
      case TitleSize.medium:
        titleStyle = styles.text5B;
        break;
      case TitleSize.large:
        titleStyle = styles.text3B;
        break;
      case TitleSize.extraLarge:
        titleStyle = styles.text1B;
        break;
      case TitleSize.extraSmall:
        titleStyle = styles.text7B;
    }
    if (fontWeight != null) titleStyle = titleStyle.copyWith(fontWeight: fontWeight);

    TextStyle subtitleStyle;
    switch (size) {
      case TitleSize.small:
        subtitleStyle = isWarning ? styles.text7O : styles.text7W_50.copyWith(color: subtitleColor);
        break;
      case TitleSize.medium:
        subtitleStyle = isWarning ? styles.text6O : styles.text6W_50.copyWith(color: subtitleColor);
        break;
      case TitleSize.large:
        subtitleStyle = styles.text5BW_50.copyWith(color: subtitleColor);
        break;
      case TitleSize.extraLarge:
        subtitleStyle = styles.text5BW_50.copyWith(color: subtitleColor);
        break;
      case TitleSize.extraSmall:
        subtitleStyle = isWarning ? styles.text8O : styles.text8W_50.copyWith(color: subtitleColor);
    }

    return Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: align,
      children: [
        if (title?.isNotEmpty ?? false) Text(title!, style: titleStyle, overflow: overflow ?? TextOverflow.ellipsis, textAlign: textAlign),
        if ((title?.isNotEmpty ?? false) && (subtitle?.isNotEmpty ?? false)) SizedBox(height: titleSubtitleSpacing ?? 0),
        if (subtitle?.isNotEmpty ?? false) isHyperText ? _buildHyperText(subtitle!, subtitleStyle) : Text(subtitle!, style: subtitleStyle, overflow: overflow, textAlign: textAlign),
        ?wTitle,
        ?child,
      ],
    );
  }

  Widget _buildHyperText(String text, TextStyle baseStyle) {
    AppTheme colors = sl.themeCubit.state.main.colorTheme.theme;

    RegExp urlPattern = RegExp(r'https?://[^\s,;:!?()]+(?<![.])');
    Iterable<RegExpMatch> matches = urlPattern.allMatches(text);

    if (matches.isEmpty) return Text(text, style: baseStyle, overflow: overflow);

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (RegExpMatch match in matches) {
      if (match.start > lastEnd) spans.add(TextSpan(text: text.substring(lastEnd, match.start), style: baseStyle));
      String url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: baseStyle.copyWith(color: colors.primary, decoration: TextDecoration.underline, decorationColor: colors.primary),
          recognizer: TapGestureRecognizer()..onTap = () => sl.generalCubit.launchUrl(url),
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < text.length) spans.add(TextSpan(text: text.substring(lastEnd), style: baseStyle));
    return Text.rich(
      TextSpan(children: spans),
      style: baseStyle,
      overflow: overflow,
    );
  }
}
