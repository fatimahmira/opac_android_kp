import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:opac_android_kp/view/tab_list_buku.dart';
import 'package:opac_android_kp/view/tab_list_search.dart';
import 'package:opac_android_kp/view/tab_list_subjek.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle options =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
  List<Widget> _widgetoptions = <Widget>[
    TabListSearch(),
    TabListBuku(),
    TabListSubjek()
  ];

// when  the item on tapped this function will active
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 161, 211, 255),
        centerTitle: true,
        title: const Text(
          'OPAC',
          style: TextStyle(
            fontFamily: "AdoraChalie",
            fontSize: 48.0,
          ),
        ),
      ),
      body: Center(child: _widgetoptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            title: Text('Cari'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Akun'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
