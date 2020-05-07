import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opac_android_kp/Api/ApiService.dart';
import 'package:opac_android_kp/view/view_admin/homepage_admin.dart';
import 'package:toast/toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginAdmin extends StatefulWidget {
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  ApiService _apiService = ApiService();

  final _formkey = GlobalKey<FormState>();

  bool isUserNonValid = false;
  bool isLogin = false;
  bool isLoading = false;
  String user = '';
  String pass = '';
  String nonValid = "";
  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/homepageadmin': (BuildContext context) => new HomePageAdmin()
      },
      home: new Scaffold(
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
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 4,
                  right: 20.0,
                  left: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: <Widget>[
                    _fieldUsername(),
                    Container(
                      height: 20.0,
                    ),
                    _fieldPassword(),
                    Container(
                      height: 20.0,
                    ),
                    _buttonLogin(),
                    Container(
                      height: 15.0,
                    ),
                    _loading()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _fieldUsername() {
    return TextField(
      decoration: InputDecoration(
          fillColor: const Color(0xfff0f4f8),
          prefixIcon: Icon(Icons.person),
          hintText: ("Username"),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(color: Colors.white))),
      controller: unameController,
    );
  }

  _fieldPassword() {
    return TextField(
      decoration: InputDecoration(
          fillColor: const Color(0xfff0f4f8),
          prefixIcon: Icon(Icons.person),
          hintText: ("Password"),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(color: Colors.white))),
      controller: passController,
    );
  }

  _buttonLogin() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        // _submit(
        //     unameController.text.toString(), passController.text.toString());
        login(unameController.text.toString(), passController.text.toString())
            .then((value) {
          if (value.statusCode == 200) {
            setState(() {
              isLoading = false;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePageAdmin()));
            });
            print("masuk");
            Toast.show("Masuk", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          } else if (value.statusCode == 401) {
            setState(() {
              isLoading = false;
            });
            Toast.show("Email/Password salah", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          } else {
            setState(() {
              isLoading = false;
            });
            Toast.show("gagal", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        });
      },
      disabledColor: Colors.grey,
      color: Color.fromARGB(255, 161, 211, 255),
      child: Text(
        "Login",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  _loading() {
    return Visibility(
      child: Center(child: new CircularProgressIndicator()),
      visible: isLoading,
    );
  }

  Future login(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String myurl = "https://payment.stai-tbh.ac.id/api/v1/auth/login";
    final response = await http.post(myurl, headers: {
      'Accept': 'application/json',
      'Content-Type': 'Application/x-www-form-urlencoded'
    }, body: {
      "email": email,
      "password": pass
    });

    if (response.statusCode == 200) {
      setState(() {
        isLogin = true;
        sharedPreferences.setBool("isLogin", isLogin);
        print("iniiiiiiiiiiiiiiiiiibuaaaaaaaaaaat logiiiiiiiinnnnnn");
        print(sharedPreferences.getBool("isLogin"));
      });
    }
    return response;
  }
}
