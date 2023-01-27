import 'package:b_networks/views/CityDetailPage/components/city_details_filter.dart';
import 'package:b_networks/views/CityDetailPage/components/city_details_topbar.dart';
import 'package:b_networks/app%20components/KCalendarButton.dart';
import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/app%20components/KUnderTopBar.dart';
import 'package:b_networks/app%20components/KLongCustomCard.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';
import '../../../app components/KDialogBox.dart';
import '../../../app components/KTextField.dart';
import '../../UserDetailsPage/screen/user_details_page.dart';

class CityDetailsPage extends StatefulWidget {
  String cityName;
  CityDetailsPage({super.key, required this.cityName});

  @override
  State<CityDetailsPage> createState() => _CityDetailsPageState();
}

class _CityDetailsPageState extends State<CityDetailsPage> {
  bool allSelected = true;
  bool paidSelected = false;
  bool pendingSelected = false;
  KDialogBox kDialogBox = KDialogBox();
  String filter = "";
  String searchFilter = "";
  List<String> userName = ["Emzze", "Exes"];

  List<String> userAddress = ["Pakistan", "Iraq"];

  List<String> userPaidStatus = ["paid", "pending"];

  @override
  Widget build(BuildContext context) {
    String? newUser;
    String? newAddress;
    final textFieldController = TextEditingController();
    final locationTextFieldController = TextEditingController();
    KColors kColors = KColors();
    return Scaffold(
      backgroundColor: kColors.screenBG,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CityDetailsTopBar(cityName: widget.cityName),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KUnderTopBar(
                    leftText: "Overall Statistics",
                    rightWidget: const KCalendarButton(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  KTextField(
                    onChanged: (value) {
                      searchFilter = value;
                      setState(() {});
                    },
                    color: Colors.white,
                    hintText: "Search by user name",
                    suffix: SizedBox(
                      height: 55,
                      width: 65,
                      child:
                          Center(child: Image.asset("assets/icons/search.png")),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CityDetailsFilter(
                        isSelected: allSelected,
                        text: "All",
                        onTap: () {
                          if (allSelected != true) {
                            allSelected = true;
                            paidSelected = false;
                            pendingSelected = false;
                            filter = "";
                          }
                          setState(() {});
                        },
                      ),
                      CityDetailsFilter(
                        isSelected: paidSelected,
                        text: "Paid",
                        onTap: () {
                          if (paidSelected != true) {
                            allSelected = false;
                            paidSelected = true;
                            pendingSelected = false;
                            filter = "paid";
                          }
                          setState(() {});
                        },
                      ),
                      CityDetailsFilter(
                        isSelected: pendingSelected,
                        text: "Pending",
                        onTap: () {
                          if (pendingSelected != true) {
                            allSelected = false;
                            paidSelected = false;
                            pendingSelected = true;
                            filter = "pending";
                          }
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userName.length,
                    itemBuilder: (context, i) {
                      return Builder(builder: (context) {
                        if (searchFilter == "" &&
                            userPaidStatus[i].contains(filter)) {
                          return Column(
                            children: [
                              KLongCustomCard(
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserDetailsPage(
                                                  userName: userName[i],
                                                )));
                                  },
                                  mainTitle: userName[i],
                                  description: userAddress[i],
                                  billStatus: userPaidStatus[i]),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        } else if (searchFilter != "" &&
                            (userName[i].toLowerCase())
                                .contains(searchFilter.toLowerCase()) &&
                            userPaidStatus[i].contains(filter)) {
                          return Column(
                            children: [
                              KLongCustomCard(
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserDetailsPage(
                                                  userName: userName[i],
                                                )));
                                  },
                                  mainTitle: userName[i],
                                  description: userAddress[i],
                                  billStatus: userPaidStatus[i]),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        KMainButton(
            text: "Add New User",
            onPressed: () {
              kDialogBox.showDialogBox(
                  dialogBoxHeight: 230,
                  buttonText: "Add User",
                  onButtonPress: () {
                    if (newUser != null &&
                        newAddress != null &&
                        !userName.contains(newUser)) {
                      userName.add(newUser!);
                      userAddress.add(newAddress!);
                      userPaidStatus.add("paid");
                      Navigator.pop(context);
                      setState(() {});
                    }
                  },
                  context: context,
                  widgets: <Widget>[
                    Text(
                      "Add user to ${widget.cityName}",
                      style: TextStyle(
                          fontSize: 18,
                          color: kColors.statsUnderText,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    KTextField(
                      onChanged: (value) {
                        newUser = value;
                      },
                      hintText: "Emzze",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    KTextField(
                      onChanged: (value) {
                        newAddress = value;
                      },
                      hintText: "Address",
                    )
                  ]);
            }),
      ]),
    );
  }
}
