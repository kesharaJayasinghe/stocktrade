import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stocktrade/screens/login.dart';
import 'package:stocktrade/screens/watchlist.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen(this.user);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Watchlist")),
        elevation: 0,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          iconSize: 28.0,
          color: Colors.lightBlue,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 16,
            ),
            child: Icon(
              Icons.search,
              color: Colors.lightBlue,
              size: 28,
            ),
          ),
        ],
      ),
      body: WatchList(),
    );
  }
}
