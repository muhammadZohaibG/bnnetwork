import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app components/KTopBar.dart';
import '../../../utils/KColors.dart';

class UpdateScreenComponents {
  Widget profileImage(
      {required String? imageUrl, required Function()? onCameraTap}) {
    return Stack(children: [
      CachedNetworkImage(
          imageUrl: imageUrl!,
          imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor.withOpacity(0.2),
              backgroundImage: imageProvider),
          placeholder: (context, url) =>
              CircularProgressIndicator(color: primaryColor),
          errorWidget: (context, url, error) =>
              Icon(Icons.error, color: KColors().darkGrey)),
      Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
              onTap: onCameraTap,
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: kscreenBG),
                  child: const Icon(Icons.camera_alt_outlined,
                      color: Colors.black))))
    ]);
  }

  Widget topBar() {
    return KTopBar(
        leftFlex: 1,
        middleFlex: 2,
        backArrow: true,
        midWidget: const Text(
          'Update Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xff573353),
          ),
        ));
  }
}
