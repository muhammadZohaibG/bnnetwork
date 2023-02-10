import 'dart:async';
import 'dart:developer';

import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/DBHelpers/expenses.dart';
import 'package:b_networks/models/location_model.dart';
import 'package:b_networks/models/location_with_active_connections_model.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/utils/const.dart';
import 'package:flutter/cupertino.dart';

import '../../../DBHelpers/locations.dart';

import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController locationNameController = TextEditingController();
  var locationDb = Locations();
  var expenseDb = Expenses();
  var billsDb = Bills();
  var connectionsDb = Connections();
  bool? isLoading = true;
  List<LocationWithActiveConnectionsModel>? locations = [];
  int? selectedIndex;
  int? totalExpenses = 0;
  int? totalEarnings = 0;
  int? totalActiveConnections = 0;
  int? totalPendingPaymentConnections = 0;
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  String currentYear = DateFormat('y').format(DateTime.now());

  late Stream<int?> totalExpenseStream;
  StreamController<int?> totalExpenseStreamController =
      StreamController.broadcast();

  updateLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  addLocationInList(LocationWithActiveConnectionsModel? location) {
    locations!.add(location!);
    notifyListeners();
  }

  updateSelectedIndex(int i) {
    selectedIndex = i;
    notifyListeners();
  }

  addNewLocationAtStart(LocationWithActiveConnectionsModel? location) {
    locations!.insert(0, location!);
    notifyListeners();
  }

  removeFromLocationsList(int index) {
    locations!.removeAt(index);
    notifyListeners();
  }

  emptyLocations() {
    locations = [];
    notifyListeners();
  }

  updateTotalExpenses(int? amount) {
    totalExpenses = amount;
    notifyListeners();
  }

  updateTotalEarnings(int? amount) {
    totalEarnings = amount;
    notifyListeners();
  }

  addValueInTotalExpenseController(int? v) {
    totalExpenseStreamController.sink.add(v);
    notifyListeners();
  }

  updatePendingPaidConnections(int value) {
    totalPendingPaymentConnections = value;
    notifyListeners();
  }

  updateTotalActiveConnections(int value) {
    totalActiveConnections = value;
    notifyListeners();
  }

  increamentLocationActiveUsers({required int? locationId}) {
    for (var location in locations!) {
      if (location.id == locationId) {
        location.activeConnections = location.activeConnections! + 1;
        notifyListeners();
        break;
      }
    }
  }

  Future getConnectionsStats() async {
    try {
      int? totalActive = await connectionsDb.countActiveConnections();
      updateTotalActiveConnections(totalActive!);
      log('total active here $totalActiveConnections');
      int? totalPaid = await billsDb.totalPaidConnectionsOfMonth(
          month: currentMonth, year: currentYear);
      int? totalUnpaid = totalActive - totalPaid!;
      updatePendingPaidConnections(totalUnpaid);
    } catch (e) {
      log(e.toString());
    }
  }

  Future getLocations() async {
    try {
      emptyLocations();
      updateLoader(true);
      List<Map<String, dynamic>> maps = await locationDb.getLocations() ?? [];

      if (maps.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          log(maps[i]['active_connections'].toString());
          addLocationInList(
              LocationWithActiveConnectionsModel.fromJson(maps[i]));
        }
      }

      updateLoader(false);
    } catch (e) {
      updateLoader(false);
      log(e.toString());
    }
  }

  Future calculateExpenses() async {
    try {
      var result =
          await expenseDb.totalExpenses(month: currentMonth, year: currentYear);

      updateTotalExpenses(result);
    } catch (e) {
      log(e.toString());
    }
  }

  Future calculateTotalEarnings() async {
    try {
      var result = await billsDb.totalBillAmountPaidOfMonth(
          month: currentMonth, year: currentYear);

      updateTotalEarnings(result);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> addLocationInDB() async {
    try {
      LocationModel newLocation = LocationModel();
      bool? alreadyAdded = false;

      for (var e in locations!) {
        if (e.name!.toLowerCase() ==
            locationNameController.value.text.toLowerCase().trim()) {
          alreadyAdded = true;
          break;
        }
      }
      if (!alreadyAdded!) {
        newLocation
          ..name = locationNameController.value.text.trim()
          ..createdAt =
              DateTime.parse(DateFormat(dateFormat).format(DateTime.now()))
          ..updatedAt =
              DateTime.parse(DateFormat(dateFormat).format(DateTime.now()));
        int? id = await locationDb.addLocation(newLocation);
        if (id == 0) {
          showToast('Failed!');
          return false;
        } else {
          newLocation.id = id;
          showToast('Added', backgroundColor: primaryColor);
          locationNameController.clear();
          getLocations();
          return true;
        }
      } else {
        showToast('Location Already Exists');
        locationNameController.clear();
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future deleteLocation(int index) async {
    try {
      int? affectedRow = await locationDb.delete(locations![index].id);
      if (affectedRow > 0) {
        removeFromLocationsList(index);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
