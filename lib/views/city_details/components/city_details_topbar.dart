import 'package:b_networks/app%20components/KCircle.dart';
import 'package:b_networks/app%20components/KLogo.dart';
import 'package:b_networks/app%20components/KTopBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';
import '../../../utils/const.dart';
import '../../../utils/keys.dart';
import '../../settings/view/settings_screen.dart';

class CityDetailsTopBar extends StatefulWidget {
  String cityName;
  Function()? onTap;
  String? profileImage;
  CityDetailsTopBar(
      {super.key,
      required this.cityName,
      required this.onTap,
      required this.profileImage});

  @override
  State<CityDetailsTopBar> createState() => _CityDetailsTopBarState();
}

class _CityDetailsTopBarState extends State<CityDetailsTopBar> {
  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return KTopBar(
      leftFlex: 2,
      leftWidget: Row(
        children: [
          // KLogo(
          //   logoRadius: 45,
          //   logoFontSize: 16,
          // ),
          InkWell(
            onTap: () => widget.onTap!(),
            child: CachedNetworkImage(
                imageUrl: widget.profileImage!,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryColor.withOpacity(0.2),
                    backgroundImage: imageProvider),
                placeholder: (context, url) =>
                    CircularProgressIndicator(color: primaryColor),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: KColors().darkGrey)),
          ),
          const SizedBox(width: 7),
          Text(
            widget.cityName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: kColors.darkGrey,
            ),
          ),
        ],
      ),
      rightWidget: KCircle(
          logoRadius: 45,
          centerWidget: Image.asset(
            "assets/icons/help_icon.png",
            scale: 1.1,
          )),
    );
  }
}
