// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:b_networks/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';

import 'b_network_db.dart';

class Expenses {
  static Database? _db;
  static const String TABLE = 'Expenses';
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String AMOUNT = 'amount';
  static const String MONTH = 'month';
  static const String YEAR = 'year';
  static const String CREATEDAT = 'created_at';
  static const String UPDATEDAT = 'updated_at';

  Future getExpenses() async {
    var dbClient = await DBHelper().db;
    //dbClient!.rawQuery(sql);
    var table = await dbClient!.query(
      TABLE,
      columns: [ID, TITLE, AMOUNT, MONTH, YEAR, CREATEDAT, UPDATEDAT],
      //where: "$CREATEDAT< '2023-01-30'"
    );

    if (table.isEmpty) {
      log('Expense Not Found');
      return [];
    } else {
      return table;
    }
  }

  Future addExpense(ExpenseModel expense) async {
    var dbClient = await DBHelper().db;
    int? id = await dbClient!.transaction((txn) async {
      log('inserting');
      return await txn.rawInsert(
          '''INSERT INTO $TABLE ($TITLE, $AMOUNT, $MONTH, $YEAR, $CREATEDAT, $UPDATEDAT) 
          VALUES("${expense.title}", ${expense.amount}, 
          "${expense.month}", "${expense.year}", 
          "${expense.createdAt}", "${expense.updatedAt}")''');
    });
    if (id != 0) {
      log('Expense saved');
      log('id is $id');
    }
    return id;
  }

  Future totalExpenses() async {
    var dbClient = await DBHelper().db;
    var amount =
        await dbClient!.rawQuery('Select SUM($AMOUNT) as Total FROM $TABLE');
    log(amount[0]['Total'].toString());

    return amount[0]['Total'] ?? 0;
  }
}
