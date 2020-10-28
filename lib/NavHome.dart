
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:international_days/Today.dart';
// import 'package:search_page/search_page.dart';
import 'Month.dart';


class NavHome extends StatefulWidget {
  @override
  _NavHomeState createState() => _NavHomeState();
}
class _NavHomeState extends State<NavHome> {
  DateTime _dateTime;
  String finalDate = '';
  getCurrentDate(){

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {

      finalDate = formattedDate.toString() ;

    });

  }
  DateTime _date = DateTime.now();
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

  Future<Null> _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2021),
        textDirection: TextDirection.ltr,
        initialDatePickerMode: DatePickerMode.day
    );
    String _value;
    if(picked != null && picked!= _date) {
        setState(() {
          _date = picked;
          print(_date.toString());
        });
    }
  }

  Widget build(BuildContext context) {

    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            backgroundColor: Colors.cyan,
//            title: new Text("Search"),
             child: new Card(
              child: new ListTile(
                leading: new Icon(Icons.location_on),
                title: new TextField(
                  decoration: new InputDecoration(
                      hintText: 'Your Location', border: InputBorder.none),
                ),
              ),
            ),

//            content: Column(
//                children: <Widget>[
//                ],
//
//            ),

//
//            actions: <Widget>[
//              // usually buttons at the bottom of the dialog
//              new FlatButton(
//                child: new Text("Submit"),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
          );
        },
      );
    }

    return DefaultTabController(
      length: 13,
      child: Scaffold(
        appBar: GradientAppBar(
          backgroundColorStart: Colors.cyan,
          backgroundColorEnd: Colors.indigo,
          centerTitle: true,
          title: Text("International Days"),
          actions: <Widget>[
            IconButton(
//              icon: Text("IN"),
              icon: Icon(

                Icons.location_on,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                _showDialog();
                },
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
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