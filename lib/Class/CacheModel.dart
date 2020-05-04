import 'dart:convert';

CacheModel cacheModelFromJson(String str) => CacheModel.fromJson(json.decode(str));

String cacheModelToJson(CacheModel data) => json.encode(data.toJson());
class CacheModel {

  Duration cacheValidDuration;

  DateTime lastFetchTime;

  var data;

  CacheModel({this.cacheValidDuration, this.lastFetchTime, this.data});

  factory CacheModel.fromJson(Map<String, dynamic> json) => CacheModel(
    cacheValidDuration: json["cacheValidDuration"],
    lastFetchTime: json["lastFetchTime"],
    data: json["data"],
  );
  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
  Map<String, dynamic> toJson() => {
        'cacheValidDuration': cacheValidDuration.toString(),
        'lastFetchTime': lastFetchTime.toString(),
        'data': data,
      };
}