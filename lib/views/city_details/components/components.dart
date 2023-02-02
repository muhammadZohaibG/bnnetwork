import 'package:b_networks/models/connection_model.dart';
import 'package:flutter/material.dart';

import '../../../app components/KLongCustomCard.dart';
import '../../../utils/KColors.dart';
import '../../../utils/const.dart';
import '../../monthly_bill/screen/monthly_bill_list_screen.dart';

class CityDetailsScreenComponents {
  Widget connectionsList({required List<ConnectionModel>? connectionsList}) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: connectionsList!.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: KLongCustomCard(
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MonthlyBillListScreen(
                              userName: connectionsList[i].fullName!,
                              connectionId: connectionsList[i].id,
                              locationId: connectionsList[i].locationId,
                            )));
              },
              mainTitle: connectionsList[i].fullName!,
              description: connectionsList[i].address!,
              billStatus: pending),
        );
      },
    );
  }

  Widget noConnectionsToShow() {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('No Connections To Show',
              style: TextStyle(
                  fontSize: 20,
                  color: KColors().darkGrey,
                  fontWeight: FontWeight.w500))
        ]));
  }
}
