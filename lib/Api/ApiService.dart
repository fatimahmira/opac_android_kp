import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:opac_android_kp/Class/CacheModel.dart';
import 'package:opac_android_kp/Class/Datums.dart';
import 'package:opac_android_kp/Class/HiveModel.dart';
import 'package:opac_android_kp/Class/Post.dart';

class ApiService {
  //  String baseURL = "http://172.20.10.3/opac/public";
 final String baseURL = "https://favian.wtf";


  Future<List<Datum>> searchJudul(String text) async {
    final response = await http.get('$baseURL/api/v1/buku/search?q=$text');

    var datum = List<Datum>();

    if (response.statusCode == 200) {
      var respon = json.decode(response.body);
      var postsJson = respon['data'];
      var datas = postsJson['judul'];

      for (var dataJson in datas) {
        datum.add(Datum.fromJson(dataJson));
      }
      return datum;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future login(String email, String pass) async {
    String myurl = "https://payment.stai-tbh.ac.id/api/v1/auth/login";
    final response = http.post(myurl, headers: {
      'Accept': 'application/json',
      'Content-Type': 'Application/x-www-form-urlencoded'
    }, body: {
      "email": email,
      "password": pass
    });
    return response;
  }

//done
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

  //done
  Future<List<Datum>> fetchPaginate(int page) async {
    final response = await http.get('$baseURL/api/v1/buku?page=$page');

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
      print("keluar");
      throw Exception('Failed to load post');
    }

  }

//done
  Future<Datum> fetchDetail(int id) async {
    Datum bukuClass = Datum();
    final response = await http.get('$baseURL/api/v1/buku/$id');

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

//done
  Future<List<Datum>> fetcBukuTerkait(int id) async {
    final response = await http.get('$baseURL/api/v1/buku/$id');

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

//done
  Future<bool> updateBuku(Datum data, int id) async {
    Datums datums = Datums(data: data);

    final response = await http.put(
      "$baseURL/api/v1/buku/$id",
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

//done
  Future<bool> deleteBuku(int id) async {
    final response = await http.delete("$baseURL/api/v1/buku/$id");
    if (response.statusCode == 200) {
      print("berhasil delete");
      return true;
    } else {
      print("tidak berhasil delete");
      return false;
    }
  }

  Future simpanDataBuku(int page) async {
    HiveModel _hiveModel = HiveModel();
    page = 1;
    List<Datum> _datum;
    // Datum _datum;
    String buku = "key";
    try {
      // cek data cache
      print('test');
      CacheModel dataCache;
      dataCache = await _hiveModel.getCache(buku);

      // print(dataCache);

      if(dataCache == null || dataCache.lastFetchTime.isBefore(DateTime.now().subtract(dataCache.cacheValidDuration))){
        print("data cache null");
        _datum = await fetchPaginate(page);
        // simpan data
        CacheModel cacheModel = CacheModel(
          cacheValidDuration: Duration(minutes: 30),
          lastFetchTime: DateTime.now(),
          data: _datum
        );
        _hiveModel.addCache(cacheModel, buku);
        return jsonEncode(dataCache.data);

      } else {
        print("else terakhir");
        //method else isi data pake data cache
        // print(jsonEncode(dataCache.data));
        return jsonEncode(dataCache.data); 
      }
    } catch (e) {}
  }


}
