import 'package:b_networks/DBHelpers/b_network_db.dart';
import 'package:b_networks/app%20components/KCircle.dart';
import 'package:b_networks/app%20components/KTopBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
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
  late String CurrentUSerID;

  Future<void> _showConfirmationDialog(context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to proceed with this action?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      print('Confirmed');
    } else {
      print('Canceled');
    }
    var dbClient = await DBHelper().db;
    List<Map<String, Object?>>? locData;
    List<Map<String, Object?>>? colData;
    List<Map<String, Object?>>? expData;
    List<Map<String, Object?>>? billData;

    //location data getting from sqlite database
    try {
      locData = await dbClient?.rawQuery(
        "select * from Locations where is_synchronized=0",
      );
      if (locData != null || locData!.isEmpty) {
        for (var i = 0; i < locData.length; i++) {
          await dbClient?.transaction((txn) async {
            dbClient.rawQuery(
                "update Locations set is_synchronized=1 where id= ${locData?[i]['id']}");
          });
        }
      }
    } catch (e) {
      print("Error querying table names: $e");
    }

    //Connections data getting from sqlite database
    try {
      colData = await dbClient?.rawQuery(
        "select * from Connections where is_synchronized=0",
      );
      if (colData != null || colData!.isEmpty) {
        for (var i = 0; i < colData.length; i++) {
          await dbClient?.transaction((txn) async {
            dbClient.rawQuery(
                "update Connections set is_synchronized=1 where id= ${colData?[i]['id']}");
          });
        }
      }
    } catch (e) {
      print("Error querying table names: $e");
    }

    //Expenses data getting from sqlite database
    try {
      expData = await dbClient?.rawQuery(
        "select * from Expenses where is_synchronized=0;",
      );
      if (expData != null || expData!.isEmpty) {
        for (var i = 0; i < expData.length; i++) {
          await dbClient?.transaction((txn) async {
            dbClient.rawQuery(
                "update Expenses set is_synchronized=1 where id= ${expData?[i]['id']}");
          });
        }
      }
    } catch (e) {
      print("Error querying table names: $e");
    }

    //Bills data getting from sqlite database
    try {
      billData = await dbClient?.rawQuery(
        "select * from Bills where is_synchronized=0",
      );
      if (billData != null || billData!.isEmpty) {
        for (var i = 0; i < billData.length; i++) {
          await dbClient?.transaction((txn) async {
            dbClient.rawQuery(
                "update Bills set is_synchronized=1 where id= ${billData?[i]['id']}");
          });
        }
      }
    } catch (e) {
      print("Error querying table names: $e");
    }

    //Get current user ID from firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      setState(() {
        CurrentUSerID = user.uid;
      });
    }

    //############################################
    //Sending data from sqlite to firestore
    //store in location sub collection
    final db = FirebaseFirestore.instance;
    for (var v in locData!) {
      db
          .collection("datauser")
          .doc(CurrentUSerID)
          .collection('Locations')
          .doc()
          .set({
        'id': v['id'],
        'name': v['name'],
        'is_sync': v['is_synchronized'],
        'created_at': v['updated_at'],
        'updated_at': v['created_at'],
      }, SetOptions(merge: true)).onError(
              (e, _) => print("Error writing document: $e"));
    }
    //sending data to connection sub collection
    for (var v in colData!) {
      db
          .collection("datauser")
          .doc(CurrentUSerID)
          .collection('Connections')
          .doc()
          .set({
        'id': v['id'],
        'full_name': v['full_name'],
        'location_id': v['location_id'],
        'mobile': v['mobile'],
        'home_address': v['home_address'],
        'street_address': v['street_address'],
        'is_sync': v['is_synchronized'],
        'created_at': v['created_at'],
        'updated_at': v['updated_at'],
      }, SetOptions(merge: true)).onError(
              (e, _) => print("Error writing document: $e"));
    }
    //sending data to expenses sub collection
    for (var v in expData!) {
      db
          .collection("datauser")
          .doc(CurrentUSerID)
          .collection('Expenses')
          .doc()
          .set({
        'id': v['id'],
        'amount': v['amount'],
        'title': v['title'],
        'month': v['month'],
        'year': v['year'],
        'is_sync': v['is_synchronized'],
        'created_at': v['created_at'],
        'updated_at': v['updated_at'],
      }, SetOptions(merge: true)).onError(
              (e, _) => print("Error writing document: $e"));
    }
    //sedning data to bills sub collection
    for (var v in billData!) {
      db
          .collection("datauser")
          .doc(CurrentUSerID)
          .collection('Bills')
          .doc()
          .set({
        'id': v['id'],
        'amount': v['amount'],
        'month': v['month'],
        'year': v['year'],
        'statue': v['status'],
        'location_id': v['location_id'],
        'connection_id': v['connection_id'],
        'is_sync': v['is_synchronized'],
        'created_at': v['created_at'],
        'updated_at': v['updated_at'],
      }, SetOptions(merge: true)).onError(
              (e, _) => print("Error writing document: $e"));
    }
  }

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
          CircleAvatar(
            radius: 20,
            backgroundColor: primaryColor.withOpacity(0.2),
            backgroundImage: NetworkImage(widget.profileImage!),
          ),
          const SizedBox(width: 7),
          Text(
            widget.companyName!,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: kColors.darkGrey,
            ),
          )
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
