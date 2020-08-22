import 'package:flutter/material.dart';

class WatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _watchlistItems(context);
  }
}

Widget _watchlistItems(BuildContext context) {
  final titles = [
    'AAPL',
    'TWTR',
    'NFLX',
    'FB',
    'MSFT',
    'DIS',
    'GPRO',
    'SBUX',
    'F',
    'BABA',
    'BAC',
    'FIT',
    'GE',
    'TSLA'
  ];

  final cnames = [
    'Apple',
    'Twitter',
    'Netflix',
    'Facebook',
    'Microsoft',
    'Disney',
    'GoPro',
    'Starbucks',
    'Ford Motor',
    'Alibaba',
    'Bank of America',
    'Fitbit',
    'GE',
    'Tesla'
  ];

  return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            trailing: FlatButton(
                color: Colors.redAccent,
                onPressed: () {},
                child: Text("\$66.24")),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 9.0),
                Text(
                  titles[index],
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(
                  cnames[index],
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      });
}
