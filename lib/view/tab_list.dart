import 'package:flutter/material.dart';
import 'package:opac_android_kp/view/tab_list_buku.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';


class TabList extends StatefulWidget {
  @override
  _TabListState createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ShiftingTabBar(
          color: Colors.blue,
          brightness: Brightness.dark,
          tabs: [
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
            TabListBuku(),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}