import 'dart:async';
import 'dart:convert';

import 'package:expandable_card/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Buku.dart';
import 'package:opac_android_kp/view/view_form.dart/editBuku.dart';

class DetailScreen extends StatefulWidget {
  // int id;
  // DetailScreen({this.id});

  int idBuku;
  DetailScreen({this.idBuku});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int id = 0;
  ApiService _apiService = ApiService();
  BukuClass bukuClass;
  // BukuClass _bukuClass = BukuClass();
  var bukuTerkait = List<BukuClass>();

  @override
  void initState() {
    id = widget.idBuku;
    setState(() {
      _apiService.fetchDetail(id).then((value) {
        setState(() {
          bukuClass = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text("Detail Buku")),
        backgroundColor: Colors.lightBlueAccent,
        body: new ExpandableCardPage(
            page: Center(
              child: Text("data"),
            ),
            expandableCard: ExpandableCard(
              minHeight: 500,
              maxHeight: 1000,
              children: <Widget>[
                Expanded(
                  child: new FutureBuilder<BukuClass>(
                    future: _apiService.fetchDetail(widget.idBuku),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);

                      return snapshot.hasData
                          ? _details(bukuClass)
                          : _circularProcces();
                    },
                  ),
                ),
                _editData(bukuClass)
              ],
            )));
  }

  _circularProcces() {
    return Align(
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(
        backgroundColor: (Colors.deepOrangeAccent),
      ),
    );
  }

  _details(BukuClass bk) {
    return Container(
      padding: const EdgeInsets.all(27.0),
      child: new Card(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
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

  _editData(BukuClass bukuClass1) {
    return RaisedButton(
        child: Text("Edit Data"),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) =>
                new EditBuku(id: bukuClass.id, bk: bukuClass1))));
  }

  // _listBukuTerkait(indexz) {
  //   return ListTile(
  //       contentPadding: EdgeInsets.only(bottom: 10.0),
  //       title: Text(_bukuClass[index].judul));
  // }
}

//untuk menampilkan data buku terkait : http://localhost/opac/public/api/v1/buku/get-all
