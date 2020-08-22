import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stocktrade/screens/watchlist.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const SizedBox(height: 20.0),
//             Center(child: Text("Home Page")),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen(this.user);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class NavigationItem {
  IconData iconData;
  NavigationItem(this.iconData);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(Icons.home),
    NavigationItem(Icons.book),
    NavigationItem(Icons.local_library),
    NavigationItem(Icons.person),
  ];
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem selectedItem;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = navigationItems[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    // return new WillPopScope(
    //   child: new Scaffold(
    //     appBar: new AppBar(
    //       title: new Text("Home Screen"),
    //       leading: new IconButton(
    //         icon: new Icon(Icons.exit_to_app),
    //         onPressed: () => Navigator.of(context).pop(),
    //       ),
    //     ),
    //   ),
    //   onWillPop: () async => false,
    // );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Watchlist")),
        elevation: 0,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          iconSize: 28.0,
          color: Colors.lightBlue,
          onPressed: () {},
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
      // body: Container(
      //   padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
      //   child: Text("Welcome to Home Screen"),
      // ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.2),
              spreadRadius: 6,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildNavigationItems(),
        ),
      ),
    );
  }

  List<Widget> buildNavigationItems() {
    List<Widget> list = [];
    for (var navigationItem in navigationItems) {
      list.add(buildNavigationItem(navigationItem));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
      },
      child: Container(
        width: 50,
        child: Center(
          child: Icon(
            item.iconData,
            color: selectedItem == item ? Colors.lightBlue : Colors.grey,
            size: 28,
          ),
        ),
      ),
    );
  }
}
