// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:b_networks/DBHelpers/b_network_db.dart';

class Bills {
  static const String TABLE = 'Bills';
  static const String ID = 'id';
  static const String CONNECTIONID = 'connection_id';
  static const String LOCATIONID = 'location_id';
  static const String AMOUNT = 'amount';
  static const String MONTH = 'month';
  static const String YEAR = 'year';
  static const String STATUS = 'status';
  static const String CREATEDAT = 'created_at';
  static const String UPDATEDAT = 'updated_at';

  Future getBills() async {
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
        where: "$LOCATIONID == 1");
    if (table.isEmpty) {
      log('Bill Not Found');
    } else {
      List<Map<String, dynamic>> maps = table;
      log(maps.toString());
    }
  }

  Future addBill() async {
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
          VALUES(1,1 , 400, "January","2023","2023-01-31 11:30:13.426658","2023-01-31 11:30:13.426658")''');
    });
    log('Bill saved');
    log('new bill id is $id');
  }
}
