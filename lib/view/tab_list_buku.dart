import 'package:flutter/material.dart';
import 'package:opac_android_kp/custom/custom_description_tile.dart';
import 'package:toast/toast.dart';

class TabListBuku extends StatefulWidget {
  @override
  _TabListBukuState createState() => _TabListBukuState();
}

class _TabListBukuState extends State<TabListBuku> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff1f2f6),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
        children: <Widget>[
          Material(
            child: InkWell(
              onTap: () {
                Toast.show("eefefe", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
              splashColor: Colors.amber,
              child: CustomDescTile(
                cover: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage("images/learning.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                judul:
                    "bfefefefefefeyfgyegfeygfyegfyegfeygfeygfeyfgeyfgeyfgeyfgyegfyegfyegfe",
                pengarang: 'Okyra Asyrafi Guchan',
                subjek: 'bakwan',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
