import 'package:flutter/material.dart';

class TabListSubjek extends StatefulWidget {
  @override
  _TabListSubjekState createState() => _TabListSubjekState();
}

class _TabListSubjekState extends State<TabListSubjek> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/buku.GIF"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.tablet_mac),
              title: Text("Tentang Aplikasi"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Login sebagai Admin"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
        ],
      ),
    );
  }
}
