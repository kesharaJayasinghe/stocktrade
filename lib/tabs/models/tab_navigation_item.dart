import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stocktrade/screens/crypto.dart';
import 'package:stocktrade/screens/home.dart';
import 'package:stocktrade/screens/profile.dart';
import 'package:stocktrade/screens/search.dart';

class TabNavigationItem {
  final Widget page;
  final Icon icon;

  static User user;

  TabNavigationItem({
    @required this.page,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomeScreen(user),
          icon: Icon(Icons.insert_chart),
        ),
        TabNavigationItem(
          page: CryptoCurrenPage(),
          icon: Icon(Icons.attach_money),
        ),
        TabNavigationItem(
          page: NewsScreen(),
          icon: Icon(Icons.description),
        ),
        TabNavigationItem(
          page: ProfileScreen(),
          icon: Icon(Icons.person),
        ),
      ];
}
