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
    required this.homeAddress,
    required this.streetAddress,
    required this.mobile,
    required this.paymentStatus,
  });

  int? id;
  String? fullName;
  int? locationId;
  String? homeAddress;
  String? streetAddress;
  String? mobile;
  String? paymentStatus;

  factory LocationConnectionsWithPaymentModel.fromJson(
          Map<String, dynamic> json) =>
      LocationConnectionsWithPaymentModel(
        id: json["id"],
        fullName: json["full_name"],
        locationId: json["location_id"],
        homeAddress: json["home_address"],
        streetAddress: json["street_address"],
        mobile: json["mobile"],
        paymentStatus: json["payment_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "location_id": locationId,
        "home_address": homeAddress,
        "street_address": streetAddress,
        "mobile": mobile,
        "payment_status": paymentStatus,
      };
}
