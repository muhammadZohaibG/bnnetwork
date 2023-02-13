// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/models/connection_model.dart';
import 'package:b_networks/utils/const.dart';
import 'package:sqflite/sqflite.dart';

import 'b_network_db.dart';

class Connections {
  static Database? _db;
  static const String TABLE = 'Connections';
  static const String ID = 'id';
  static const String FULLNAME = 'full_name';
  static const String LOCATIONID = 'location_id';
  static const String HOMEMADDRESS = 'home_address';
  static const String STREETADDRESS = 'street_address';
  static const String ISACTIVE = 'is_active';
  static const String MOBILE = 'mobile';
  static const String ISSYNCHRONIZED = 'is_synchronized';
  static const String CREATEDAT = 'created_at';
  static const String UPDATEDAT = 'updated_at';

  Future getConnections(
      {required int? locationId,
      required String? month,
      required String? year}) async {
    var dbClient = await DBHelper().db;
    // var tempTable = await dbClient!.rawQuery(''' Select  ''');

    /* var table = await dbClient!.rawQuery(
        '''select $ID,  $FULLNAME, $LOCATIONID, $ADDRESS, $ISACTIVE, $MOBILE, $CREATEDAT, $UPDATEDAT
         from $TABLE where $ISACTIVE == 1 and $LOCATIONID = $locationId  ORDER BY ($CREATEDAT) DESC''');

    //By Inner join
    var testTable = await dbClient.rawQuery(
        '''Select $TABLE.$ID, $TABLE.$FULLNAME, $TABLE.$LOCATIONID, $TABLE.$ADDRESS,
        $TABLE.$ISACTIVE, $TABLE.$MOBILE, $TABLE.$CREATEDAT, $TABLE.$UPDATEDAT,
        ${Bills.TABLE}.${Bills.STATUS} as payment_status from $TABLE
        INNER JOIN ${Bills.TABLE} ON ${Bills.TABLE}.${Bills.CONNECTIONID} = $TABLE.$ID
        and ${Bills.TABLE}.${Bills.LOCATIONID} = $TABLE.$LOCATIONID
        and ${Bills.TABLE}.${Bills.MONTH} = "$month" and ${Bills.TABLE}.${Bills.YEAR} = "$year"
        where $TABLE.$ISACTIVE = 1 and $TABLE.$LOCATIONID = $locationId ORDER BY ($TABLE.$CREATEDAT) DESC''');
    */
    //By Left Join
    var testTable = await dbClient!.rawQuery(
        '''Select  c.$ID, c.$LOCATIONID, c.$FULLNAME, c.$HOMEMADDRESS, c.$STREETADDRESS, c.$MOBILE, b.${Bills.STATUS} as payment_status
        from $TABLE c LEFT OUTER JOIN ${Bills.TABLE} b on b.${Bills.CONNECTIONID} == c.$ID 
        and b.${Bills.LOCATIONID} = c.$LOCATIONID and b.${Bills.MONTH} = "$month" and b.${Bills.YEAR} = "$year"
        where c.$ISACTIVE = 1 and c.$LOCATIONID = $locationId 
        ''');
    if (testTable.isEmpty) {
      log('Connection Not Found');
    }
    log('test table result ======>>>>>>>${testTable.toList()}');

    return testTable;
  }

  Future getPaidConnectionsOfLocation(
      {required int? locationId,
      required String? month,
      required String? year}) async {
    try {
      var dbClient = await DBHelper().db;
      var table = await dbClient!.rawQuery(
          '''Select  c.$ID, c.$LOCATIONID, c.$FULLNAME, c.$HOMEMADDRESS, c.$STREETADDRESS, b.${Bills.STATUS} as payment_status
        from $TABLE c LEFT OUTER JOIN ${Bills.TABLE} b on b.${Bills.LOCATIONID} = c.$LOCATIONID and b.${Bills.STATUS} != "$paid" 
        and b.${Bills.MONTH} = "$month" and b.${Bills.YEAR} = "$year"
        where c.$ISACTIVE = 1 and c.$LOCATIONID = $locationId ORDER BY (c.$CREATEDAT) DESC
        ''');
      if (table.isEmpty) {
        log('Connection Not Found');
      }
      log('table result ======>>>>>>> ${table.toList()}');

      return table;
    } catch (e) {
      log(e.toString());
    }
  }

  Future addConnection({required ConnectionModel connection}) async {
    var dbClient = await DBHelper().db;
    int? id = await dbClient!.transaction((txn) async {
      log('inserting');

      return await txn.rawInsert(
          '''INSERT INTO $TABLE ($FULLNAME,$LOCATIONID, $HOMEMADDRESS, $STREETADDRESS , $MOBILE,  $CREATEDAT, $UPDATEDAT) 
          VALUES("${connection.fullName}",
          ${connection.locationId}, 
          "${connection.homeAddress}", "${connection.streetAddress}", "${connection.mobile}",
          "${connection.createdAt}","${connection.updatedAt}")''');
    });
    if (id != 0) {
      log('Connection saved');
      log('new connection id is $id');
    }
    return id;
  }

  Future<int> updateConnection(
      {required int? connectionId,
      required String? fullName,
      required String? homeAddress,
      required String? streetAddress,
      required String? mobile,
      required String updatedAt}) async {
    var dbClient = await DBHelper().db;

    int? isUpdate = await dbClient!.rawUpdate(
        'Update $TABLE SET $FULLNAME = ?, $HOMEMADDRESS = ?, $STREETADDRESS =?, $MOBILE = ?, $ISSYNCHRONIZED = ?, $UPDATEDAT = ? WHERE  $ID = ?',
        [
          fullName,
          homeAddress,
          streetAddress,
          mobile,
          0,
          updatedAt,
          connectionId
        ]);

    return isUpdate;
  }

  Future countActiveConnections() async {
    var dbClient = await DBHelper().db;
    int? total = Sqflite.firstIntValue(await dbClient!
        .rawQuery('Select Count(*)  as total from $TABLE where $ISACTIVE = 1'));

    log('total active: $total');
    return total;
  }

  Future countActiveConnectionsOfLocation({required int locationId}) async {
    var dbClient = await DBHelper().db;
    int? total = Sqflite.firstIntValue(await dbClient!.rawQuery(
        'Select Count(*)  as total from $TABLE where $LOCATIONID = $locationId and $ISACTIVE = 1'));

    log('total active location connections: $total');
    return total;
  }

  Future disconnectConnection(
      {required int connectionId, required String updatedAt}) async {
    var dbClient = await DBHelper().db;

    int? isUpdate = await dbClient!.rawUpdate(
        'Update $TABLE SET $ISACTIVE = ?, $ISSYNCHRONIZED=?, $UPDATEDAT = ? WHERE $ID = ? ',
        [0, 0, updatedAt, connectionId]);
    log(isUpdate.toString());

    var updatedConnection = await dbClient
        .rawQuery('Select * from $TABLE where $ID = "$connectionId"');
    log(updatedConnection.toString());
    return isUpdate;
  }

  Future getUnSynchronized() async {
    var dbClient = await DBHelper().db;
    var table = await dbClient!
        .rawQuery('Select * from $TABLE where $ISSYNCHRONIZED = 0');
    if (table.isEmpty) {
      log('Connections Not Found');
    }

    return table;
  }
}
