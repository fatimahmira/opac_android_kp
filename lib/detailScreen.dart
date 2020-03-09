import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opac_android_kp/Class/Buku.dart';
import 'package:opac_android_kp/Class/Post.dart';


class DetailScreen extends StatefulWidget {
  // int id;
  // DetailScreen({this.id});

  List<Datum> list;
  int idBuku;
  DetailScreen({this.idBuku});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
 int id = 0;
  BukuClass bukuClass = BukuClass();
  BukuClass _bukuClass = BukuClass();
  var bukuTerkait = List<BukuClass>();

  bool _loading = false;

  // _onLoading() {
  //   new Future.delayed(new Duration(seconds: 1), () {
  //     _details();//pop dialog
  //     // _login();
  //   });
  // }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // id = widget.idBuku;

    fetchDetail();
    super.initState();
  }
  // List<BukuClass> _bukuClass = List<BukuClass>();

  Future<BukuClass> fetchDetail() async {
    this.id = widget.idBuku;
    final response = await http
        .get('http://192.168.1.181/opac/public/api/v1/buku/detail/${id}');

    if (response.statusCode == 200) {
      setState(() {
        var respon = json.decode(response.body);
        var postsJson = respon['data'];
        var buku = postsJson['buku'];
        // for (buku in postsJson) {
        bukuClass = BukuClass.fromJson(buku);
        return (bukuClass);

        
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<BukuClass>> fetchBuku() async {
    final response =
        // await http.get('http://127.0.0.1/opac/public/api/v1/buku/get-all');
        //  await http.get('http://10.126.22.224/opac/public/api/v1/buku');
        await http
            .get('http://192.168.1.181/opac/public/api/v1/buku/detail/${id}');
    // await Future.delayed(Duration(seconds: 0, milliseconds: 2000));

    var datum = List<BukuClass>();

    if (response.statusCode == 200) {
      var respon = json.decode(response.body);
      var postsJson = respon['data'];
      var dataBuku = postsJson['bukuTerkait'];

      for (var postJson in dataBuku) {
        datum.add(BukuClass.fromJson(postJson));
      }
      return datum;
    } else {
      throw Exception('Failed to load post');
    }
  }

  //  Post list ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("id = ${bukuClass.id}")),
      backgroundColor: Colors.lightBlueAccent,
      body:
       _details(bukuClass)
      // new FutureBuilder<BukuClass>(
      //       future: fetchDetail(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasError) print("errornya${snapshot.error}");
              
      //         return snapshot.hasData
      //             ? _details(snapshot.data)
      //             : new Center(
      //                 child: new CircularProgressIndicator(),
      //               );
      //       },
      //     ),
    );
  }

  _details(BukuClass bk) {
    return Container(
      padding: const EdgeInsets.all(27.0),
      child: new Card(
        child: new Column(
          children: <Widget>[
            Container(
              height: 20.0,
            ),
            Text(
              bk.judul,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                    child: Column(
                  children: <Widget>[
                    new Text("Kota Terbit ",
                        style: TextStyle(color: Colors.black26)),
                    new Text(" ${bk.kotaTerbit} ")
                  ],
                )),
                Card(
                    child: Column(
                  children: <Widget>[
                    new Text("Cetakan Ke",
                        style: TextStyle(color: Colors.deepOrange)),
                    new Text(" ${bk.cetakanKe}"),
                  ],
                )),
                Card(
                    child: Column(
                  children: <Widget>[
                    new Text("Jumlah Halaman",
                        style: TextStyle(color: Colors.deepOrange)),
                    new Text("${bk.jumlahHalaman} lembar"),
                  ],
                )),
              ],
            ),
            // _editData(),
            // _listBukuTerkait(widget.index)
          ],
        ),
      ),
    );
  }

  _progress() {
    return AlertDialog(
      content: new Container(
        width: 100.0,
        height: 100.0,
        child: Row(
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      ),
    );
  }

  // _editData() {
  //   return RaisedButton(
  //       child: Text("Edit Data"),
  //       onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
  //           builder: (BuildContext context) => new EditBuku(
  //                 list: widget.list,
  //                 index: widget.index,
  //               ))));
  // }

  // _listBukuTerkait(index) {
  //   return ListTile(
  //       contentPadding: EdgeInsets.only(bottom: 10.0),
  //       title: Text(_bukuClass[index].judul));
  // }   
}

//untuk menampilkan data buku terkait : http://localhost/opac/public/api/v1/buku/get-all
