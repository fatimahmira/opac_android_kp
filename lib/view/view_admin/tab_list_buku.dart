import 'package:animated_list_view_scroll/animated_list_view_scroll.dart';
import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/custom/custom_list_tile.dart';
import 'package:opac_android_kp/view/view_admin/detailScreen.dart';
import 'package:opac_android_kp/view/view_user/detailScreen2.dart';


class TabListBukuAdmin extends StatefulWidget {
  @override
  _TabListBukuAdminState createState() => _TabListBukuAdminState();
}

class _TabListBukuAdminState extends State<TabListBukuAdmin> {
  ApiService _apiService = ApiService();
  List<Datum> _postsForDisplay = List<Datum>();

  TextEditingController editingController = TextEditingController();
  int page = 1;
  int data = 10;

  bool isLoading = false;

  bool isVisible = false;

  @override
  void initState() {
    _apiService.fetchPaginate(page).then((value) {
      setState(() {
        isVisible = false;
        _postsForDisplay.addAll(value);
          _apiService.simpan(_postsForDisplay[0]);
          
      });
    });
    super.initState();
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
                "Daftar Buku admin",
                style: TextStyle(
                  fontFamily: "Bebas_Regular",
                    fontSize: 30,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
//              FutureBuilder(
//                  future: _apiService.fetchPaginate(page),
//                  builder: (context, ) {
//                    ConnectionState.active ? Text("koneksi aktif") : Text("koneksi tdk aktif");
//                  }
//              ),
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
      child: FutureBuilder<List<Datum>>(
        future: _apiService.fetchPaginate(page),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                  itemCount: _postsForDisplay.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: _listtile(index),
                    );
                  })
              : _circularProcces;
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
            Text("Please Wait",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),),
      ],
    );
    // Align(
    //   alignment: Alignment.topCenter,
    //   child: CircularProgressIndicator(),
    // );
  }

  _listtile(index) {
    return Column(
      children: <Widget>[
        Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailScreen(
                        idBuku: _postsForDisplay[index].id,
                      )));
            },
            splashColor: Colors.grey,
            child: CustomListTile(
              judul: _postsForDisplay[index].judul,
              pengarang: _postsForDisplay[index].pengarang,
              subjek: _postsForDisplay[index].tajukSubjek,
            ),
          ),
        ),
      ],
    );
  }
}
