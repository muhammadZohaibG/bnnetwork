import 'dart:async';
import 'dart:developer';

import 'package:b_networks/DBHelpers/expenses.dart';
import 'package:b_networks/models/location_model.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/utils/const.dart';
import 'package:flutter/cupertino.dart';

import '../../../DBHelpers/locations.dart';

import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController locationNameController = TextEditingController();
  var locationDb = Locations();
  var expenseDb = Expenses();
  bool? isLoading = true;
  List<LocationModel>? locations = [];
  int? selectedIndex;
  int? totalExpenses = 0;

  late Stream<int?> totalExpenseStream;
  StreamController<int?> totalExpenseStreamController =
      StreamController.broadcast();

  updateLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  addLocationInList(LocationModel? location) {
    locations!.add(location!);
    notifyListeners();
  }

  updateSelectedIndex(int i) {
    selectedIndex = i;
    notifyListeners();
  }

  addNewLocationAtStart(LocationModel? location) {
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

  addValueInTotalExpenseController(int? v) {
    totalExpenseStreamController.sink.add(v);
    notifyListeners();
    // yield * totalExpenseStreamController;
  }

  Future getLocations() async {
    try {
      emptyLocations();
      updateLoader(true);
      List<Map<String, dynamic>> maps = await locationDb.getLocations();

      if (maps.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          addLocationInList(LocationModel.fromJson(maps[i]));
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
      var result = await expenseDb.totalExpenses();
      // addValueInTotalExpenseController(result);
      // yield* totalExpenseStreamController.stream;
      updateTotalExpenses(result);
      //totalExpenseStream = await expenseDb.totalExpenses();

    } catch (e) {
      log(e.toString());
    }
  }
// subha

  Future<bool> addLocationInDB() async {
    try {
      LocationModel newLocation = LocationModel();
      bool? alreadyAdded = false;
      log(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));

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
          locationNameController.clear;
          getLocations();
          return true;
        }
      } else {
        showToast('Location Already Exists');
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
