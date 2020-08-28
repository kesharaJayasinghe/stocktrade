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

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      color: Colors.black38,
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget confirmButton = FlatButton(
      color: Colors.black38,
      child: Text("Sign Out"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xff2c274c),
      title: Text("Sign Out"),
      content: Text("Are you sure you want to sign out of StockTrade?"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
            showAlertDialog(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 6,
            ),
            child: IconButton(
              icon: Icon(Icons.search),
              color: Colors.lightBlue,
              iconSize: 28,
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
          ),
        ],
      ),
      body: WatchList(),
    );
  }
}
