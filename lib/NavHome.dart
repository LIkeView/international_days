import 'package:flutter/material.dart';
import 'April.dart';
import 'August.dart';
import 'December.dart';
import 'February.dart';
import 'January.dart';
import 'July.dart';
import 'June.dart';
import 'March.dart';
import 'May.dart';
import 'November.dart';
import 'October.dart';
import 'September.dart';


class NavHome extends StatefulWidget {
  @override


  _NavHomeState createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> {
  @override

  List<Widget> containers = [
    Container(
      child: January(),
    ),
    Container(
      child: February(),
    ),
    Container(
      child: March(),
    ),
    Container(
      child: April(),
    ),
    Container(
      child: May(),
    ),
    Container(
      child: June(),
    ),
    Container(
      child: July(),
    ),
    Container(
      child: August(),
    ),
    Container(
      child: September(),
    ),
    Container(
      child: Octomber(),
    ),
    Container(
      child: November(),
    ),
    Container(
      child: December(),
    )
  ];

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("International Days"),
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'January',
              ),
              Tab(
                text: "February",
              ),
              Tab(
                text: 'March',
              ),
              Tab(
                text: "April",
              ),
              Tab(
                text: 'May',
              ),
              Tab(
                text: "June",
              ),
              Tab(
                text: 'July',
              ),
              Tab(
                text: 'August',
              ),
              Tab(
                text: 'September',
              ),
              Tab(
                text: 'October',
              ),
              Tab(
                text: 'November',
              ),
              Tab(
                text: 'December',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );

  }
}