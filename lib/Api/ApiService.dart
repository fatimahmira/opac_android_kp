import 'dart:convert';

import 'package:opac_android_kp/Class/Buku.dart';
import 'package:opac_android_kp/Class/Datums.dart';
import 'package:opac_android_kp/Class/Post.dart';

import 'package:http/http.dart' as http;

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
      throw Exception('Failed to load post');
    }
  }

  Future<bool> createBuku(Datum data) async {
    Datums datums = Datums(
      data: data
    );

    final response = await http.post(
      "$baseURL/api/v1/buku",
      headers: {"content-type": "application/json"},
      body:  datumsToJson(datums)
    );
    
    if (response.statusCode == 200) {
      print("method create buku jalan");
      return true;
    } else {
      print(response.statusCode);
      print(
        datumsToJson(datums).toString()
        );
      print("method create buku tdk jalan");
      return false;
    }
  }

  Future<BukuClass> fetchDetail(int id) async {
    BukuClass bukuClass = BukuClass();
    final response =
        await http.get('$baseURL/api/v1/buku/detail/$id');

    if (response.statusCode == 200) {
      var respon = json.decode(response.body);
      var postsJson = respon['data'];
      var buku = postsJson['buku'];
      // for (buku in postsJson) {
      bukuClass = BukuClass.fromJson(buku);
      return bukuClass;

      // });
    } else {
      throw Exception('Failed to load post');
    }
  }

  
}
