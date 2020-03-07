import 'package:flutter/material.dart';

class TabListSubjek extends StatefulWidget {
  @override
  _TabListSubjekState createState() => _TabListSubjekState();
}

class _TabListSubjekState extends State<TabListSubjek> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xfff1f2f6),
      child: ListView(
        children: <Widget>[
          Card(
            child:ListTile(
              title: Text("dwdwdw"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          )
        ],
      ),
    );
  }
}
