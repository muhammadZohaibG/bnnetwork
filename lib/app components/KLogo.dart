import 'dart:developer';

import 'package:b_networks/utils/const.dart';
import 'package:b_networks/utils/keys.dart';
import 'package:b_networks/views/settings/view/settings_screen.dart';
import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KLogo extends StatefulWidget {
  double logoRadius;
  double logoFontSize;
  KLogo({super.key, required this.logoFontSize, required this.logoRadius});

  @override
  State<KLogo> createState() => _KLogoState();
}

class _KLogoState extends State<KLogo> {
  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return GestureDetector(
      onTap: () async {
        String? token = await getValueInSharedPref(Keys.token);
        log('token $token');
        if (token == null || token == '') {
        } else {
          log(token);
          if (!mounted) return;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ));
        }
      },
      child: Container(
        height: widget.logoRadius,
        width: widget.logoRadius,
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
                fontSize: widget.logoFontSize,
                color: kColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
