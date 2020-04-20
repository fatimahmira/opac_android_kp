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
  List<Datum> _postsForDisplay = List<Datum>();

  TextEditingController editingController = TextEditingController();
  int page = 1;
  String text = "";

  bool isLoading = false;
  bool isVisible = false;

  @override
  void initState() {
    this.text = editingController.text.toString();
    // _apiService.fetchPost().then((value) {
    //   setState(() {
    //     isVisible = false;
    //     _posts.addAll(value);
    //     _postsForDisplay = _posts;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/buku.GIF"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
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
              Visibility(visible: isVisible, child: _list()),
            ],
          )),
    );
  }

  _sizedBox() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: new Container(
          decoration: BoxDecoration(color: Colors.white),
          child: _list(),
        ));
  }

  _list() {
    return Expanded(
      child: FutureBuilder<List<Datum>>(
        // future: _apiService.fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ListView.builder(
                  itemCount: _postsForDisplay.length,
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
                suffixIcon: _searchBy(),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.white))),
            controller: editingController,
             onChanged: (text) {
              text = text.toLowerCase();
              if (text.isNotEmpty) {
                setState(() {
                  isVisible = true;
                  _postsForDisplay = _posts.where((post) {
                    var postTitle = post.judul.toLowerCase();
                    return postTitle.contains(text);
                  }).toList();
                });
              } else if (text.isEmpty) {
                isVisible = false;
              }
            },
          ),
        ),
      ],
    );
  }

  _searchBy() {
    return IconButton(
        icon: Icon(Icons.low_priority),
        onPressed: () {
          return _alertDialog();
        });
  }

  _listtile(index) {
    return Card(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2.0),
      color: Colors.white,
      child: ListTile(
        trailing: Icon(Icons.arrow_forward_ios),
        contentPadding: EdgeInsets.only(left: 20.0, right: 10.0),
        title: Text(_postsForDisplay[index].judul),
        subtitle: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Pengarang : ${_postsForDisplay[index].pengarang}"),
            Text("Letak Rak : ${_postsForDisplay[index].callNumber1}")
          ],
        ),
        leading: new Icon(Icons.library_books),
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new DetailScreen2(
                  idBuku: _postsForDisplay[index].id,
                ))),
      ),
    );
  }

  void _alertDialog() {
    AlertDialog alertD = new AlertDialog(
      content: new Text("Filter pencarian berdasarkan ..."),
      actions: <Widget>[
        Radio(value: null, groupValue: null, onChanged: null),
        RaisedButton(
          color: Colors.lightBlue,
          child: new Text("ok"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
        //
      ],
    );

    showDialog(context: context, child: alertD);
    // Text("data")
  }
}
