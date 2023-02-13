// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  BillModel({
    this.id,
    this.locationId,
    this.connectionId,
    this.amount,
    this.month,
    this.year,
    this.status,
    this.isSynchronized,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? locationId;
  int? connectionId;
  int? amount;
  String? month;
  String? year;
  String? status;
  int? isSynchronized;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
        id: json["id"],
        locationId: json["location_id"],
        connectionId: json["connection_id"],
        amount: json["amount"],
        month: json["month"],
        year: json["year"],
        status: json["status"],
        isSynchronized: json["is_synchronized"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_id": locationId,
        "connection_id": connectionId,
        "amount": amount,
        "month": month,
        "year": year,
        "status": status,
        "is_synchronized": isSynchronized,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
