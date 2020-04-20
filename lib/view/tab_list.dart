import 'package:flutter/material.dart';
import 'package:opac_android_kp/view/view_user/tab_list_buku.dart';
import 'package:opac_android_kp/view/view_user/tab_list_search.dart';
import 'package:opac_android_kp/view/view_user/tab_list_subjek.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class TabList extends StatefulWidget {
  @override
  _TabListState createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: ShiftingTabBar(
              color: Colors.blue,
              brightness: Brightness.dark,
              tabs: [
                ShiftingTab(
                  icon: Icon(Icons.search),
                  text: "Cari Buku",
                ),
                ShiftingTab(
                  icon: Icon(Icons.library_books),
                  text: "Buku",
                ),
                ShiftingTab(
                  icon: Icon(Icons.subject),
                  text: "Subject",
                )
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                TabListSearch(),
                TabListBuku(),
                TabListSubjek(),
              ],
            ),
          ),
        )
        );
  }
}
