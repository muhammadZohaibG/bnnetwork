// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:b_networks/DBHelpers/b_network_db.dart';
import 'package:b_networks/models/bill_model.dart';
import 'package:b_networks/utils/const.dart';
import 'package:sqflite/sqflite.dart';

class Bills {
  static const String TABLE = 'Bills';
  static const String ID = 'id';
  static const String CONNECTIONID = 'connection_id';
  static const String LOCATIONID = 'location_id';
  static const String AMOUNT = 'amount';
  static const String MONTH = 'month';
  static const String YEAR = 'year';
  static const String STATUS = 'status';
  static const String ISSYNCHRONIZED = 'is_synchronized';
  static const String CREATEDAT = 'created_at';
  static const String UPDATEDAT = 'updated_at';

  Future getBills({required int? connectionId}) async {
    var dbClient = await DBHelper().db;
    var table = await dbClient!.query(TABLE,
        columns: [
          ID,
          CONNECTIONID,
          LOCATIONID,
          AMOUNT,
          MONTH,
          YEAR,
          STATUS,
          CREATEDAT,
          UPDATEDAT
        ],
        where: "$CONNECTIONID == $connectionId  ");
    if (table.isEmpty) {
      log('Bill Not Found');
    }
    log(table.toString());
    return table;
  }

  Future addBill({required BillModel bill}) async {
    var dbClient = await DBHelper().db;
    int? id = await dbClient!.transaction((txn) async {
      log('inserting');

      return await txn.rawInsert('''INSERT INTO $TABLE ( 
         
        $CONNECTIONID,
        $LOCATIONID,
        $AMOUNT,
        $MONTH,
        $YEAR,
        $CREATEDAT,
        $UPDATEDAT) 
          VALUES(${bill.connectionId},${bill.locationId}, 
          ${bill.amount}, "${bill.month}",
          "${bill.year}",
          "${bill.createdAt}",
          "${bill.updatedAt}")''');
    });
    if (id != 0) {
      log('Bill saved');
      log('new bill id is $id');
    }
    return id;
  }

  Future<int> update(BillModel bill) async {
    var dbClient = await DBHelper().db;
    return await dbClient!
        .update(TABLE, bill.toJson(), where: '$ID = ?', whereArgs: [bill.id]);
  }

  Future getOneMonthBillOfConnection(
      {required int? connectionId,
      required int? locationId,
      required String? month,
      required String? year}) async {
    var dbClient = await DBHelper().db;
    var table = await dbClient!.query(TABLE,
        columns: [
          ID,
          CONNECTIONID,
          LOCATIONID,
          AMOUNT,
          MONTH,
          YEAR,
          STATUS,
          CREATEDAT,
          UPDATEDAT
        ],
        where:
            " $CONNECTIONID == $connectionId and $LOCATIONID == $locationId and $MONTH == '$month' and $YEAR == '$year'"
        //     "$MONTH == 'January'",
        );
    if (table.isEmpty) {
      log('Bill Not Found');
    }

    return table;
  }

  Future totalBillAmountPaidOfMonth(
      {required String? month, required String? year}) async {
    var dbClient = await DBHelper().db;
    var amount = await dbClient!.rawQuery(
        'Select SUM($AMOUNT) as Total FROM $TABLE where $STATUS == "$paid" and  $MONTH = "$month" and $YEAR = "$year"');
    log(amount[0]['Total'].toString());

    return amount[0]['Total'] ?? 0;
  }

  Future totalPaidConnectionsOfMonth(
      {required String? month, required String? year}) async {
    var dbClient = await DBHelper().db;
    var total = Sqflite.firstIntValue(await dbClient!.rawQuery(
        'Select Count(*) as total from $TABLE where $STATUS = "$paid" and  $MONTH = "$month" and $YEAR = "$year"'));
    log('total paid : $total');
    return total;
  }

  Future totalPaidConnectionsOfLocation(
      {required String? month,
      required String? year,
      required int locationId}) async {
    var dbClient = await DBHelper().db;
    var total = Sqflite.firstIntValue(await dbClient!.rawQuery(
        'Select Count(*) as total from $TABLE where $STATUS = "$paid" and $LOCATIONID = $locationId and  $MONTH = "$month" and $YEAR = "$year"'));
    log('total paid : $total');
    return total;
  }

  Future totalLocationEarningOfMonth(
      {required String? month,
      required String? year,
      required int locationId}) async {
    var dbClient = await DBHelper().db;
    var amount = await dbClient!.rawQuery(
        'Select SUM($AMOUNT) as Total FROM $TABLE where $STATUS == "$paid" and $LOCATIONID = $locationId and  $MONTH = "$month" and $YEAR = "$year"');
    log(amount[0]['Total'].toString());

    return amount[0]['Total'] ?? 0;
  }

  Future addCurrentMonthBills() async {
    //select user id's where from connections where
    var dbClient = await DBHelper().db;
    var connectionsWithNoBill = await dbClient!.rawQuery(
        '''Select ${Bills.CONNECTIONID} from ${Bills.TABLE} where ${Bills.MONTH} == "February"'''
        //   '''Select ${Connections.TABLE}.${Connections.ID} from ${Connections.TABLE}
        //   LEFT OUTER JOIN ${Bills.TABLE} ON ${Bills.TABLE}.${Bills.CONNECTIONID}==${Connections.TABLE}.${Connections.ID}
        //   and  ${Bills.TABLE}.${Bills.MONTH} == "March"
        //  '''
        );

    if (connectionsWithNoBill.isEmpty) {
      log('all connections bills are added ');
    }
    log(connectionsWithNoBill.toList().toString());
    return connectionsWithNoBill;
  }

  Future getUnSynchronized() async {
    var dbClient = await DBHelper().db;
    var table = await dbClient!
        .rawQuery('Select * from $TABLE where $ISSYNCHRONIZED = 0');
    if (table.isEmpty) {
      log('Bills Not Found');
    }

    return table;
  }
}
