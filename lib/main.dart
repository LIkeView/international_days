import 'package:flutter/material.dart';
import 'package:international_days/MainScreen.dart';
import 'package:international_days/MainScreen/home_screen.dart';

import 'NavHome.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
      home: HomeScreen(),
    );
  }
}


