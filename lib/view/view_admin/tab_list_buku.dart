import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/HiveModel.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/custom/custom_list_tile.dart';
import 'package:opac_android_kp/view/view_admin/detailScreen.dart';
import 'package:opac_android_kp/view/view_form.dart/createBuku.dart';

class TabListBukuAdmin extends StatefulWidget {
  @override
  _TabListBukuAdminState createState() => _TabListBukuAdminState();
}

class _TabListBukuAdminState extends State<TabListBukuAdmin> {
  ApiService _apiService = ApiService();
  List _postsForDisplay = List();

  TextEditingController editingController = TextEditingController();
  int page = 1;
  int data = 10;

//  kalau data cache dat set true
  bool isCache = false;

  bool isLoading = false;

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    simpanDataBuku(page);
  }

  Future simpanDataBuku(int page) async {
    HiveModel _hiveModel = HiveModel();
    String buku = "key admin";

    try {
      // cek data cache
      var dataCache;
      dataCache = await _hiveModel.getCache(buku);
      if (dataCache == null ||
          dataCache['lastFetchTime'].isBefore(
              DateTime.now().subtract(dataCache['cacheValidDuration']))) {
        var res = await _apiService.fetchPaginate(page);

        setState(() {
          for (var data in res) {
            _postsForDisplay.add(data);
          }
          // simpan data
          Map<String, dynamic> mapCache = {
            'cacheValidDuration': Duration(minutes: 30).toString(),
            'lastFetchTime': DateTime.now(),
            'data': jsonEncode(_postsForDisplay)
          };
          _hiveModel.addCache(mapCache, buku);
        });
      } else {
        setState(() {
          isCache = true;
          for (var data in dataCache['data']) {
            _postsForDisplay.add(data);
          }
        });
      }
    } catch (e) {
      print("else terakhir asdgr333");
    }
  }

  Future getMoreDataBuku(int page) async {
    print('more');
    HiveModel _hiveModel = HiveModel();
    String buku = "key admin";

    try {
      var res = await _apiService.fetchPaginate(page);
      print(res.runtimeType);
      setState(() {
        //        set iscache false
        isCache = false;

        for (var data in res) {
          _postsForDisplay.add(data);
        }
        // simpan data
        Map<String, dynamic> mapCache = {
          'cacheValidDuration': Duration(minutes: 30).toString(),
          'lastFetchTime': DateTime.now(),
          'data': jsonEncode(_postsForDisplay)
        };

        _hiveModel.addCache(mapCache, buku);
      });
    } catch (e) {
      print("else terakhir");
    }
  }

  Future _loadData() async {
    await Future.delayed(Duration(seconds: 1, milliseconds: 100));
    setState(() {
      isLoading = false;
      page++;
      getMoreDataBuku(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: (Color.fromARGB(255, 139, 215, 234)),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new CreateBuku()));
              },
              tooltip: 'tambah',
              child: Icon(Icons.add),
            ),
            body: Column(children: <Widget>[
              Container(
                height: 15,
              ),
              Text(
                "Daftar Buku admin",
                style: TextStyle(
                    fontFamily: "Bebas_Regular",
                    fontSize: 30,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              _paginate(),
              // _list(),
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
        child: _postsForDisplay != null
            ? ListView.builder(
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
            : _circularProcces());
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
  }

  _listtile(index) {
    String kosong = "-";
    Datum datum;
    String typeData = _postsForDisplay[index].runtimeType.toString();
    print(_postsForDisplay[index]);
    if (typeData == "_InternalLinkedHashMap<String, dynamic>") {
      datum = Datum.fromJson(_postsForDisplay[index]);
    } else {
      datum = _postsForDisplay[index];
    }
    return Column(
      children: <Widget>[
        Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailScreen(
                        idBuku: datum.id,
                      )));
            },
            splashColor: Colors.grey,
            child: CustomListTile(
              judul: datum.judul == null ? kosong : datum.judul,
              pengarang: datum.pengarang == null ? kosong : datum.pengarang,
              subjek: datum.tajukSubjek == null ? kosong : datum.penerbit,
            ),
          ),
        ),
      ],
    );
  }
}
