import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/utils/asset_routes.dart';
import 'package:flutter/material.dart';

import '../../../utils/const.dart';

class LoginScreenComponents {
  Widget socialButton(BuildContext context, {Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              fixedSize: Size(
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? width(context)
                      : width(context) * 0.5,
                  50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          onPressed: onTap,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(AssetIconsRoutes.googleIcon, height: 40, width: 40),
            const SizedBox(width: 10),
            Text(
              'Continue with Google',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: primaryColor),
            )
          ])),
    );
  }
}
