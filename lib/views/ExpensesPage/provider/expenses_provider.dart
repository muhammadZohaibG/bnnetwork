import 'dart:developer';

import 'package:b_networks/DBHelpers/expenses.dart';
import 'package:b_networks/models/expense_model.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../utils/const.dart';

class ExpensesProvider extends ChangeNotifier {
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController expenseSearchController = TextEditingController();
  var expensesDb = Expenses();
  bool isLoading = false;
  List<ExpenseModel>? expensesList = [];

  List<ExpenseModel>? searchExpenseList = [];

  updateLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  addInExpensesList(ExpenseModel? expense) {
    expensesList!.add(expense!);
    notifyListeners();
  }

  emptyExpense() {
    expensesList = [];
    notifyListeners();
  }

  addInSearchExpenseList(ExpenseModel expense) {
    searchExpenseList!.add(expense);
    notifyListeners();
  }

  emptySearchExpenseList() {
    searchExpenseList = [];
    notifyListeners();
  }

  Future getExpenses() async {
    try {
      emptyExpense();
      updateLoader(true);
      await Future.delayed(const Duration(seconds: 1));
      List<Map<String, dynamic>> maps = await expensesDb.getExpenses();
      if (maps.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          addInExpensesList(ExpenseModel.fromJson(maps[i]));
        }
      }
      updateLoader(false);
    } catch (e) {
      log(e.toString());
    }
  }

  searchExpense() {
    emptySearchExpenseList();
    for (var e in expensesList!) {
      if (e.title!.toLowerCase().startsWith(
          expenseSearchController.value.text.trim().toLowerCase())) {
        addInSearchExpenseList(e);
      }
    }
  }

  Future<bool> addExpenseInDb() async {
    try {
      ExpenseModel expense = ExpenseModel()
        ..title = expenseTitleController.value.text.trim()
        ..amount = int.parse(expenseAmountController.value.text.trim())
        ..month = DateFormat('MMMM').format(DateTime.now())
        ..year = DateFormat('y').format(DateTime.now())
        ..createdAt =
            DateTime.parse(DateFormat(dateFormat).format(DateTime.now()))
        ..updatedAt =
            DateTime.parse(DateFormat(dateFormat).format(DateTime.now()));
      int? id = await expensesDb.addExpense(expense);
      if (id == 0) {
        showToast('Failed!');
        return false;
      } else {
        expense.id = id;
        showToast('Added', backgroundColor: primaryColor);
        expenseAmountController.clear();
        expenseTitleController.clear();
        getExpenses();
        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
