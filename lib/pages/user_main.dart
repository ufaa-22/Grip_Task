import 'package:flutter/material.dart';
import 'package:untitled5/user/Chanege_password.dart';
import 'package:untitled5/user/dashboard.dart';
import 'package:untitled5/user/profile.dart';
class Usermain extends StatefulWidget {
  const Usermain({Key? key}) : super(key: key);

  @override
  State<Usermain> createState() => _UsermainState();
}

class _UsermainState extends State<Usermain> {
  int _selectorIndex =0;
  static List<Widget>_widgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    Changepass(),


  ];
  void _onItemTapped(int index){
    setState(() {
      _selectorIndex =index;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectorIndex),
      bottomNavigationBar:BottomNavigationBar(
        items:const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label:'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label:'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label:'change password',
          ),

          
        ],
        currentIndex: _selectorIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,



      ) ,

    );
  }
}
