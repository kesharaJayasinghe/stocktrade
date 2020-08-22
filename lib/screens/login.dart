import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stocktrade/screens/home.dart';
import 'package:stocktrade/utils/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Center(child: Text('Login Screen'))),

        body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user;

  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }

  void click() {
    signInWithGoogle().then((user) => {
          this.user = user,
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(user)))
        });
  }

  Widget googleLoginButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.account_balance,
          size: 90.0,
          color: Colors.lightBlue,
        ),
        const SizedBox(height: 15.0),
        Image(
          height: 50.0,
          image: AssetImage('assets/stocktrade_logo.png'),
        ),
        const SizedBox(height: 60.0),
        OutlineButton(
          onPressed: this.click,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          splashColor: Colors.grey,
          borderSide: BorderSide(color: Colors.blueAccent),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 27),
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('Sign in with Google',
                        style:
                            TextStyle(color: Colors.lightBlue, fontSize: 18)))
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: googleLoginButton());
  }
}
