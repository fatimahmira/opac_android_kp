import 'package:flutter/material.dart';

import 'Class/Post.dart';


class EditBuku extends StatefulWidget {
  final List<Datum> list;
  final int index;

   EditBuku({ this.list, this.index}) ;

  @override
  _EditBukuState createState() => _EditBukuState();
}

class _EditBukuState extends State<EditBuku> {
  
  TextEditingController judul;
  TextEditingController pengarang;

  void editData(){

  }

@override
  void initState() {
    // TODO: implement initState
    judul = new TextEditingController(text: widget.list[widget.index].judul);
    pengarang = new TextEditingController(text: widget.list[widget.index].pengarang);
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
          child: Column(
            children: <Widget>[
              
              TextFormField(
                      controller: judul,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "edit judul";
                        }
                      },
                      // onSaved: (e) => email = e,
                      decoration: InputDecoration(labelText: "judul"),
                    ),
                    TextFormField(
                      controller: pengarang,
                      // onSaved: (e) => password = e,
                      decoration: InputDecoration(
                        labelText: "Password",
                        
                      ),
                    ),
                    RaisedButton(
                      child: Text("Simpan"),
                      onPressed: (){
                      editData();
                      Navigator.pop(context);

                    })

          ],
          ),
        ),
      ),
      
    );
  }
}