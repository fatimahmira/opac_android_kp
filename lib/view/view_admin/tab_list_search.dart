import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/view/view_admin/detailScreen.dart';
import 'package:opac_android_kp/view/view_user/detailScreen2.dart';

class TabListSearchAdmin extends StatefulWidget {
  @override
  _TabListSearchAdminState createState() => _TabListSearchAdminState();
}

class _TabListSearchAdminState extends State<TabListSearchAdmin> {
  ApiService _apiService = ApiService();
  List<Datum> _posts = List<Datum>();

  TextEditingController editingController = TextEditingController();
  int page = 1;
  String text = ""; 
  String kosong = "-";
  bool isLoading = false;

  @override
  void initState() {
    this.text = editingController.text.toString();
    _apiService.searchJudul(text).then((value) {
      setState(() {
        _posts.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: (Color.fromARGB(255, 139, 215, 234)),
          body: Column(
            children: <Widget>[
              Container(
                height: 15,
              ),
              Text(
                "Cari Buku Berdasarkan",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              _searchBar(),
              Visibility(visible: isLoading, child: _list()),
            ],
          )),
    );
  }


  _list() {
    return Expanded(
      child: FutureBuilder<List<Datum>>(
        future: _apiService.searchJudul(text),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    return _listtile(index);
                  })
              : _circularProcces();
        },
      ),
    );
  }

  _circularProcces() {
    return Align(
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(),
    );
  }

  _searchBar() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextField(
            // style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.white))),
            controller: editingController,
            onChanged: (textt) {
              this.text = textt;
              if (textt.isEmpty) {
                isLoading = false;
              } else {
                setState(() {
                  isLoading = true;
                  _posts.clear();
                  _apiService.searchJudul(textt).then((value) {
                    setState(() {
                      _posts.addAll(value);
                    });
                  });
                });
              }
            },
          ),
        ),
      ],
    );
  }

  _listtile(index) {
    
    return Card(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2.0),
      color: Colors.white,
      child: ListTile(
        trailing: Icon(Icons.arrow_forward_ios),
        contentPadding: EdgeInsets.only(left: 20.0, right: 10.0),
        title: Text(_posts[index].judul ?? kosong),
        subtitle: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Pengarang : ${_posts[index].pengarang ?? kosong}"),
            Text("Letak Rak : ${_posts[index].callNumber1 ?? kosong}")
          ],
        ),
        leading: new Icon(Icons.library_books),
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new DetailScreen(
                  idBuku: _posts[index].id,
                ))),
      ),
    );
  }
}
