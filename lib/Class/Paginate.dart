// To parse this JSON data, do
//
//     final paginateModel = paginateModelFromJson(jsonString);

import 'dart:convert';

import 'package:opac_android_kp/Class/Post.dart';

PaginateModel paginateModelFromJson(String str) => PaginateModel.fromJson(json.decode(str));

String paginateModelToJson(PaginateModel data) => json.encode(data.toJson());

class PaginateModel {
    bool status;
    String message;
    Data data;

    PaginateModel({
        this.status,
        this.message,
        this.data,
    });

    factory PaginateModel.fromJson(Map<String, dynamic> json) => PaginateModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int currentPage;
    List<Datum> data;

    // String firstPageUrl;
    // int from;
    // int lastPage;
    // String lastPageUrl;
    // String nextPageUrl;
    // String path;
    // int perPage;
    // dynamic prevPageUrl;
    // int to;
    // int total;

    Data({
        this.currentPage,
        this.data,
        // this.firstPageUrl,
        // this.from,
        // this.lastPage,
        // this.lastPageUrl,
        // this.nextPageUrl,
        // this.path,
        // this.perPage,
        // this.prevPageUrl,
        // this.to,
        // this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        // firstPageUrl: json["first_page_url"],
        // from: json["from"],
        // lastPage: json["last_page"],
        // lastPageUrl: json["last_page_url"],
        // nextPageUrl: json["next_page_url"],
        // path: json["path"],
        // perPage: json["per_page"],
        // prevPageUrl: json["prev_page_url"],
        // to: json["to"],
        // total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "first_page_url": firstPageUrl,
        // "from": from,
        // "last_page": lastPage,
        // "last_page_url": lastPageUrl,
        // "next_page_url": nextPageUrl,
        // "path": path,
        // "per_page": perPage,
        // "prev_page_url": prevPageUrl,
        // "to": to,
        // "total": total,
    };
}

