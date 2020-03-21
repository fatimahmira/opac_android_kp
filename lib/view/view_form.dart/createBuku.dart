// import 'dart:html';

import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Post.dart';

final format = DateFormat("yyyy");

class CreateBuku extends StatefulWidget {
  @override
  _CreateBukuState createState() => _CreateBukuState();
}

class _CreateBukuState extends State<CreateBuku> {
  ApiService _apiService = new ApiService();

  TextEditingController judul = new TextEditingController();
  TextEditingController pengarang = new TextEditingController();
  TextEditingController noIndukBuku = new TextEditingController();
  TextEditingController callNumber1 = new TextEditingController();
  TextEditingController callNumber2 = new TextEditingController();
  TextEditingController callNumber3 = new TextEditingController();
  TextEditingController tajukSubjek = new TextEditingController();
  TextEditingController jilidKe = new TextEditingController();
  TextEditingController seri = new TextEditingController();
  TextEditingController edisiKe = new TextEditingController();
  TextEditingController cetakanKe = new TextEditingController();
  TextEditingController penerbit = new TextEditingController();
  TextEditingController kotaTerbit = new TextEditingController();
  TextEditingController tahunTerbit = new TextEditingController();
  TextEditingController jumlahHalaman = new TextEditingController();
  TextEditingController ilustrasi = new TextEditingController();
  TextEditingController bibliografi = new TextEditingController();
  TextEditingController isbn = new TextEditingController();
  TextEditingController tinggiBuku = new TextEditingController();
  TextEditingController diterimaDari = new TextEditingController();
  TextEditingController jumlahEksemplar = new TextEditingController();
  TextEditingController selesaiDiproses = new TextEditingController();

  void createData() {
    int _id;
    String _judul = judul.text.toString();
    String _pengarang = pengarang.text.toString();
    String _noIndukBuku = noIndukBuku.text.toString();
    String _callNumber1 = callNumber1.text.toString();
    String _callNumber2 = callNumber2.text.toString();
    String _callNumber3 = callNumber3.text.toString();
    String _tajukSubjek = tajukSubjek.text.toString();
    String _jilidKe = jilidKe.text.toString();
    String _seri = seri.text.toString();
    String _edisiKe = edisiKe.text.toString();
    String _cetakanKe = cetakanKe.text.toString();
    String _penerbit = penerbit.text.toString();
    String _kotaTerbit = kotaTerbit.text.toString();
    String _tahunTerbit = tahunTerbit.text.toString();
    String _jumlahHalaman = jumlahHalaman.text.toString();
    String _ilustrasi = ilustrasi.text.toString();
    String _bibliografi = bibliografi.text.toString();
    String _isbn = isbn.text.toString();
    String _tinggiBuku = tinggiBuku.text.toString();
    String _diterimaDari = diterimaDari.text.toString();
    String _jumlahEksemplar = jumlahEksemplar.text.toString();
    DateTime _selesaiDiproses = DateTime.now();

    Datum data = Datum(
      id: _id,
      noIndukBuku: _noIndukBuku,
      judul: _judul,
      pengarang: _pengarang,
      penerbit: _penerbit,
      callNumber1: _callNumber1,
      callNumber2: _callNumber2,
      callNumber3: _callNumber3,
      tajukSubjek: _tajukSubjek,
      jilidKe: _jilidKe,
      seri: _seri,
      edisiKe: _edisiKe,
      cetakanKe: _cetakanKe,
      kotaTerbit: _kotaTerbit,
      tahunTerbit: _tahunTerbit,
      jumlahHalaman: _jumlahHalaman,
      ilustrasi: _ilustrasi,
      bibliografi: _bibliografi,
      isbn: _isbn,
      tinggiBuku: _tinggiBuku,
      diterimaDari: _diterimaDari,
      jumlahEksemplar: _jumlahEksemplar,
      selesaiDiproses: _selesaiDiproses,
    );

    _apiService.createBuku(data).then((isSuccess) {
      setState(() {
        if (isSuccess) {
          print("input data berhasil");
          _sweetAlertSuccess();
        } else {
          _sweetAlertError();
          // showDialog(context: context, child: Text("gagal input text"));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data Buku"),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        padding: const EdgeInsets.all(27.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                _fieldnoIndukBuku(),
                _fieldJudul(),
                _fieldPengarang(),
                _fieldTahunTerbit(),
                _fieldcallNumber1(),
                _fieldcallNumber2(),
                _fieldcallNumber3(),
                _fieldSubjek(),
                _fieldjilidKe(),
                _btnSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sweetAlertSuccess() {
    return SweetAlert.show(
      context,
      title: "Berhasil",
      subtitle: "menambahkan data",
      style: SweetAlertStyle.success,
    );
  }

   _sweetAlertError() {
    return SweetAlert.show(
      context,
      title: "Gagal",
      subtitle: "menambahkan data",
      style: SweetAlertStyle.error,
    );
  }

  void _alertSuccess() {
    AlertDialog alertD = new AlertDialog(
      content: Column(
        children: <Widget>[
          new Text("Create Data Successful"),
        ],
      ),
    );
    showDialog(
        context: context,
        child: alertD,
        builder: (context) {
          Timer(Duration(seconds: 3), () => Navigator.of(context).pop());
        });
  }

  _fieldnoIndukBuku() {
    return TextFormField(
      controller: noIndukBuku,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "noIndukBuku"),
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
      controller: tajukSubjek,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Tajuk Subjek"),
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

  _fieldJudul() {
    return TextFormField(
      controller: judul,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Judul Buku"),
    );
  }

  _fieldjilidKe() {
    return TextFormField(
      controller: jilidKe,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "jilid Ke"),
    );
  }

  _fieldSeri() {
    return TextFormField(
      controller: seri,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Seri Ke"),
    );
  }

  _fieldEdisiKe() {
    return TextFormField(
      controller: edisiKe,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Edisi Ke"),
    );
  }

  _fieldCetakanKe() {
    return TextFormField(
      controller: cetakanKe,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Cetakan Ke"),
    );
  }

  _fieldPenerbit() {
    return TextFormField(
      controller: penerbit,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Penerbit Buku"),
    );
  }

  _fieldKotaTerbit() {
    return TextFormField(
      controller: kotaTerbit,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Kota Terbit"),
    );
  }

  _fieldTahunTerbit() {
    return DateTimeField(
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now());
      },
      controller: tahunTerbit,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Tahun Terbit"),
    );
  }

  _fieldJumlahHalaman() {
    return TextFormField(
      controller: jumlahHalaman,

      // onSaved: (e) => email = e,
      decoration: InputDecoration(labelText: "Jumlah Halaman"),
    );
  }

  _btnSimpan() {
    return RaisedButton(
        child: Text("Simpan"),
        onPressed: () {
          createData();
        });
  }
}
