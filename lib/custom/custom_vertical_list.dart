import 'package:flutter/material.dart';

class CustomVerticalList extends StatelessWidget {

  final String judul;

  const CustomVerticalList({Key key, this.judul}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        height: 250,
        width: 120,
        child: Card(
            child: Padding(
          padding: EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.1,
                child: Container(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: Colors.black,
                image: DecorationImage(
                  
                  image: AssetImage("images/learning.jpg"),
                  fit: BoxFit.contain,
                ),
              )),
              ),
              Expanded(
                child: BukuTerkait(
                    judul: judul, ),
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

  const BukuTerkait({Key key, this.judul, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
      child: Text(
                judul,
                // style: const TextStyle(
                //   fontWeight: FontWeight.w600,
                //   fontSize: 16.0,
                // ),
              ),
      
    );
  }
}