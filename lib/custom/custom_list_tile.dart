import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String judul;
  final String pengarang;
  final String subjek;

  const CustomListTile({Key key, this.judul, this.pengarang, this.subjek})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 135.0,
        child: Container(
            child: Padding(
          padding: EdgeInsets.all(9.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  // color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage("images/coverbuku.JPG"),
                    fit: BoxFit.fill,
                  ),
                )),
              ),
              Expanded(
                child: ListBuku(
                    judul: judul, pengarang: pengarang, subjek: subjek),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class ListBuku extends StatelessWidget {
  final String judul;
  final String pengarang;
  final String subjek;

  const ListBuku({Key key, this.judul, this.pengarang, this.subjek})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Text(
              judul,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Flexible(
            flex: 1,
            child: Text(
              pengarang,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
          Flexible(
            flex: 1,
            child: Text(
              subjek,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
