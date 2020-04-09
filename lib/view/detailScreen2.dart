import 'dart:async';
import 'dart:convert';

import 'package:expandable_card/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Buku.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/custom/custom_vertical_list.dart';
import 'package:opac_android_kp/view/tab_list.dart';
import 'package:opac_android_kp/view/tab_list_search.dart';
import 'package:opac_android_kp/view/view_form.dart/editBuku.dart';
import 'package:sweetalert/sweetalert.dart';

class DetailScreen2 extends StatefulWidget {
  // int id;
  // DetailScreen({this.id});

  int idBuku;
  DetailScreen2({this.idBuku});

  @override
  _DetailScreen2State createState() => _DetailScreen2State();
}

class _DetailScreen2State extends State<DetailScreen2> {
  int id = 0;
  ApiService _apiService = ApiService();
  Datum bukuClass;
  // BukuClass _bukuClass = BukuClass();
  List<Datum> _bukuTerkait = List<Datum>();

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
    return Stack(
      children: <Widget>[
        Container(
           decoration: new BoxDecoration(
            color: Colors.white,
          ),
        ),
        Container(
          height: 350,
          width: 500,
          decoration: new BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(50.0)),
              image: new DecorationImage(
                  alignment: Alignment.topLeft,
                  image: new AssetImage("images/img_2x.jpg"),
                  fit: BoxFit.fill)),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white, opacity: 1.0),
              actions: <Widget>[_editData(bukuClass), _hapusData(bukuClass)],
            ),
            body: new Container(
              height: double.infinity,
              padding:
                  const EdgeInsets.only(top: 150.0, right: 30.0, left: 30.0, bottom: 30.0),
              child: Container(
                child:
                  new 
                  Card(
                      shape: new RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: new FutureBuilder<Datum>(
                                future: _apiService.fetchDetail(widget.idBuku),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) print(snapshot.error);

                                  return snapshot.hasData
                                      ? _details(bukuClass)
                                      : _circularProcces();
                                },
                              ),
                            ),
                            _listBukuTerkait(),
                            
                          ]
                          )
                          ),
                
              ),
            )),
        
      ],
    );
  }

  _gambar() {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        alignment: Alignment.topCenter,
        image: AssetImage("images/baca_bukuu.jpg"),
        fit: BoxFit.contain,
      ),
    ));
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
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 30.0,
        ),
        Text(
          bk.noIndukBuku,
          style: TextStyle(),
          textAlign: TextAlign.right,
          
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
        Text(
          "Pengarang : ${bk.pengarang.isEmpty ? kosong : bk.pengarang}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Penerbit : ${bk.penerbit.isEmpty ? kosong : bk.penerbit}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          height: 20.0,
        ),
        Text(
          "Letak Rak",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child: Column(
              children: <Widget>[
                new Text("call_number_1 ",
                    style: TextStyle(color: Colors.orange)),
                new Text(
                    " ${bk.callNumber1.isEmpty ? kosong : bk.callNumber1} ")
              ],
            )),
            Card(
                child: Column(
              children: <Widget>[
                new Text("call_number_2",
                    style: TextStyle(color: Colors.orange)),
                new Text(
                    " ${bk.callNumber2.isEmpty ? kosong : bk.callNumber2}"),
              ],
            )),
            Card(
                child: Column(
              children: <Widget>[
                new Text("call_number_3",
                    style: TextStyle(color: Colors.orange)),
                new Text("${bk.callNumber3.isEmpty ? kosong : bk.callNumber3}"),
              ],
            )),
          ],
        ),
        Column(
          children: <Widget>[
            Text("Tahun Terbit"),
            Card(
                color: Colors.grey,
                shape: new RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black26,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(150.0))),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    " ${bk.tahunTerbit.isEmpty ? kosong : bk.tahunTerbit}",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
        
        // Expanded(
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: <Widget>[

        //     ],
        //   ),
        // )
      ],
    );
  }

  _listBukuTerkait() {
    return Expanded(
      child: FutureBuilder<List<Datum>>(
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
      ),
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
                        idBuku: _bukuTerkait[index].id,
                      )));
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

  _editData(Datum bukuClass1) {
    return IconButton(
        icon: Icon(Icons.mode_edit),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) =>
                new EditBuku(id: bukuClass.id, bk: bukuClass1))));
  }

  _hapusData(Datum bukuClass) {
    return IconButton(
        icon: Icon(Icons.restore_from_trash),
        onPressed: () {
          SweetAlert.show(context,
              title: "Anda yakin ingin menghapus buku",
              subtitle: "${bukuClass.judul}",
              style: SweetAlertStyle.confirm,
              showCancelButton: true, onPress: (bool isConfirm) {
            if (isConfirm) {
              _apiService.deleteBuku(bukuClass.id);
              SweetAlert.show(context,
                  style: SweetAlertStyle.success, title: "Success");
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new TabList()));
              return false;
            }
          });
        });
  }
}

//untuk menampilkan data buku terkait : http://localhost/opac/public/api/v1/buku/get-all
