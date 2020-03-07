import 'package:flutter/material.dart';

class CustomDescTile extends StatelessWidget {
  const CustomDescTile({this.cover, this.judul, this.pengarang, this.subjek});

  final Widget cover;
  final String judul;
  final String pengarang;
  final String subjek;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: cover,
            ),
            Expanded(
              flex: 2,
              child: _BukuDeskripsi(
                  judul: judul, pengarang: pengarang, subjek: subjek),
            )
          ],
        ),
      )
    );
  }
}

class _BukuDeskripsi extends StatelessWidget {
  const _BukuDeskripsi({Key key, this.judul, this.pengarang, this.subjek})
      : super(key: key);

  final String judul;
  final String pengarang;
  final String subjek;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            judul,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            pengarang,
            style: const TextStyle(fontSize: 14.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            subjek,
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
