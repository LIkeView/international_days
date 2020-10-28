
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:international_days/Drawer/AboutUs.dart';
import 'package:international_days/Drawer/CountryList.dart';
import 'package:international_days/MainScreen/components/today_home.dart';
import 'package:international_days/NavHome.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(

         child: Text('\nInternational \nDays',style: new TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.w600,
           fontSize: 25.0,
         ),),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.indigo, Colors.cyan])

        ),
//                otherAccountsPictures: <Widget>[
//                  new CircleAvatar(
//                    backgroundColor: Colors.black,
//                    child: new Text("BH"),
//                  )
//                ],
            ),

            new ListTile(
                leading: new Icon(Icons.whatshot),
                title: new Text("Country"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CountryList())
                  );
                }
            ),

            new Divider(),
            new ListTile(
                leading: new Icon(Icons.airplay),
                title: new Text("About Us"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs())
                  );
                }
            ),
            new Divider(),
//            logout(),
//              new ListTile(
////                title: new Text("Logout"),
////                onTap: () {
////                  Navigator.of(context).pop();
////                }
//              ),
          ],
        ),
      ),

      body: TodayHome(),
//      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  GradientAppBar buildAppBar(context) {
    return
       GradientAppBar(
    backgroundColorStart: Colors.cyan,
    backgroundColorEnd: Colors.indigo,

    centerTitle: true,
    title: Text("International Days"),
         elevation: 0,
         leading: Builder(
           builder: (BuildContext context) {
             return IconButton(
               icon: SvgPicture.asset("assets/icons/menu.svg"),
               onPressed: () {
                 Scaffold.of(context).openDrawer();
               },
               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
             );
           },
         ),
//         leading: IconButton(
//           icon: SvgPicture.asset("assets/icons/menu.svg"),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//           tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//         ),
         actions: <Widget>[
           IconButton(
              icon: Icon(

                Icons.public,
                color: Colors.white,
              ),
             onPressed: () {
               // do something
//               Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NavHome())
                  );
             },
           )
         ],
    );

//      AppBar(
//      elevation: 0,
//      leading: IconButton(
//        icon: SvgPicture.asset("assets/icons/menu.svg"),
//        onPressed: () {},
//      ),
//    );
  }
}
