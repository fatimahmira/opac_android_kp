import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opac_android_kp/detailScreen.dart';

import 'Class/Post.dart';


enum Filter { judul, penerbit, pengarang }

class ListBuku extends StatefulWidget {
  ListBuku({Key key}) : super(key: key);

  @override
  _ListBukuState createState() => _ListBukuState();
}

class _ListBukuState extends State<ListBuku> {
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
    await http.get('http://172.20.10.3/opac/public/api/v1/buku');
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Column(
          children: <Widget>[
                _searchBar(),
                // _searchBy(),
              
            Expanded(
              child: ListView.builder(
                itemCount: _postsForDisplay.length,
                itemBuilder: (context, index) {
                  // return  _listItem(index +1);
                  return _listtile(index);
                },
              ),
            ),
          ],
        ),
      ),
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
      onPressed: (){
        return _alertDialog();
      } );
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
                list: _postsForDisplay,
                index: index,
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
        onPressed: (){
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
