import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:opac_android_kp/splashScreen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details){
    FlutterError.dumpErrorToConsole(details);
    if(kReleaseMode){
      exit(1);
    }
  };

  runApp(MyApp());

} 

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
} 

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
          );
        }
      }
      