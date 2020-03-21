import 'package:flutter/material.dart';
import 'package:opac_android_kp/Class/Buku.dart';

class EditBuku extends StatefulWidget {
  final BukuClass bk;
  final int id;

  EditBuku({this.id, this.bk});

  @override
  _EditBukuState createState() => _EditBukuState();
}

class _EditBukuState extends State<EditBuku> {
  BukuClass bukuClass = BukuClass();

  TextEditingController judul;
  TextEditingController pengarang;
  TextEditingController callNumber1;
  TextEditingController callNumber2;
  TextEditingController callNumber3;
  TextEditingController tajukSubjek;
  TextEditingController jilidKe;
  TextEditingController seri;
  TextEditingController edisiKe;
  TextEditingController cetakanKe;
  TextEditingController penerbit;
  TextEditingController kotaTerbit;
  TextEditingController tahunTerbit;
  TextEditingController jumlahHalaman;
  TextEditingController ilustrasi;
  TextEditingController bibliografi;
  TextEditingController isbn;
  TextEditingController tinggiBuku;
  TextEditingController diterimaDari;
  TextEditingController jumlahEksemplar;

  void editData() {}

  @override
  void initState() {

    judul = new TextEditingController(text: widget.bk.judul);
    pengarang = new TextEditingController(text: widget.bk.pengarang);
    callNumber1 = new TextEditingController(text: widget.bk.callNumber1);
    callNumber2 = new TextEditingController(text: widget.bk.callNumber2);
    callNumber3 = new TextEditingController(text: widget.bk.callNumber3);
    tajukSubjek = new TextEditingController(text: widget.bk.tajukSubjek);
    jilidKe = new TextEditingController(text: widget.bk.jilidKe);




    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Buku"),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        padding: const EdgeInsets.all(27.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                _fieldJudul(),
                _fieldPengarang(),
                _fieldcallNumber1(),
                _fieldcallNumber2(),
                _fieldcallNumber3(),
                _fieldSubjek(),
                _fieldjilidKe(),
                _btnSimpan()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fieldJudul() {
    return TextFormField(
      controller: judul,
     
      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Judul Buku"),
    );
  }

  _fieldPengarang() {
    return TextFormField(
      controller: pengarang,
      // onSaved: (e) => password = e,
      decoration: InputDecoration(
        labelText: "Pengarang",
      ),
    );
  }

  _fieldcallNumber1() {
    return TextFormField(
      controller: callNumber1,
      
      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "callNumber1"),
    );
  }

  _fieldcallNumber2() {
    return TextFormField(
      controller: callNumber2,
      
      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "callNumber2"),
    );
  }

  _fieldcallNumber3() {
    return TextFormField(
      controller: callNumber3,
      
      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "callNumber3"),
    );
  }

    _fieldSubjek() {
    return TextFormField(
      controller: judul,
      
      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Tajuk Subjek"),
    );
  }

  _fieldjilidKe() {
    return TextFormField(
      controller: jilidKe,
      
      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "jilid Ke"),
    );
  }



  _btnSimpan() {
    return RaisedButton(
        child: Text("Simpan"),
        onPressed: () {
          editData();
          Navigator.pop(context);
        });
  }
}
