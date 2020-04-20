import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opac_android_kp/view/tab_list.dart';
import 'package:opac_android_kp/view/view_user/homepage_user.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4), 
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage()//disini tempaat ganti apa yg mau ditampilin abis splash screen

        ))
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Center(
        child: Image.asset('images/logo.png') ,
        ),
    );
  }
}