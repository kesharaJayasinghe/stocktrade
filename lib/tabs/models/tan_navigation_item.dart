import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stocktrade/screens/chart.dart';
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
          icon: Icon(Icons.home),
        ),
        TabNavigationItem(
          page: ChartScreen(),
          icon: Icon(Icons.insert_chart),
        ),
        TabNavigationItem(
          page: SearchScreen(),
          icon: Icon(Icons.local_library),
        ),
        TabNavigationItem(
          page: ProfileScreen(),
          icon: Icon(Icons.person),
        ),
      ];
}
