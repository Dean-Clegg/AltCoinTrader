import 'package:altcointrader/barrel_file.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsWidget extends StatelessWidget {
  const TermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppTextTheme styles = sl.themeCubit.state.main.colorTheme.textStyles;
    AppTheme colors = sl.themeCubit.state.main.colorTheme.theme;
    return SafeArea(
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(colors.sizes.buttonRadius),
                  onTap: () => launchUrl(Uri.parse('')),
                  child: Text('Terms & Conditions', style: styles.text6B.copyWith(color: colors.primary)),
                ),
                const Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(colors.sizes.buttonRadius),
                  onTap: () => launchUrl(Uri.parse('')),
                  child: Text('Privacy Policy', style: styles.text6B.copyWith(color: colors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('© 2026 AltCoin Trader', style: styles.text6W_20),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
