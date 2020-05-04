import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/CacheModel.dart';
import 'package:opac_android_kp/Class/HiveModel.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/custom/custom_list_tile.dart';
import 'package:opac_android_kp/view/view_user/detailScreen2.dart';

class TabListBuku extends StatefulWidget {
  @override
  _TabListBukuState createState() => _TabListBukuState();
}

class _TabListBukuState extends State<TabListBuku> {
  
  ApiService _apiService = ApiService();
  List<Datum> _postsForDisplay = List<Datum>();
  TextEditingController editingController = TextEditingController();
  int page = 1;
  int data = 10;

  bool isLoading = false;

  bool isVisible = false;

  @override
  void initState() {
    // simpanDataBuku(page).then((value){
    //   setState(() {
    //     _postsForDisplay.add(value);
    //   });
    // });
    super.initState();
  }

   Future simpanDataBuku(int page) async {
    HiveModel _hiveModel = HiveModel();
    // List<Datum> _datum;
    String buku = "key";

    try {
      // cek data cache
      print('test');
      CacheModel dataCache;
      dataCache = await _hiveModel.getCache(buku);
      // print(dataCache);

      if(dataCache == null || dataCache.lastFetchTime.isBefore(DateTime.now().subtract(dataCache.cacheValidDuration))){
        print("data cache null");
        _postsForDisplay = await _apiService.fetchPaginate(page);
        // simpan data
        CacheModel cacheModel = CacheModel(
          cacheValidDuration: Duration(minutes: 30),
          lastFetchTime: DateTime.now(),
          data: _postsForDisplay
        );
        _hiveModel.addCache(cacheModel, buku);
        print(jsonEncode(dataCache.data));

      } else {
        // _postsForDisplay = datumFromJson((dataCache.data));
        print("else terakhir");
        print(jsonEncode(dataCache.data));
        // return jsonEncode(dataCache.data); 
      }
    } catch (e) {}
  }



  Future _loadData() async {
    await Future.delayed(Duration(seconds: 1, milliseconds: 100));
    setState(() {
      isLoading = false;
      page++;
      initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: (Color.fromARGB(255, 139, 215, 234)),
            body: Column(children: <Widget>[
              Container(
                height: 15,
              ),
              Text(
                "Daftar Buku",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              // _listtiles(),
              _paginate(),
              Container(
                height: isLoading ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              ),
            ])));
  }

  _paginate() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          setState(() {
            isLoading = true;
          });
          _loadData();
        }
      },
      child: _list(),
    );
  }

  _list() {
    return Expanded(
      child: FutureBuilder<List<Datum>>(
        future: _apiService.fetchPaginate(page),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ListView.builder(
                  cacheExtent: 10.0,
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                  itemCount: _postsForDisplay.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: _listtile(index),
                      // child: _listtiles()
                    );
                  })
              : _circularProcces();
        },
      ),
    );
  }

  _circularProcces() {
    return Column(
      children: <Widget>[
        Container(
            height: 110,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/buku.GIF"),
                fit: BoxFit.cover,
              ),
            )),
        Text(
          "Please Wait",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
    // Align(
    //   alignment: Alignment.topCenter,
    //   child: CircularProgressIndicator(),
    // );
  }

  _listtile(index) {
    String kosong = "-";
    return Column(
      children: <Widget>[
        Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailScreen2(
                        idBuku: _postsForDisplay[index].id,
                      )));
            },
            splashColor: Colors.grey,
            child: CustomListTile(
              judul: _postsForDisplay[index].judul == null
                  ? kosong
                  : _postsForDisplay[index].judul,
              pengarang: _postsForDisplay[index].pengarang == null
                  ? kosong
                  : _postsForDisplay[index].pengarang,
              subjek: _postsForDisplay[index].tajukSubjek == null
                  ? kosong
                  : _postsForDisplay[index].penerbit,
            ),
          ),
        ),
      ],
    );
  }
}
