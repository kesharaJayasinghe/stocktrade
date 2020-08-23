import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ChartScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart"),
      ),
      body: Center(
        child: Text("Chart goes here."),
      ),
    );
  }
}
