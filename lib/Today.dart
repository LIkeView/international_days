import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'model/DayDetail.dart';
import 'model/ads.dart';
import 'model/color.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
class Today extends StatefulWidget {
  @override
  _todayState createState() => _todayState();
}

class _todayState extends State<Today> {

  List users = new List();
  final dio = new Dio();
  String newindex = "";
  final _nativeAdController = NativeAdmobController();

  @override
  void initState() {
//    this._getMoreData();
    super.initState();
  }
  @override
  void dispose() {
//    _sc.dispose();
    super.dispose();
  }
  Future<String> _getMoreData() async {
    var url ="http://4foxwebsolution.com/festivals.com/api/getTodayData";
    print(url);
    final response = await dio.post(url, data: users);
    setState(() {
      users = response.data['res_data']['festival_details'];
    });
    print(response.data);
    return "success";
  }
  Random random = new Random();
  Widget _adsContainer(){
    return
      Container(
        height: 100,
        child: NativeAdmob(
          // Your ad unit id
          adUnitID: Ads[random.nextInt(4)],
          controller: _nativeAdController,
          type: NativeAdmobType.banner,
//        error: CupertinoActivityIndicator(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          body:FutureBuilder(
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(
                  child:CircularProgressIndicator(),
                );
              }
              else if(snapshot.hasError){
                return Center(
                  child: Text(
                    "Error",
                  ),
                );
              }
              else if(snapshot.hasData){
                return
                  new ListView.builder(
                      itemCount: users == null ? 0 : users.length,
                      itemBuilder: (BuildContext context, int index) {
//                        if (index % 5 == 0 && index > 0) {
//                          return _adsContainer();
//                        }
//                        else {
                          return new Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              margin: const EdgeInsets.all(10.0),
                              color: colors[index],
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 4.0),
                                        child: Text(
                                            users[index]["fes_name"], style: new TextStyle(
                                            fontSize: 30.0, color: Colors.white)
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, bottom: 30.0),
                                      child: Text(users[index]["m_date"],
                                          style: new TextStyle(
                                              fontSize: 20.0, color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, bottom: 4.0),
                                      child: Text(users[index]["fes_cat"], maxLines: 2,
                                          style: new TextStyle(
                                              fontSize: 20.0, color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text("# Tag", style: new TextStyle(
                                          fontSize: 22.0, color: Colors.white70),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text(users[index]["tags"],
                                        style: new TextStyle(
                                          fontSize: 18.0, color: Colors.white,
                                        ), maxLines: 2,),
                                    ),
                                    Padding(

                                        padding: const EdgeInsets.only(
                                            top: 0.0, bottom: 0.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Ink(
                                              child: IconButton(
                                                color: Colors.white,
                                                icon: Icon(Icons.image),
                                                onPressed: () async {
                                                  newindex = users[index]
                                                  ["festival_id"]
                                                      .toString();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FestImageView(
                                                                  newindex)));
                                                },
                                              ),
                                            )
                                          ],
                                        )

//                                  child: Row(
//                                    children: <Widget>[
//                                      RichText(
//                                        text: TextSpan(
//                                          style: defaultStyle,
//                                          children: <TextSpan>[
////                                      TextSpan(text: 'By clicking Sign Up, you agree to our '),
//                                            TextSpan(
//                                                text: "View More",
//                                                style: new TextStyle(
//                                                    fontSize: 18.0,
//                                                    color: Colors.white70),
//                                                recognizer:
//                                                TapGestureRecognizer()
//                                                  ..onTap = () {
//                                                    newindex = users[index]
//                                                    ["festival_id"]
//                                                        .toString();
//                                                    Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(
//                                                            builder: (context) =>
//                                                                FestImageView(
//                                                                    newindex)));
//                                                  }),
//                                          ],
//                                        ),
//                                      ),
//                                    ],
//                                  ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
//                        }
                      }
                  );
              }
            },
            future: _getMoreData(),
          ),
          bottomNavigationBar: BottomAppBar(
            child: _adsContainer(),
          ),




        ),
      );
  }



}
