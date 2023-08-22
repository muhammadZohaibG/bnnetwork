import 'package:b_networks/app%20components/KCircle.dart';
import 'package:b_networks/app%20components/KTopBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';

class HomePageTopBar extends StatefulWidget {
  String? profileImage, companyName;
  Function()? onTap;
  HomePageTopBar(
      {super.key,
      required this.profileImage,
      required this.companyName,
      required this.onTap});

  @override
  State<HomePageTopBar> createState() => _HomePageTopBarState();
}

class _HomePageTopBarState extends State<HomePageTopBar> {
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
            widget.companyName!,
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
