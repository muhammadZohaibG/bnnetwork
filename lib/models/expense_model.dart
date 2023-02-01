// To parse this JSON data, do
//
//     final expenseModel = expenseModelFromJson(jsonString);

import 'dart:convert';

ExpenseModel expenseModelFromJson(String str) =>
    ExpenseModel.fromJson(json.decode(str));

String expenseModelToJson(ExpenseModel data) => json.encode(data.toJson());

class ExpenseModel {
  ExpenseModel({
    this.id,
    this.title,
    this.amount,
    this.month,
    this.year,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  int? amount;
  String? month;
  String? year;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        month: json["month"],
        year: json["year"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "month": month,
        "year": year,
        "created_at": createdAt!, //.toIso8601String(),
        "updated_at": updatedAt! //.toIso8601String(),
      };
}
