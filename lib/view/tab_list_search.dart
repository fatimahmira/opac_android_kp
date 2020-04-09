import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
  bool isVisible = false;

  @override
  void initState() {
    _apiService.fetchPost().then((value) {
      setState(() {
        isVisible = false;
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
          // backgroundColor: (Colors.blue),
          body: Container(
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
                        fontSize: 30,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                  _searchBar(),
                  Visibility(visible: isVisible, child: _list()),
                ],
              )),
        ));
  }

  _sizedBox() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: new Container(
          decoration: BoxDecoration(color: Colors.white),
          child: _list(),
        ));
  }

  _typeAhead() {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontStyle: FontStyle.italic),
          decoration: InputDecoration(border: OutlineInputBorder())),
      suggestionsCallback: (pattern) async {
        return await _apiService.fetchPost();
      },
      itemBuilder: (context, suggestion) {
        return _listtile(suggestion);
      },
      onSuggestionSelected: (suggestion) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(idBuku: suggestion)));
      },
    );
  }

  _list() {
    return Expanded(
      child: FutureBuilder<List<Datum>>(
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
