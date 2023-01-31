import 'dart:developer';

import 'package:b_networks/DBHelpers/b_network_db.dart';
import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/DBHelpers/expenses.dart';
import 'package:b_networks/DBHelpers/locations.dart';
import 'package:b_networks/views/home/components/home_page_topbar.dart';
import 'package:b_networks/app%20components/KCalendarButton.dart';
import 'package:b_networks/app%20components/KDialogBox.dart';
import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/app%20components/KStatsCards.dart';
import 'package:b_networks/app%20components/KTextField.dart';
import 'package:b_networks/app%20components/KUnderTopBar.dart';
import 'package:b_networks/views/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/KColors.dart';
import '../../../app components/KCityLongCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textFieldController = TextEditingController();
  var dbHelper = DBHelper();
  var locations = Locations();
  var expenses = Expenses();
  var connections = Connections();
  var bill = Bills();
  List<String> cityNames = [
    "Lahore",
    "Islamabad",
    "Multan",
    "Peshawar",
    "Mian Wali",
    "Kiranchi",
    "Gujranwala",
    "Sialkot",
  ];

  List<int> cityActiveUsers = [30, 20, 14, 67, 87, 45, 98, 31];

  List<String> cityDescription = [
    "Lahore description",
    "Islamabad description",
    "Multan description",
    "Peshawar description",
    "Mian Wali description",
    "Kiranchi description",
    "Gujranwala description",
    "Sialkot description",
  ];

  String? newCity;

  @override
  void initState() {
    super.initState();
  }

  function() async {
    //final homeProvider = Provider.of<HomeProvider>(context);
    await context.read<HomeProvider>().getLocations();
    //await locations.getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KColors().screenBG,
        body: Consumer<HomeProvider>(
          builder: (context, value, child) => Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: HomePageTopBar(),
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
                                const SizedBox(height: 20),
                                KStatsCards(
                                    totalEarning: 75000, totalExpense: 23500),
                                const SizedBox(height: 30),
                                InkWell(
                                  onTap: () {
                                    log(DateTime.now().toString());
                                  },
                                  child: Text(
                                    "Service Locations",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: KColors().darkGrey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cityNames.length,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: KCityLongCard(
                                            activeUsers: cityActiveUsers[i],
                                            cityName: cityNames[i]),
                                      );
                                    })
                              ])))),
              KMainButton(
                  text: "Add Service Location",
                  onPressed: () async {
                    //await locations.addLocation();
                    //await locations.getLocations();
                    //await expenses.addExpense();
                    // await expenses.getExpenses();
                    //await connections.addConnection();
                    //await connections.getConnections();
                    //await bill.addBill();
                    //await bill.getBills();

                    KDialogBox().showDialogBox(
                        dialogBoxHeight: 154,
                        buttonText: "Add new",
                        onButtonPress: () {
                          if (newCity != null && !cityNames.contains(newCity)) {
                            cityNames.add(newCity!);
                            cityDescription.add("$newCity description");
                            cityActiveUsers.add(76);
                            Navigator.pop(context);
                            setState(() {});
                          }
                        },
                        context: context,
                        widgets: <Widget>[
                          Text("Enter location name to add",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: KColors().statsUnderText,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 20,
                          ),
                          KTextField(
                              onChanged: (value) {
                                newCity = value;
                              },
                              hintText: "17 Chak North")
                        ]);
                  }),
            ],
          ),
        ));
  }
}
