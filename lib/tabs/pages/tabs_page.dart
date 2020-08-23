import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocktrade/screens/chart.dart';
import 'package:stocktrade/screens/home.dart';
import 'package:stocktrade/screens/profile.dart';
import 'package:stocktrade/screens/search.dart';

class TabPage extends StatelessWidget {
  final User user;

  const TabPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return HomeScreen(user);
            break;
          case 1:
            return ChartScreen();
            break;
          case 2:
            return SearchScreen();
            break;
          case 3:
            return ProfileScreen();
            break;
          default:
            return HomeScreen(user);
        }
      },
    );
  }
}
