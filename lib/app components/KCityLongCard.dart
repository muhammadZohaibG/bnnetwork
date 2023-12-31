import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KCityLongCard extends StatelessWidget {
  String cityName;
  int? locationId;

  int activeUsers;
  KCityLongCard({
    super.key,
    required this.activeUsers,
    required this.cityName,
    required this.locationId,
  });

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return Container(
        // height: 10,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          title: Text(
            cityName,
            style: TextStyle(
                fontSize: 20,
                color: kColors.darkGrey,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Transform.translate(
            offset: const Offset(0, 10),
            child: Text(
              "Total Users:    $activeUsers",
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
        /*Padding(
        padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    cityName,
                    style: TextStyle(
                        fontSize: 16,
                        color: kColors.darkGrey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "$activeUsers",
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Connections",
                    style: TextStyle(
                        fontSize: 12,
                        color: kColors.statsUnderText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),*/
        );
  }
}
