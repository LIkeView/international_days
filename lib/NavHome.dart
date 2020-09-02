
import 'package:flutter/material.dart';
import 'package:international_days/Today.dart';
// import 'package:search_page/search_page.dart';
import 'Month.dart';

class Person {
  final String name, surname;
  final num age;

  Person(this.name, this.surname, this.age);
}

class NavHome extends StatefulWidget {
  @override
  _NavHomeState createState() => _NavHomeState();
}
class _NavHomeState extends State<NavHome> {
  DateTime _dateTime;
  static List<Person> people = [
    Person('Mike', 'Barron', 1),
    Person('Mike', 'Barron', 2),
    Person('Todd', 'Black', 3),
    Person('Ahmad', 'Edwards', 4),
    Person('Anthony', 'Johnson', 5),
    Person('Annette', 'Brooks', 6),
    Person('Annette', 'Brooks', 7),
    Person('Annette', 'Brooks', 8),
    Person('dk', 'Brooks', 9),
  ];
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
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("International Days"),
          actions: <Widget>[
            IconButton(

              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                _showDialog();
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
//         floatingActionButton: FloatingActionButton(
//           tooltip: 'Search people',
//           backgroundColor: Colors.black,
//           onPressed: () => showSearch(
//             context: context,
//             delegate: SearchPage<Person>(
//               items: people,
//               searchLabel: 'Search',
//               suggestion: Center(
//                 child: Text('Search Clint by Clint Name, Clint Type'),
//               ),
//               failure: Center(
//                 child: Text('No person found :('),
//               ),
//               filter: (person) => [
//                 person.name,
//                 person.surname,
//                 person.age.toString(),
//               ],
//               builder: (person) => ListTile(
//                 title: Text(person.name),
// //                subtitle: Text(person.surname),
// //                trailing: Text('${person.age} Year'),
//               ),
//             ),
//           ),
//           child: Icon(Icons.search),
//         ),

      ),
    );

  }
}