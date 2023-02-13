import 'dart:developer';

import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/models/bill_model.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../utils/const.dart';

class MonthlyBillProvider extends ChangeNotifier {
  bool isLoading = false;
  var billsDb = Bills();
  var connectionsDb = Connections();
  TextEditingController amountController = TextEditingController();
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  String currentYear = DateFormat('y').format(DateTime.now());

  List<BillModel>? billsList = [];

  addInBillsList(BillModel? bill) {
    billsList!.add(bill!);
    notifyListeners();
  }

  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  emptyBillsList() {
    billsList = [];
    notifyListeners();
  }

  Future getBills({required int? connectionId}) async {
    try {
      updateLoading(true);
      emptyBillsList();
      await Future.delayed(const Duration(seconds: 1));
      List<Map<String, dynamic>> maps =
          await billsDb.getBills(connectionId: connectionId) ?? [];
      if (maps.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          addInBillsList(BillModel.fromJson(maps[i]));
        }
      }
      updateLoading(false);
    } catch (e) {
      log(e.toString());
      updateLoading(false);
    }
  }

  Future<bool> addBill(
      {required int? connectionId, required int? locationId}) async {
    try {
      BillModel bill = BillModel()
        ..locationId = locationId
        ..connectionId = connectionId
        ..amount = int.parse(amountController.value.text.trim())
        ..month = currentMonth
        ..year = currentYear
        ..createdAt =
            DateTime.parse(DateFormat(dateFormat).format(DateTime.now()))
        ..updatedAt =
            DateTime.parse(DateFormat(dateFormat).format(DateTime.now()));

      List<Map<String, dynamic>>? maps =
          await billsDb.getOneMonthBillOfConnection(
              connectionId: connectionId,
              locationId: locationId,
              month: currentMonth,
              year: currentYear);
      log(maps.toString());
      if (maps!.isEmpty) {
        // add new bill
        int? id = await billsDb.addBill(bill: bill);
        if (id == 0) {
          showToast('Failed!');
          return false;
        } else {
          showToast('Bill Added!', backgroundColor: primaryColor);
          getBills(connectionId: connectionId);
          amountController.clear();
          return true;
        }
      }
      //else updated
      else {
        BillModel availableBill = BillModel.fromJson(maps[0]);
        availableBill.amount = int.parse(amountController.value.text.trim());
        availableBill.status = paid;
        availableBill.isSynchronized = 0;
        log(availableBill.id.toString());
        int? id = await billsDb.update(availableBill);
        if (id == 0) {
          showToast('Failed to Update!');
          return false;
        } else {
          showToast('Bill Updated!', backgroundColor: primaryColor);
          getBills(connectionId: connectionId);
          amountController.clear();
          return true;
        }
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> disconnectConnection({required int? connectionId}) async {
    try {
      int? isUpdate = await connectionsDb.disconnectConnection(
          connectionId: connectionId!,
          updatedAt:
              DateTime.parse(DateFormat(dateFormat).format(DateTime.now()))
                  .toString());
      log('isUpdate value is $isUpdate');
      if (isUpdate == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
