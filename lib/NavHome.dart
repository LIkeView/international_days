import 'package:flutter/material.dart';
import 'package:international_days/Today.dart';
import 'Month.dart';

class NavHome extends StatefulWidget {
  @override
  _NavHomeState createState() => _NavHomeState();
}
class _NavHomeState extends State<NavHome> {
  DateTime _dateTime;

  @override
  List<Widget> containers = [
    Container(
      child: Today(),
    ),
    Container(
      child: Month("1"),
    ),
    Container(
      child: Month("2"),
    ),
    Container(
      child: Month("3"),
    ),
    Container(
      child: Month("4"),
    ),
    Container(
      child: Month("5"),
    ),
    Container(
      child: Month("6"),
    ),
    Container(
      child: Month("7"),
    ),
    Container(
      child: Month("8"),
    ),
    Container(
      child: Month("9"),
    ),
    Container(
      child: Month("10"),
    ),
    Container(
      child: Month("11"),
    ),
    Container(
      child: Month("12"),
    )
  ];

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 13,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("International Days"),
          actions: <Widget>[
            IconButton(

              icon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                showDatePicker(
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2021)
                ).then((date) {
                  setState(() {
                    _dateTime = date;
                  });
                });
                print("darshan");
                print(_dateTime);
                },

            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'Today'.toUpperCase(),
              ),
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