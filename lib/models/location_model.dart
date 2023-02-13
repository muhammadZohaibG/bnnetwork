// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  LocationModel({
    this.id,
    this.name,
    this.isSynchronized,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? isSynchronized;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["id"],
        name: json["name"],
        isSynchronized: json["is_synchronized"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_synchronized": isSynchronized,
        "created_at": createdAt!, //.toIso8601String(),
        "updated_at": updatedAt!, //.toIso8601String(),
      };
}
