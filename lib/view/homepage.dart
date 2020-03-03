import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool clickedSearch =
      false; //digunakan untuk menangani animasi kontainer yang diperluas dari Search
  int _selectedIndex =
      0; //menangani item mana yang saat ini dipilih di bilah aplikasi bawah
//  List<Widget> _widgetoptions = <Widget>[
//    Text('Index 0: Home'),
//    Text('Index 2: School')
//  ];

  String text = 'home';

// when  the item on tapped this function will active
  void _onItemTapped(int index, String Text) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Stack(
          children: <Widget>[
            Center(child: Text(text)),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 25),
                height:
                    clickedSearch ? MediaQuery.of(context).size.height : 10.0,
                width: clickedSearch ? MediaQuery.of(context).size.width : 10.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(clickedSearch ? 0.0 : 300.0),
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              clickedSearch = !clickedSearch;
            });
          },
          tooltip: "Center Search",
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Icon(Icons.search),
          ),
          elevation: 4.0,
        ),
//        child: _widgetoptions.elementAt(_selectedIndex),

        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    _onItemTapped(0, "Home");
                  },
                  icon: Icon(
                    Icons.home,
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                  ),
                  iconSize: 30.0,
                ),
                SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  onPressed: () {
                    _onItemTapped(1, "Account");
                  },
                  icon: Icon(
                    Icons.account_circle,
                    color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                  ),
                  iconSize: 30.0,
                )
              ],
            ),
          ),
        )
//    BottomNavigationBar(
//        items: const <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home,),
//            title: Text('Home'),
//          ),
//
//          BottomNavigationBarItem(
//            icon: Icon(Icons.school),
//            title: Text('School'),
//          ),
//        ],
//        currentIndex: _selectedIndex,
//        selectedItemColor: Colors.amber[800],
//        onTap: _onItemTapped,
//      ),

        );
  }
}
