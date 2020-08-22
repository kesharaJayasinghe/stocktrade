// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:stocktrade/screens/home.dart';
// import 'package:stocktrade/screens/home.dart';
import 'package:stocktrade/screens/login.dart';
// import 'package:stocktrade/screens/splash.dart';
// import 'package:stocktrade/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, AsyncSnapshot<User> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting)
//           return SplashScreen();
//         if (!snapshot.hasData || snapshot.data == null) return LoginScreen();
//         print("homescreen");
//         return HomeScreen();
//       },
//     );
//   }
// }
