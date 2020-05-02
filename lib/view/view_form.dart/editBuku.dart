import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/Class/Buku.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/Class/Post.dart';
import 'package:opac_android_kp/view/view_admin/detailScreen.dart';
import 'package:sweetalert/sweetalert.dart';

final format = DateFormat("yyyy");

class EditBuku extends StatefulWidget {
  final Datum bk;
  final int id;

  EditBuku({this.id, this.bk});

  @override
  _EditBukuState createState() => _EditBukuState();
}

class _EditBukuState extends State<EditBuku> {
  // BukuClass bukuClass = BukuClass();
  ApiService _apiService = new ApiService();

  TextEditingController id = new TextEditingController();

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

  void editData() {
    int _id = this.widget.id;
    String _noIndukBuku = widget.bk.noIndukBuku;
    String _judul = judul.text.toString();
    DateTime _selesaiDiproses = DateTime.now();

    Datum data = Datum(
        id: _id,
        noIndukBuku: _noIndukBuku,
        judul: _judul,
        selesaiDiproses: _selesaiDiproses);

    _apiService.updateBuku(data, widget.id).then((isSuccess) {
      if (mounted) {
        setState(() {
          if (isSuccess) {
            print("edit data berhasil");
            _sweetAlertSuccess();
            _apiService.fetchDetail(widget.id);
          } else {
            print("edit data gagal");
            _sweetAlertError();
          }
        });
      }
    });
  }

  @override
  void initState() {
    id = this.id;
    judul = new TextEditingController(text: widget.bk.judul);
    noIndukBuku = new TextEditingController(text: widget.bk.noIndukBuku);
    tahunTerbit = new TextEditingController(text: widget.bk.tahunTerbit);
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
      subtitle: "mengedit data",
      style: SweetAlertStyle.success,
      // onPress:  
      //   Navigator.of(context).pushReplacement(new MaterialPageRoute(
      //         builder: (BuildContext context) => new DetailScreen(
      //               idBuku: this.widget.id,
      //             )
      //             )
      //   )
        );
  }

   _sweetAlertError() {
    return SweetAlert.show(
      context,
      title: "Gagal",
      subtitle: "mengedit data",
      style: SweetAlertStyle.error,
    );
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
          editData();
          // Navigator.of(context).pushReplacement(new MaterialPageRoute(
          //     builder: (BuildContext context) => new DetailScreen(
          //           idBuku: this.widget.id,
          //         )));
        });
  }
}
