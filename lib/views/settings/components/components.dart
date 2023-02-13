import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';
import '../../../utils/const.dart';

class SettingsScreenComponents {
  Widget tile(
      {String? leadingIcon,
      String? title = '',
      String? subTitle = '',
      Function()? tileOnTap,
      bool showTrailingSwitch = false,
      bool? trailingValue,
      Function(bool)? onChanged}) {
    return Container(
      decoration: BoxDecoration(color: KColors().screenBG, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 2),
            color: KColors().darkGrey.withOpacity(0.04))
      ]),
      child: ListTile(
        onTap: tileOnTap,
        leading: Transform.translate(
            offset: const Offset(0, 5),
            child: Image.asset(leadingIcon!,
                height: subTitle! == 'LOGOUT' ? 40 : 30,
                width: subTitle == 'LOGOUT' ? 40 : 30)),
        title: title! != ''
            ? Transform.translate(
                offset: const Offset(0, -10),
                child: Text(title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: kdarkGrey.withOpacity(0.4))))
            : Transform.translate(
                offset: const Offset(0, 10),
                child: Text(subTitle,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
        subtitle: title == ''
            ? const SizedBox()
            : Text(subTitle,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
        trailing: !showTrailingSwitch
            ? const SizedBox()
            : CupertinoSwitch(
                value: trailingValue!,
                thumbColor: kscreenBG,
                activeColor: primaryColor,
                onChanged: onChanged),
      ),
    );
  }

  Widget syncTile(
      {String? leadingIcon,
      String? title = '',
      bool? trailingValue,
      required bool? isSync,
      required Function()? onSyncTap}) {
    return Container(
      decoration: BoxDecoration(color: KColors().screenBG, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 2),
            color: KColors().darkGrey.withOpacity(0.04))
      ]),
      child: ListTile(
        leading: Transform.translate(
            offset: const Offset(0, 5),
            child: Image.asset(leadingIcon!, height: 30, width: 30)),
        title: Transform.translate(
            offset: const Offset(0, -10),
            child: Text(title!,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kdarkGrey.withOpacity(0.4)))),
        subtitle: Text(isSync! ? 'Synchronized' : 'Not Synchronized',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isSync ? KColors().accept : KColors().decline)),
        trailing: InkWell(
          onTap: () => onSyncTap!(),
          child: Container(
              decoration: BoxDecoration(
                  color: isSync ? KColors().accept : KColors().decline,
                  borderRadius: BorderRadius.circular(5)),
              height: 22,
              width: 65,
              child: Center(
                  child: Text('Sync Now',
                      style: TextStyle(
                          fontSize: 12,
                          color: KColors().buttonTextWhite,
                          fontWeight: FontWeight.w600)))),
        ),
      ),
    );
  }

  Widget addFreeButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Go Ad free',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  const SizedBox(height: 10),
                  Text('Buy a plan and go ad free',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.5)))
                ],
              )),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              )),
        ],
      ),
    );
  }

  Widget profileImage({required String? imageUrl}) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 50,
        backgroundColor: primaryColor.withOpacity(0.2),
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) =>
          CircularProgressIndicator(color: primaryColor),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: KColors().darkGrey),
    );
  }
}
