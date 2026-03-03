import 'package:altcointrader/ui/widgets/act_background.dart';
import 'package:altcointrader/ui/widgets/act_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ACTBackground(appBar: ACTAppBar('Profile'), showDrawer: false, body: const Placeholder());
  }
}
