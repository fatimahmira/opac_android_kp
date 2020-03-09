import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opac_android_kp/Class/Post.dart';

import '../detailScreen.dart';

class TabSearch extends StatefulWidget {
  @override
  _TabSearchState createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  List<Datum> _posts = List<Datum>();
  // List<Datum> _datum = List<Datum>();

  List<Datum> _postsForDisplay = List<Datum>();

  TextEditingController editingController = TextEditingController();
  int page = 1;

  bool isLoading = false;

  Future<List<Datum>> fetchPost() async {
    final response =
        // await http.get('http://127.0.0.1/opac/public/api/v1/buku/get-all');

        //  await http.get('http://10.126.22.224/opac/public/api/v1/buku');
        await http.get('http://172.16.145.26/opac/public/api/v1/buku');
    // await Future.delayed(Duration(seconds: 0, milliseconds: 2000));

    var datum = List<Datum>();

    if (response.statusCode == 200) {
      var respon = json.decode(response.body);
      var postsJson = respon['data'];

      for (var postJson in postsJson) {
        datum.add(Datum.fromJson(postJson));

        isLoading = false;
      }
      return datum;
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    fetchPost().then((value) {
      setState(() {
        _posts.addAll(value);

        _postsForDisplay = _posts;
      });
    });
    super.initState();
  }

  static const TextStyle title =
      TextStyle(
        color: (Colors.black),
        fontWeight: FontWeight.bold, 
        fontSize: 30,
        fontFamily: "Arial"
        );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Column(
        children: <Widget>[
          Container(padding: EdgeInsets.only(top: 25.0),),
          Text(
            "Cari Buku",
            style: title,
          ),
          Container(),
          _searchBar(),
          // _searchBy(),

          Expanded(
            child: new FutureBuilder<List<Datum>>(
              future: fetchPost(),
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
          ),
        ],
      ),
      // ),
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
            decoration: InputDecoration(
                labelText: "Search",
                suffixIcon: _searchBy(),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
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
                // idBuku: _postsForDisplay[index].id,
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
