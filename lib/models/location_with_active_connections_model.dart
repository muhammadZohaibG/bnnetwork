// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationWithActiveConnectionsModel locationWithActiveConnectionsModelFromJson(
        String str) =>
    LocationWithActiveConnectionsModel.fromJson(json.decode(str));

String locationWithActiveConnectionsModelToJson(
        LocationWithActiveConnectionsModel data) =>
    json.encode(data.toJson());

class LocationWithActiveConnectionsModel {
  LocationWithActiveConnectionsModel({
    this.id,
    this.name,
    this.activeConnections,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? activeConnections;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory LocationWithActiveConnectionsModel.fromJson(
          Map<String, dynamic> json) =>
      LocationWithActiveConnectionsModel(
        id: json["id"],
        name: json["name"],
        activeConnections: json['active_connections'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active_connections": activeConnections,
        "created_at": createdAt!, //.toIso8601String(),
        "updated_at": updatedAt!, //.toIso8601String(),
      };
}
