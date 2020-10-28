
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:international_days/Today.dart';
// import 'package:search_page/search_page.dart';
import 'CountryWiseMonth.dart';
import 'Month.dart';


class CountryWiseData extends StatefulWidget {
  String index;
  String Country_Name;
  String Country_Flag;
  CountryWiseData(String newindex,String CountryName ,String CountryFlag) {
    this.index = newindex;
    this.Country_Name = CountryName;
    this.Country_Flag = CountryFlag;
  }
  @override
  _CountryWiseDataState createState() => _CountryWiseDataState(index,Country_Name,Country_Flag);
}
class _CountryWiseDataState extends State<CountryWiseData> {

  String Counrtyindex = "" ;
  String CountryName = "";
  String  Country_Flag = "";
  bool isLoading = true;

  _CountryWiseDataState(String Newindex,String Country_Name,String CountryFlag) {
    this.Counrtyindex = Newindex;
    this.CountryName = Country_Name;
    this.Country_Flag = CountryFlag;
  }

//  String NewIndex = Counrtyindex;
  DateTime _dateTime;

  DateTime _date = DateTime.now();
  @override
  List<Widget> containers = [
    Container(
      child: Today(),
    ),
    Container(
      child: CountryWiseMonth("1","91"),
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
          return AlertDialog(
            title: new Text("Search"),
            content: Column(
                children: <Widget>[
                  new TextFormField(
                    maxLength: 10,
                    readOnly: true,
                    // validator: validateDob,
                    onTap: (){
                      setState(() {
                        _selectDate(context);
                      });
                    },
                    decoration: new InputDecoration(hintText: (_date.toString())),
                  ),
                ],

            ),


            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
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
          title: Text(CountryName),
          actions: <Widget>[
            IconButton(
              icon: Text(Country_Flag.toUpperCase()),
//              icon: Icon(
//
//                Icons.search,
//                color: Colors.white,
//              ),
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