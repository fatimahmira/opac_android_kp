import 'package:animated_list_view_scroll/animated_list_view_scroll.dart';
import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/custom/custom_list_tile.dart';
import 'package:opac_android_kp/view/detailScreen.dart';

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
    // _apiService.fetchPaginate(page).then((value) {
    //   setState(() {
    //     isVisible = false;
    //     _postsForDisplay.addAll(value);
    //   });
    // });
    _apiService.fetchPost().then((value) {
      setState(() {
        isVisible = false;
        _postsForDisplay.addAll(value);
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
                "Daftar Buku",
                style: TextStyle(
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
          // setState(() {
          //   isLoading = true;
          // });
          _loadData();
        }
      },
      child: _list(),
    );
  }

  _list() {
    return Expanded(
      child: FutureBuilder<List<Datum>>(
        future: _apiService.fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? AnimatedListViewScroll(
                  itemBuilder: (context, index) {
                    return AnimatedListViewItem(
                      key: GlobalKey(),
                      index: index,
                      animationBuilder: (context, index, controller) {
                        Animation<Offset> animation = Tween<Offset>(
                                begin: Offset(1.0, 0.0), end: Offset.zero)
                            .animate(controller);
                        return SlideTransition(
                            position: animation, child: _listtile(index));
                      },
                    );
                    // return _listtile(index);
                  },
                  animationOnReverse: true,
                  animationDuration: Duration(milliseconds: 200),
                  itemHeight: 139,
                  itemCount: _postsForDisplay.length)
              // new ListView.builder(
              //     padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
              //     itemCount: _postsForDisplay.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: EdgeInsets.only(bottom: 10.0),
              //         child: _listtile(index),
              //       );
              //     })
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
