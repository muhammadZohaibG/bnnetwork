// To parse this JSON data, do
//
//     final connectionModel = connectionModelFromJson(jsonString);

import 'dart:convert';

ConnectionModel connectionModelFromJson(String str) =>
    ConnectionModel.fromJson(json.decode(str));

String connectionModelToJson(ConnectionModel data) =>
    json.encode(data.toJson());

class ConnectionModel {
  ConnectionModel({
    this.id,
    this.locationId,
    this.fullName,
    this.address,
    this.isActive,
    this.mobile,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? locationId;
  String? fullName;
  String? address;
  int? isActive;
  String? mobile;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ConnectionModel.fromJson(Map<String, dynamic> json) =>
      ConnectionModel(
        id: json["id"],
        locationId: json["location_id"],
        fullName: json["full_name"],
        address: json["address"],
        isActive: json["is_active"],
        mobile: json["mobile"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_id": locationId,
        "full_name": fullName,
        "address": address,
        "is_active": isActive,
        "mobile": mobile,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
