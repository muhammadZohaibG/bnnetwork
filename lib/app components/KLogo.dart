import 'package:b_networks/views/settings/view/settings_screen.dart';
import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KLogo extends StatelessWidget {
  double logoRadius;
  double logoFontSize;
  KLogo({super.key, required this.logoFontSize, required this.logoRadius});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsScreen(),
            ));
      },
      child: Container(
        height: logoRadius,
        width: logoRadius,
        decoration: BoxDecoration(
          color: kColors.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text.rich(
            TextSpan(
              text: 'BN',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: logoFontSize,
                color: kColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
