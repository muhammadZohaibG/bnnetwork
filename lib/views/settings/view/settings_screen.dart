import 'package:b_networks/DBHelpers/b_network_db.dart';
import 'package:b_networks/utils/const.dart';
import 'package:b_networks/utils/keys.dart';
import 'package:b_networks/views/login/view/login_screen.dart';
import 'package:b_networks/views/settings/components/components.dart';
import 'package:b_networks/views/settings/components/settings_topbar.dart';
import 'package:b_networks/views/settings/provider/settings_provider.dart';
import 'package:b_networks/views/settings/view/update_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/KColors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? profileImage;
  late String CurrentUSerID;
  bool syned = false;
  @override
  void initState() {
    function();
    super.initState();
    func();
  }

  Future<void> _showConfirmationDialog(context) async {
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
      setState(() {
        syned = true;
      });
    }
  }

  func() async {
    profileImage = (await getValueInSharedPref(Keys.image))!;
  }

  function() {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      settingsProvider.userDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors().screenBG,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 50),
          child: SettingsTopBar(onEditIconTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProfileScreen()))
                .then((value) {
              function();
            });
          })),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 30),
                    settingsProvider.isLoading
                        ? const SizedBox()
                        : profileImage !=
                                null // Check if profileImage is not null
                            ? SettingsScreenComponents()
                                .profileImage(imageUrl: profileImage!)
                            : const SizedBox(),
                    const SizedBox(height: 20),
                    Text(settingsProvider.fullName!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(settingsProvider.email!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: KColors().darkGrey.withOpacity(0.4))),
                    const SizedBox(height: 30),
                    const Divider(height: 2, thickness: 5, color: Colors.white),
                    const SizedBox(height: 30),
                    SettingsScreenComponents().tile(
                        leadingIcon: 'assets/icons/notifications.png',
                        title: 'Get Updated',
                        subTitle: 'Notifications',
                        showTrailingSwitch: true,
                        trailingValue: settingsProvider.notificationsSwitch,
                        onChanged: (v) {
                          settingsProvider.updateNotificationSwitch(v);
                        }),
                    const SizedBox(height: 10),
                    SettingsScreenComponents().syncTile(
                        leadingIcon: 'assets/icons/language.png',
                        title: 'Backup',
                        isSync: settingsProvider.backup ?? true,
                        onSyncTap: () async {
                          bool? checkNetwork = await isNetworkAvailable();
                          if (checkNetwork) {
                            bool confirm = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Are you sure?'),
                                  content: Text(
                                      'Do you want to proceed with this action?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirm == true) {
                              _showConfirmationDialog(context);

                              // await settingsProvider.getUnSynchronizedData();
                              setState(() {
                                addIsSyncInSharedPref(Keys.isSync, true);
                              });
                              showToast('Data Stored Successfully',
                                  backgroundColor: Colors.blue);
                            } else {
                              print('Canceled');
                            }
                          } else {
                            CircularProgressIndicator(
                              color: Colors.black,
                            );
                            showToast(noInternetConnection);
                          }
                        }),
                    const SizedBox(height: 10),
                    SettingsScreenComponents().tile(
                        leadingIcon: 'assets/icons/language.png',
                        title: 'Language',
                        subTitle: 'English',
                        tileOnTap: () {
                          settingsProvider.addCurrentMonthBills();
                        }),
                    const SizedBox(height: 10),
                    SettingsScreenComponents().tile(
                        leadingIcon: 'assets/icons/terms.png',
                        title: 'Need Help',
                        subTitle: 'Terms and Conditions',
                        tileOnTap: () {
                          launchUrlCustomTab(termsAndConditionsUrl);
                        }),
                    const SizedBox(height: 10),
                    SettingsScreenComponents().tile(
                        leadingIcon: 'assets/icons/logout.png',
                        subTitle: 'LOGOUT',
                        tileOnTap: () async {
                          bool? checkNetwork = await isNetworkAvailable();
                          if (checkNetwork) {
                            await settingsProvider.logOut();
                            if (!mounted) return;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          } else {
                            showToast(noInternetConnection);
                          }
                        }),
                    // SettingsScreenComponents().addFreeButton(),
                  ]),
                )),
                //   KMainButton(text: "Logout", onPressed: () async {})
              ],
            ),
          );
        },
      ),
    );
  }
}
