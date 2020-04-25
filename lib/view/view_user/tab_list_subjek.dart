import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/view/view_user/login_to_admin.dart';

class TabListSubjek extends StatefulWidget {
  @override
  _TabListSubjekState createState() => _TabListSubjekState();
}



class _TabListSubjekState extends State<TabListSubjek> {
  ApiService _apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/buku.GIF"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
                leading: Icon(Icons.tablet_mac),
                title: Text("Tentang Aplikasi"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  print("masuk");
                }),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Login sebagai Admin"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                print("hahaha");
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginAdmin()));
              },
            ),
          ),
          
        ],
      ),
    );
  }

//  _listBukuTerkait() {
//    return Expanded(
//      child: FutureBuilder<List<Datum>>(
//        future: _apiService.fetcBukuTerkait(id),
//        builder: (context, snapshot) {
//          if (snapshot.hasError) print(snapshot.error);
//
//          return snapshot.hasData
//              ? new ListView.builder(
//              scrollDirection: Axis.horizontal,
//              itemCount: _bukuTerkait.length,
//              itemBuilder: (context, index) {
//                return _listtile(index);
//              })
//              : _circularProcces();
//        },
//      ),
//    );
//  }

}
