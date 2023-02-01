import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app components/kCityLongCard.dart';
import '../../../utils/KColors.dart';

class HomeScreenComponents {
  Widget shimmerList(BuildContext context) {
    return Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey.shade300,
        highlightColor: primaryColor.withOpacity(0.5), //Colors.grey.shade100,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KCityLongCard(activeUsers: 0, cityName: ''),
          ),
        ));
  }
}
