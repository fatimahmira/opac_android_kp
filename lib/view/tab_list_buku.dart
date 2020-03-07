import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:opac_android_kp/custom/custom_description_tile.dart';

class TabListBuku extends StatefulWidget {
  @override
  _TabListBukuState createState() => _TabListBukuState();
}

class _TabListBukuState extends State<TabListBuku> {
  @override
  Widget build(BuildContext context) {
    return Container(
    color: Color(0xfff1f2f6),
      child:  ListView(
        padding: const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
        itemExtent: 135.0,
        children: <CustomDescTile>[
          CustomDescTile(
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
            judul: "bfefefefefefeyfgyegfeygfyegfyegfeygfeygfeyfgeyfgeyfgeyfgyegfyegfyegfe",
            pengarang: 'Okyra Asyrafi Guchan',
            subjek: 'bakwan',
          )
        ],
      ),
    );
     
  }
}
