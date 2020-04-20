import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opac_android_kp/view/view_admin/homepage_admin.dart';

class LoginAdmin extends StatefulWidget {
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
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
                    _buttonLogin()
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
      
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   '/homepageadmin', (Route<dynamic> route) => true );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                HomePageAdmin() ));
      },
      disabledColor: Colors.grey,
      color: Color.fromARGB(255, 161, 211, 255),
      child: Text(
        "Login",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
