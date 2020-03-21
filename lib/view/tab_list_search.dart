import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/view/detailScreen.dart';
import 'package:opac_android_kp/view/view_form.dart/createBuku.dart';

class TabListSearch extends StatefulWidget {
  @override
  _TabListSearchState createState() => _TabListSearchState();
}

class _TabListSearchState extends State<TabListSearch> {
  ApiService _apiService = ApiService();
  List<Datum> _posts = List<Datum>();
  List<Datum> _postsForDisplay = List<Datum>();

  TextEditingController editingController = TextEditingController();
  int page = 1;

  bool isLoading = false;

  @override
  void initState() {
    _apiService.fetchPost().then((value) {
      setState(() {
        _posts.addAll(value);
        _postsForDisplay = _posts;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: (Colors.blue),
            
            body: Column(children: <Widget>[
              _searchBar(),

              SizedBox(
                
                height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
                child: new Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: _list(),

                  
                )
                
                ),
              // Container(
              //     height: MediaQuery.of(context).size.height - 0,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(75.0),
              //           topRight: Radius.circular(75.0)),
              //     ),
              //     child: ListView(
              //         primary: false,
              //         padding: EdgeInsets.all(0.0),
              //         children: <Widget>[
              //           Padding(
              //               padding: EdgeInsets.only(top: 45.0, bottom: 0.0),
              //               child: Container(
              //                   height:
              //                       MediaQuery.of(context).size.height - 300.0,
              //                   child: _list()))
              //         ]))
            ])));

    // ListView(children: [
    //                 Text("data"),
    //                 Text("data"),
    //                 Text("data")

    //     Expanded(
    //   child: new FutureBuilder<List<Datum>>(
    //     future: _apiService.fetchPost(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) print(snapshot.error);

    //       return snapshot.hasData
    //           ? new ListView.builder(
    //               itemCount: _postsForDisplay.length,
    //               itemBuilder: (context, index) {
    //                 return _listtile(index);
    //               })
    //           : _circularProcces();
    //     },
    //   ),
    // ),
  }

  _list() {
    return FutureBuilder<List<Datum>>(
      future: _apiService.fetchPost(),
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
            style: TextStyle(color: Colors.white),
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

              setState(() {
                _postsForDisplay = _posts.where((post) {
                  var postTitle = post.judul.toLowerCase();
                  return postTitle.contains(text);
                }).toList();
              });
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
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 10.0),
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
          builder: (BuildContext context) => new DetailScreen(
                idBuku: _postsForDisplay[index].id,
              ))),
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
