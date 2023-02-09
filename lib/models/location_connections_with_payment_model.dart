// To parse this JSON data, do
//
//     final locationConnectionsWithPaymentModel = locationConnectionsWithPaymentModelFromJson(jsonString);

import 'dart:convert';

LocationConnectionsWithPaymentModel locationConnectionsWithPaymentModelFromJson(
        String str) =>
    LocationConnectionsWithPaymentModel.fromJson(json.decode(str));

String locationConnectionsWithPaymentModelToJson(
        LocationConnectionsWithPaymentModel data) =>
    json.encode(data.toJson());

class LocationConnectionsWithPaymentModel {
  LocationConnectionsWithPaymentModel({
    required this.id,
    required this.fullName,
    required this.locationId,
    required this.address,
    required this.paymentStatus,
  });

  int? id;
  String? fullName;
  int? locationId;
  String? address;
  String? paymentStatus;

  factory LocationConnectionsWithPaymentModel.fromJson(
          Map<String, dynamic> json) =>
      LocationConnectionsWithPaymentModel(
        id: json["id"],
        fullName: json["full_name"],
        locationId: json["location_id"],
        address: json["address"],
        paymentStatus: json["payment_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "location_id": locationId,
        "address": address,
        "payment_status": paymentStatus,
      };
}
