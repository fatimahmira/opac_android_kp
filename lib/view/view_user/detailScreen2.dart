
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/custom/custom_vertical_list.dart';


class DetailScreen2 extends StatefulWidget {

  int idBuku;
  DetailScreen2({this.idBuku});

  @override
  _DetailScreen2State createState() => _DetailScreen2State();
}

class _DetailScreen2State extends State<DetailScreen2> {
  int id = 0;
  ApiService _apiService = ApiService();
  Datum bukuClass;
  List<Datum> _bukuTerkait = List<Datum>();
  static const TextStyle _textcard = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle _textcardbesar = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  void initState() {
    id = widget.idBuku;
    setState(() {
      _apiService.fetchDetail(id).then((value) {
        setState(() {
          bukuClass = value;
          _apiService.fetcBukuTerkait(id).then((value) {
            setState(() {
              _bukuTerkait.addAll(value);
            });
          });
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Detail Buku", style: TextStyle(
          fontFamily: "Bebas_Regular",)
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 139, 215, 234),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: Stack(
        children: <Widget>[
          _gambar(),
          ListView(
            children: <Widget>[
              Container(
                height: 150,
                color: Colors.transparent,
              ),
              Stack(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.only(top: 37.0, right: 10.0, left: 10.0),
                    color: Color.fromARGB(255, 139, 215, 234),
                    shape: new RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child:
                        // Expanded(
                        //   child: new
                        FutureBuilder<Datum>(
                      future: _apiService.fetchDetail(widget.idBuku),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                            ? _details(bukuClass)
                            : _circularProcces();
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 30.0),
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          side: BorderSide(color: Colors.pink),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: 
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: FutureBuilder<Datum>(
                          future: _apiService.fetchDetail(widget.idBuku),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);

                            return snapshot.hasData
                                ?  Text(
                                bukuClass.callNumber1 +" "+ bukuClass.callNumber2+" "+ bukuClass.callNumber3)
                                : CircularProgressIndicator();
                          },
                        ),

                      )
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.transparent,
                height: 50.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "Buku Terkait",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 250,
                child: _listBukuTerkait()
              ),
              Container(
                  height: 50,
              )

            ],
          ),
        ],
      ),
    );
  }

  _gambar() {
    return Container(
      height: MediaQuery.of(context).size.width / 2,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: new DecorationImage(
              image: new AssetImage("images/cover_detail.JPG"),
              fit: BoxFit.cover)),
    );
  }

  _circularProcces() {
    return Align(
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(
        backgroundColor: (Colors.deepOrangeAccent),
      ),
    );
  }

  _details(Datum bk) {
    String kosong = " - ";
    return Padding(
      padding: EdgeInsets.only(left: 4.0, right: 4.0),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 30.0,
              ),
              Text(bk.noIndukBuku, style: _textcard),
              Text(
                bk.judul,
                style: _textcardbesar,
                textAlign: TextAlign.right,
              ),
              Text(
                "Pengarang : ${bk.pengarang.isEmpty ? kosong : bk.pengarang}",
                style: _textcard,
                textAlign: TextAlign.right,
              ),
              Container(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.turned_in_not, color: Colors.white),
                      new Text(
                          " ${bk.tajukSubjek.isEmpty ? kosong : bk.tajukSubjek}",
                          overflow: TextOverflow.visible,
                          style: _textcard,
                          textAlign: TextAlign.center),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.book, color: Colors.white),
                      Column(
                        children: <Widget>[
                          new Text(
                              " ${bk.jumlahHalaman.isEmpty ? kosong : bk.jumlahHalaman + " lembar"}",
                              style: _textcard,
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        new Text("Penerbit", style: _textcard),
                        new Text(
                          " ${bk.penerbit.isEmpty ? kosong : bk.penerbit} ",
                            style: _textcard,
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: const Color(0xffffffff),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        new Text("Kota Terbit", style: _textcard),
                        new Text(
                            " ${bk.kotaTerbit.isEmpty ? kosong : bk.kotaTerbit}",
                            style: _textcard,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: const Color(0xffffffff),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        new Text("Tahun Terbit", style: _textcard),
                        new Text(
                            " ${bk.tahunTerbit.isEmpty ? kosong : bk.tahunTerbit}",
                            style: _textcard,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                new Icon(Icons.book, color: Colors.white),
                new Text(
                    "Jilid : ${bk.jilidKe.isEmpty ? kosong : bk.jilidKe + " lembar"}",
                    style: _textcard,
                    textAlign: TextAlign.center),
              ]),
              Row(children: <Widget>[
                new Icon(Icons.book, color: Colors.white),
                new Text(
                    "ISBN : ${bk.isbn.isEmpty ? kosong : bk.isbn + " lembar"}",
                    style: _textcard,
                    textAlign: TextAlign.center),
              ]),
              Row(children: <Widget>[
                new Icon(Icons.book, color: Colors.white),
                new Text(
                    "Edisi ke : ${bk.edisiKe.isEmpty ? kosong : bk.edisiKe + " lembar"}",
                    style: _textcard,
                    textAlign: TextAlign.center),
              ]),
              Row(children: <Widget>[
                new Icon(Icons.book, color: Colors.white),
                new Text(
                    "Cetakan ke : ${bk.cetakanKe.isEmpty ? kosong : bk.cetakanKe + " lembar"}",
                    style: _textcard,
                    textAlign: TextAlign.center),
              ]),
              Row(children: <Widget>[
                new Icon(Icons.book, color: Colors.white),
                new Text(
                    "Jumlah Eksemplar : ${bk.jumlahEksemplar.isEmpty ? kosong : bk.jumlahEksemplar + " lembar"}",
                    style: _textcard,
                    textAlign: TextAlign.center),
              ]),
              Row(children: <Widget>[
                new Icon(Icons.book, color: Colors.white),
                new Text(
                    "Tinggi buku : ${bk.tinggiBuku.isEmpty ? kosong : bk.tinggiBuku + " lembar"}",
                    style: _textcard,
                    textAlign: TextAlign.center),
              ]),
            ],
          ),
          Container(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  _listBukuTerkait() {
    return FutureBuilder<List<Datum>>(
      future: _apiService.fetcBukuTerkait(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _bukuTerkait.length,
                itemBuilder: (context, index) {
                  return _listtile(index);
                })
            : _circularProcces();
      },
    );
  }

  _listtile(index) {
    return Column(
      children: <Widget>[
        Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailScreen2(
                        idBuku: _bukuTerkait[index].id,)));
            },
            splashColor: Colors.amber,
            child: CustomVerticalList(
              judul: _bukuTerkait[index].judul,
            ),
          ),
        ),
      ],
    );
  }
}

//untuk menampilkan data buku terkait : http://localhost/opac/public/api/v1/buku/get-all
