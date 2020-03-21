// To parse this JSON data, do
//
//     final datums = datumsFromJson(jsonString);

import 'dart:convert';

import 'Post.dart';

Datums datumsFromJson(String str) => Datums.fromJson(json.decode(str));

String datumsToJson(Datums data) => json.encode(data.toJson());

class Datums {
    dynamic status;
    dynamic message;
    Datum data;

    Datums({
        this.status,
        this.message,
        this.data,
    });

    factory Datums.fromJson(Map<String, dynamic> json) => Datums(
        status: json["status"],
        message: json["message"],
        data: Datum.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}