import 'dart:developer';

import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/DBHelpers/expenses.dart';
import 'package:b_networks/DBHelpers/locations.dart';
import 'package:b_networks/models/bill_model.dart';
import 'package:b_networks/models/connection_model.dart';
import 'package:b_networks/models/expense_model.dart';
import 'package:b_networks/models/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/const.dart';
import '../../../utils/keys.dart';

class SettingsProvider extends ChangeNotifier {
  var billsDb = Bills();
  var locationsDb = Locations();
  var connectionsDb = Connections();
  var expensesDb = Expenses();
  bool isLoading = false;
  String? email = '';
  String? profileImage = '';
  String? name = '';
  bool? notificationsSwitch = false;
  bool? backup = false;
  List<BillModel> billsList = [];
  List<LocationModel> locationsList = [];
  List<ConnectionModel> connectionsList = [];
  List<ExpenseModel> expenses = [];

  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  updateNotificationSwitch(bool? value) {
    notificationsSwitch = value;
    notifyListeners();
  }

  addInList(List<dynamic> list, dynamic value) {
    list.add(value);
    notifyListeners();
  }

  Future userDetails() async {
    try {
      updateLoading(true);
      email = await getValueInSharedPref(Keys.email);
      profileImage = await getValueInSharedPref(Keys.image);
      log(profileImage!);

      name = await getValueInSharedPref(Keys.name);
      backup = await getIsSyncInSharedPref();
      notifyListeners();
      updateLoading(false);
    } catch (e) {
      log(e.toString());
      updateLoading(false);
    }
  }

  Future getUnSynchronizedData() async {
    try {
      List<Map<String, dynamic>> table = await billsDb.getUnSynchronized();
      log(table.toList().toString());
      for (var e in table) {
        addInList(billsList, BillModel.fromJson(e));
      }
      List<Map<String, dynamic>> locationsTable =
          await locationsDb.getUnSynchronized();
      log('locations ====================>>>>>>>');
      log(locationsTable.toList().toString());

      List<Map<String, dynamic>> connectionTable =
          await connectionsDb.getUnSynchronized();
      log('connections ====================>>>>>>>');
      log(connectionTable.toList().toString());

      List<Map<String, dynamic>> expensesTable =
          await expensesDb.getUnSynchronized();
      log('expenses ====================>>>>>>>');
      log(expensesTable.toList().toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future logOut() async {
    try {
      await GoogleSignIn().signOut();
      // await firebaseAuth.signOut();
      await clearInSharedPref(Keys.email);
      await clearInSharedPref(Keys.name);
      await clearInSharedPref(Keys.image);
      await clearInSharedPref(Keys.token);
      String? name = await getValueInSharedPref(Keys.name);
      log(name!);
    } catch (e) {
      log(e.toString());
    }
  }
}
