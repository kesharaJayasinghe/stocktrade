import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsScreen extends StatelessWidget {
  final String apiUrl =
      'https://newsapi.org/v2/everything?q=apple&from=2020-08-26&to=2020-08-27&sortBy=popularity&apiKey=apikey';
  // static Route<dynamic> route() => MaterialPageRoute(
  //       builder: (context) => WatchList(),
  //     );

  Future<List<dynamic>> fetchNews() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['articles'];
  }

  String _newsAuthor(dynamic news) {
    return news['author'];
  }

  String _newsTitle(dynamic news) {
    return news['title'];
  }

  String _newsDesc(dynamic news) {
    return news['description'];
  }

  String _imgUrl(dynamic news) {
    return news['urlToImage'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Business News")),
        elevation: 0,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 28.0,
          color: Colors.lightBlue,
          onPressed: () {
            Navigator.pop(context);
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
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.only(bottom: 42.0),
        child: FutureBuilder<List<dynamic>>(
          future: fetchNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(_newsAuthor(snapshot.data[0]));
              return ListView.builder(
                  padding: EdgeInsets.all(3),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // color: Colors.black45,
                      margin: EdgeInsets.only(bottom: 24),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(6))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    _imgUrl(snapshot.data[index]),
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                _newsTitle(snapshot.data[index]),
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                _newsDesc(snapshot.data[index]),
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
