import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class ChartPage extends StatefulWidget {
  final String id;
  final String name;
  final String exchange;
  final String open;
  final String high;
  final String low;
  final String volume;

  ChartPage(this.id, this.name, this.exchange, this.open, this.high, this.low,
      this.volume,
      {Key key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage> {
  bool isShowingMainData;
  List<StockData> chartData = [];
  final db = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser;

  Future<StockApiData> fetchData() async {
    final String apiURL =
        "http://api.marketstack.com/v1/eod?access_key=apikey&symbols=" +
            widget.id;
    var result = await http.get(apiURL);
    var jsonRes = json.decode(result.body);
    StockApiData _stockApiData = new StockApiData.fromJson(jsonRes);
    return _stockApiData;
  }

  Future<dynamic> getChartData() async {
    var data = await fetchData();
    print(data.data[0].date);
    setState(() {
      chartData = data.data;
    });
    return;
  }

  showConfirmDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xff2c274c),
      title: Text("Transaction Successful."),
      content: Text(
        "You bought ${widget.name} stocks at \$ ${(widget.open)}. Check profile for your transactions.",
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
      child: Text("Buy Now"),
      onPressed: () async {
        await db.collection('stock').add({
          'user': user.uid,
          'price': double.parse(widget.open),
          'stock_id': widget.id,
          'stock_name': widget.name,
          'createdAt': FieldValue.serverTimestamp()
        });
        Navigator.pop(context);
        showConfirmDialog(context);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xff2c274c),
      title: Text("Buy Stocks"),
      content: Text(
          "Are you sure you want to buy ${widget.name} stocks at \$ ${widget.open}?"),
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
  void initState() {
    super.initState();
    getChartData();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(child: Text(widget.name)),
        elevation: 0,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
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
                // Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(9.0, 12, 9.0, 12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xff2c274c),
                      Color(0xff46426c),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(right: 16.0, left: 6.0),
                            child: SfCartesianChart(
                                zoomPanBehavior: ZoomPanBehavior(
                                    enableSelectionZooming: true,
                                    enablePanning: true,
                                    zoomMode: ZoomMode.x,
                                    enablePinching: true),
                                primaryXAxis: DateTimeAxis(
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                  zoomPosition: 0.85,
                                  zoomFactor: 0.2,
                                  interval: 2,
                                  intervalType: DateTimeIntervalType.days,
                                  labelRotation: 90,
                                  axisLine: AxisLine(width: 0),
                                  enableAutoIntervalOnZooming: false,
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  labelStyle: TextStyle(color: Colors.white),
                                  axisLine: AxisLine(width: 0),
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                series: <ChartSeries>[
                                  CandleSeries<StockData, DateTime>(
                                    dataSource: chartData,
                                    xValueMapper: (StockData sales, _) =>
                                        sales.date,
                                    lowValueMapper: (StockData sales, _) =>
                                        sales.low,
                                    highValueMapper: (StockData sales, _) =>
                                        sales.high,
                                    openValueMapper: (StockData sales, _) =>
                                        sales.open,
                                    closeValueMapper: (StockData sales, _) =>
                                        sales.close,
                                  )
                                ])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const SizedBox(width: 24),
                Text(
                  "Statistics",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 120),
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Text(
                      "BUY",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Open",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white70)),
                      const SizedBox(height: 6),
                      Text("\$ ${widget.open}", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 30),
                      Text("Today's High",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white70)),
                      const SizedBox(height: 6),
                      Text("\$ ${widget.high}", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 30),
                      Text("Today's Low",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white70)),
                      const SizedBox(height: 6),
                      Text("\$ ${widget.low}", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Volume",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white70)),
                      const SizedBox(height: 6),
                      Text(widget.volume, style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 30),
                      Text("Symbol",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white70)),
                      const SizedBox(height: 6),
                      Text(widget.id, style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 30),
                      Text("Exchange",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white70)),
                      const SizedBox(height: 6),
                      Text(widget.exchange, style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StockData {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  StockData({this.date, this.open, this.high, this.low, this.close});

  factory StockData.fromJson(Map<String, dynamic> json) {
    return new StockData(
      date: DateTime.parse(json['date']),
      open: json['open'],
      high: json['high'],
      low: json['low'],
      close: json['close'],
    );
  }
}

class StockApiData {
  final List<StockData> data;

  StockApiData({this.data});

  factory StockApiData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    print(list.runtimeType);
    List<StockData> dataList = list.map((i) => StockData.fromJson(i)).toList();

    return StockApiData(data: dataList);
  }
}
