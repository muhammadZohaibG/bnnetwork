import 'dart:developer';

import 'package:b_networks/models/connection_model.dart';
import 'package:b_networks/models/location_connections_with_payment_model.dart';
import 'package:flutter/material.dart';

import '../../../app components/KLongCustomCard.dart';
import '../../../app components/userCard.dart';
import '../../../utils/KColors.dart';
import '../../../utils/const.dart';
import '../../monthly_bill/screen/monthly_bill_list_screen.dart';

class CityDetailsScreenComponents {
  Widget totalEarnings({required int totalEarnings}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Fees:',
            style: TextStyle(
                fontSize: 16, color: kdarkGrey, fontWeight: FontWeight.w600),
          ),
          Text(
            '$totalEarnings',
            style: TextStyle(
                fontSize: 16, color: kdarkGrey, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget connectionsList(
      {required List<LocationConnectionsWithPaymentModel>? connectionsList,
      required Function()? onTap,
      required Function()? editOnTap}) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: connectionsList!.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: UserCard(
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MonthlyBillListScreen(
                              userName: connectionsList[i].fullName!,
                              connectionId: connectionsList[i].id,
                              locationId: connectionsList[i].locationId,
                            ))).then((value) => onTap!());
              },
              editOntap: () => editOnTap!(),
              id: connectionsList[i].id,
              mainTitle: connectionsList[i].fullName!,
              description: connectionsList[i].address!,
              billStatus: connectionsList[i].paymentStatus == null ||
                      connectionsList[i].paymentStatus == pending
                  ? pending
                  : paid),
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
