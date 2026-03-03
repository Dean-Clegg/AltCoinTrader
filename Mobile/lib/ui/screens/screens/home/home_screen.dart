import 'package:altcointrader/ui/widgets/act_background.dart';
import 'package:altcointrader/ui/widgets/act_bottom_nav.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ACTBackground(
      body: Placeholder(),
      bottomNavigationBar: ACTBottomNavBar(),
    );
  }
}
