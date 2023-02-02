import 'package:b_networks/app%20components/KTopBar.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';

class AppInfoTopBar extends StatelessWidget {
  const AppInfoTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return KTopBar(
      leftFlex: 1,
      backArrow: true,
      midWidget: const Text(
        'App Information',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Color(0xff573353),
        ),
      ),
    );
  }
}
