import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opac_android_kp/Class/Buku.dart';
import 'package:opac_android_kp/Class/Post.dart';

import 'editBuku.dart';

class DetailScreen extends StatefulWidget {
  // int id;
  // DetailScreen({this.id});

  List<Datum> list;
  int index;
  DetailScreen({this.list, this.index});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
 int id = 0; 
  List<BukuClass> _bukuClass = List<BukuClass>();

  Future<List<BukuClass>> fetchBuku() async {
    final response =
    // await http.get('http://127.0.0.1/opac/public/api/v1/buku/get-all');
    
    //  await http.get('http://10.126.22.224/opac/public/api/v1/buku');
    await http.get('http://172.20.10.3/opac/public/api/v1/buku/detail/${id}');
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

  @override
  void initState() {
    id = widget.index;
    fetchBuku().then((value){
      setState(() {
        
        _bukuClass.addAll(value);
      });
    });
    // TODO: implement initState
    super.initState();
  }
  //  Post list ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("${widget.list[widget.index].judul}")),
      backgroundColor: Colors.lightBlueAccent,
      body: new Container(
        padding: const EdgeInsets.all(27.0),
        child: new Card(
          child: new Column(
            children: <Widget>[
              Container(
                height: 20.0,
              ),
              Text(
                widget.list[widget.index].judul,
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
                      new Text(" ${widget.list[widget.index].kotaTerbit} ")
                    ],
                  )),
                  Card(
                      child: Column(
                    children: <Widget>[
                      new Text("Cetakan Ke",
                          style: TextStyle(color: Colors.deepOrange)),
                      new Text(" ${widget.list[widget.index].cetakanKe}"),
                    ],
                  )),
                  Card(
                      child: Column(
                    children: <Widget>[
                      new Text("Jumlah Halaman",
                          style: TextStyle(color: Colors.deepOrange)),
                      new Text(
                          "${widget.list[widget.index].jumlahHalaman} lembar"),
                    ],
                  )),
                ],
              ),
                  _editData(),
                  _listBukuTerkait(widget.index)
            ],
            
          ),
        ),
      ),
    );
  }

  _editData() {
    return RaisedButton(
        child: Text("Edit Data"),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) 
            => new EditBuku(
              list: widget.list , index: widget.index,
              ))));
  }

  _listBukuTerkait(index) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 10.0),
      title: Text(_bukuClass[index].judul)
    );
  }
}

//untuk menampilkan data buku terkait : http://localhost/opac/public/api/v1/buku/get-all
