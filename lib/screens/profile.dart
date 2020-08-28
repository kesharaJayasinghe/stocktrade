import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      );

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final db = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser;

  Future<List<dynamic>> fetchData() async {
    var result =
        await db.collection("stock").where('user', isEqualTo: user.uid).get();
    List<dynamic> res = result.docs.map((e) => e.data()).toList();
    return res;
  }

  String _stockName(dynamic user) {
    return user['stock_name'];
  }

  String _stockId(dynamic user) {
    return user['stock_id'];
  }

  _stockPrice(dynamic user) {
    return user['price'].toStringAsFixed(2);
  }

  double _totalSum = 0.0;

  double _totalVal(dynamic user) {
    return _totalSum += user['price'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("My Account")),
        elevation: 0,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 28.0,
          color: Colors.lightBlue,
          onPressed: () {
            Navigator.pop(context);
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
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(3, 3, 3, 0),
            child: Card(
              color: Color(0xff000c19),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 6),
                  ListTile(
                    title: Text(
                      "Total Value",
                      style: TextStyle(fontSize: 24),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "\$ ${_totalSum.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 6, 24),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 118,
                            height: 23,
                            child: FlatButton(
                              color: Colors.lightGreen,
                              onPressed: () {},
                              child: Text(
                                'Buying Power',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Text("\$ ${(10000.0 - _totalSum).toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 42.0),
              child: FutureBuilder<List<dynamic>>(
                future: fetchData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    _totalSum = 0.0;
                    return ListView.builder(
                        padding: EdgeInsets.all(3),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          // print('INDX $index');
                          print('sum ${_totalVal(snapshot.data[index])}');

                          return Card(
                            color: Color(0xff001023),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(_stockName(snapshot.data[index])),
                                  subtitle:
                                      Text(_stockId(snapshot.data[index])),
                                  trailing: Text(
                                    _stockPrice(snapshot.data[index]),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      // color: double.parse(_buyPrice(
                                      //             snapshot.data[index])) >
                                      //         double.parse(
                                      //             _open(snapshot.data[index]))
                                      //     ? Colors.lightGreen
                                      //     : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
