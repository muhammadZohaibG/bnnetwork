// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  BillModel({
    required this.id,
    required this.locationId,
    required this.connectionId,
    required this.amount,
    required this.month,
    required this.year,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? locationId;
  int? connectionId;
  String? amount;
  String? month;
  String? year;
  String? status;
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
