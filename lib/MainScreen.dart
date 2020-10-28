
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:international_days/Today.dart';
// import 'package:search_page/search_page.dart';
import 'Month.dart';

class Person {
  final String name, surname;
  final num age;

  Person(this.name, this.surname, this.age);
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
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


  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 13,
      child: Scaffold(
        appBar: GradientAppBar(
          backgroundColorStart: Colors.cyan,
          backgroundColorEnd: Colors.indigo,
          centerTitle: true,
          title: Text("International Days"),

        ),
      ),
    );

  }
}