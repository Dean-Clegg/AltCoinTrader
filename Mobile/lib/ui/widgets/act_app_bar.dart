import 'package:altcointrader/ui/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class ACTAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  const ACTAppBar(this.title, {super.key, this.leading, this.actions, this.centerTitle = true}) : preferredSize = const Size.fromHeight(48.0);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: TitleWidget(title: title, align: CrossAxisAlignment.center, textAlign: TextAlign.center, size: TitleSize.medium),
      actions: actions,
      centerTitle: centerTitle,
      automaticallyImplyLeading: true,
    );
  }
}

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final Widget? leading;

  const WidgetAppBar({required this.child, super.key, this.leading}) : preferredSize = const Size.fromHeight(48.0);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(leading: leading, title: child, centerTitle: true);
  }
}
