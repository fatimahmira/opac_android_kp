import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomVerticalList extends StatelessWidget {
  final String judul;

  const CustomVerticalList({Key key, this.judul}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        height: 200,
        width: 150,
        child: Card(
          color: Color.fromARGB(255, 136, 177, 195),
            child: Padding(
          padding: EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.1,
                child: Container(
                  height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  color: Color.fromARGB(255, 136, 177, 195),
                  image: DecorationImage(
                    image: AssetImage("images/coverbuku.JPG"),
                    fit: BoxFit.contain,
                  ),
                )),
              ),
              Expanded(
                child: BukuTerkait(
                  judul: judul,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class BukuTerkait extends StatelessWidget {
  final String judul;

  const BukuTerkait({
    Key key,
    this.judul,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 0.0),
      child: Text(
        judul,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13.0,
          color: Colors.white
        ),

        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
