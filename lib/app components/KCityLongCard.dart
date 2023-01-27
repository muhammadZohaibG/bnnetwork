import 'package:b_networks/views/CityDetailPage/screen/city_details_page.dart';
import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KCityLongCard extends StatelessWidget {
  String cityName;
  String cityDescription;
  int activeUsers;
  KCityLongCard(
      {super.key,
      required this.activeUsers,
      required this.cityDescription,
      required this.cityName});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CityDetailsPage(
                      cityName: cityName,
                    )));
      },
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
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
                      cityName,
                      style: TextStyle(
                          fontSize: 16,
                          color: kColors.darkGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      cityDescription,
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
                child: Column(
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
                      "Active Users",
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
        ),
      ),
    );
  }
}
