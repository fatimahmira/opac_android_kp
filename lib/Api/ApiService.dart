import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:opac_android_kp/Class/Datums.dart';
import 'package:opac_android_kp/Class/Post.dart';

class ApiService {
  // http.Client client = http.Client();
  final String baseURL = "http://172.20.10.3/opac/public";

  //method utk menampilkan List buku no pagination

  Future<List<Datum>> fetchPost() async {
    final response = await http.get('$baseURL/api/v1/buku/');

    var datum = List<Datum>();

    if (response.statusCode == 200) {
      var respon = json.decode(response.body);
      var postsJson = respon['data'];

      for (var postJson in postsJson) {
        datum.add(Datum.fromJson(postJson));
      }
      return datum;
    } else {
      print(response.statusCode.toString());
      throw Exception('Failed to load post');
    }
  }

  Future<bool> createBuku(Datum data) async {
    Datums datums = Datums(data: data);

    final response = await http.post("$baseURL/api/v1/buku",
        headers: {"content-type": "application/json"},
        body: datumsToJson(datums));

    if (response.statusCode == 200) {
      print("method create buku jalan");
      return true;
    } else {
      print(response.statusCode);
      print(datumsToJson(datums).toString());
      print("method create buku tdk jalan");
      return false;
    }
  }

  Future<List<Datum>> fetchPaginate(int page) async {
    final response = await http.get('$baseURL/api/v1/buku/paginate?page=$page');

    var datum = List<Datum>();

    if (response.statusCode == 200) {
     var respon = json.decode(response.body);
      var postsJson = respon['data'];
      var data = postsJson['data'];

      for (var dataJson in data) {
        datum.add(Datum.fromJson(dataJson));
      }
      return datum;
    } else {
      throw Exception('Failed to load post');
    }
  }
 
  Future<Datum> fetchDetail(int id) async {
    Datum bukuClass = Datum();
    final response = await http.get('$baseURL/api/v1/buku/detail/$id');

    if (response.statusCode == 200) {
      var respon = json.decode(response.body);
      var postsJson = respon['data'];
      var buku = postsJson['buku'];
      bukuClass = Datum.fromJson(buku);
      return (bukuClass);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Datum>> fetcBukuTerkait(int id) async {
    final response = await http.get('$baseURL/api/v1/buku/detail/$id');

    var datum = List<Datum>();

    if (response.statusCode == 200) {
      var respon = json.decode(response.body);
      var postsJson = respon['data'];
      var bukuJson = postsJson['bukuTerkait'];

      for (var dataJson in bukuJson) {
        datum.add(Datum.fromJson(dataJson));
      }
      return datum;
    } else {
      print(response.statusCode.toString());
      throw Exception('Failed to load post');
    }
  }

  Future<bool> updateBuku(Datum data, int id) async {
    Datums datums = Datums(data: data);

    final response = await http.put(
      "$baseURL/api/v1/buku/update/$id",
      headers: {"content-type": "application/json"},
      body: datumsToJson(datums),
    );
    if (response.statusCode == 200) {
      print("edit buku jalan");

      return true;
    } else {
      print(datumsToJson(datums).toString());
      return false;
    }
  }

  Future<bool> deleteBuku(int id) async {
    final response = await http.delete("$baseURL/api/v1/buku/destroy/$id");
    if (response.statusCode == 200) {
      print("berhasil delete");
      return true;
    } else {
      print("tidak berhasil delete");
      return false;
    }
  }

}
