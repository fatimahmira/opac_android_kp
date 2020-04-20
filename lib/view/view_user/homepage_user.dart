import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:opac_android_kp/view/view_user/tab_list_buku.dart';
import 'package:opac_android_kp/view/view_user/tab_list_search.dart';
import 'package:opac_android_kp/view/view_user/tab_list_subjek.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AnimationController _controller;
  Widget animationBuilder;

  // void forward(Duration duration) {
  //   _controller.duration = duration;
  //   _controller.forward();
  // }

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
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.search, title: "Cari"),
            TabData(iconData: Icons.home, title: "Buku"),
            TabData(iconData: Icons.account_circle, title: "Akun")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _selectedIndex = position;
            });
          },
          circleColor: Color.fromARGB(255, 139, 215, 234),
        ));
  }
}
