import 'package:b_networks/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/KColors.dart';

class UserCard extends StatelessWidget {
  VoidCallback? onPress;
  Function()? editOntap;
  int? id;
  String? descriptionImgPath;
  String mainTitle;
  String description;
  String billStatus;
  DateTime paidDate;
  UserCard(
      {super.key,
      this.onPress,
      required this.editOntap,
      required this.id,
      required this.mainTitle,
      required this.description,
      required this.billStatus,
      this.descriptionImgPath,
      required this.paidDate});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return InkWell(
      onTap: onPress,
      child: Container(
          height: 90,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            title: Text(
              '$id.  $mainTitle',
              style: TextStyle(
                  fontSize: 16,
                  color: kColors.darkGrey,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Transform.translate(
                offset: const Offset(0, 10),
                child: Text(description,
                    style: TextStyle(
                        fontSize: 14,
                        color: kColors.statsUnderText,
                        fontWeight: FontWeight.w500))),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (billStatus == paid)
                  Text(DateFormat("d/MM/yyyy hh:mm a").format(paidDate),
                      style: TextStyle(
                          fontSize: 12,
                          color: kColors.accept,
                          fontWeight: FontWeight.w600)),
                if (billStatus == paid) const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: billStatus == paid
                              ? kColors.accept
                              : kColors.decline,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 22,
                        width: 65,
                        child: Center(
                            child: Text(billStatus,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kColors.buttonTextWhite,
                                    fontWeight: FontWeight.w600)))),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => editOntap!(),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryColor)),
                        child: Image.asset(
                          'assets/icons/pen.png',
                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )

          /*Padding(
          padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '$id.  $mainTitle',
                      style: TextStyle(
                          fontSize: 16,
                          color: kColors.darkGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                          fontSize: 12,
                          color: kColors.statsUnderText,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Center(
                        child: Container(
                            decoration: BoxDecoration(
                              color: billStatus == paid
                                  ? kColors.accept
                                  : kColors.decline,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 22,
                            width: 65,
                            child: Center(
                                child: Text(billStatus,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: kColors.buttonTextWhite,
                                        fontWeight: FontWeight.w600))))),
                  ],
                ),
              ),
            ],
          ),
        ),*/
          ),
    );
  }
}
