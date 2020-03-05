import 'package:flutter/material.dart';

class TabListBuku extends StatefulWidget {
  @override
  _TabListBukuState createState() => _TabListBukuState();
}

class _TabListBukuState extends State<TabListBuku> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFecf0f1),
            ),
          ),
          ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Card(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(7.0, 16.0, 0.0, 0.0),
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 90.0,
                              height: 100.0,
                              color: Colors.black,
                            ),
                            Text("")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                    width: 75.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20.0,
                            spreadRadius: -7.5,
                            color: Colors.transparent.withOpacity(0.5),
                            offset: Offset(
                              0.0,
                              10.0,
                            )),
                      ],
                      image: DecorationImage(
                        image: AssetImage("images/book.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
