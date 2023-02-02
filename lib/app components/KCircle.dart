import 'package:b_networks/views/app_information/screen/app_info_page.dart';
import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KCircle extends StatelessWidget {
  Widget centerWidget;
  double logoRadius;
  KCircle({super.key, required this.logoRadius, required this.centerWidget});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AppInfoPage()));
      },
      child: Container(
        height: logoRadius,
        width: logoRadius,
        decoration: BoxDecoration(
          color: kColors.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(child: centerWidget),
      ),
    );
  }
}
