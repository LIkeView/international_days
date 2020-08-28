import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'model/DayDetail.dart';
import 'model/ads.dart';
import 'model/color.dart';

class Month extends StatefulWidget {
  String index;

  Month(String s){
   this.index = s;
  }
//  January(String newindex) {
//    this.index = newindex;
//  }
  @override
  _monthState createState() => _monthState(index);
}

class _monthState extends State<Month>{
//  static const _adUnitID = "ca-app-pub-8592144969637455/8186518809";
//  final _nativeAd = NativeAdmob();

  final String url = "http://4foxwebsolution.com/festivals.com/api/getFestivals";
//  List data;
  var  newdata;
  String newindex = "";
  final dio = new Dio();
  String value;
  bool isLoading = false;
  final _nativeAdController = NativeAdmobController();
  List users = new List();


  _monthState(String index){
    this.value = index;
  }
  Future<String> getJsonData() async{
    var url ="http://4foxwebsolution.com/festivals.com/api/getFestivals";
    print(url);
    FormData formData = new FormData.fromMap({
      "fest_id" : value
    });
    final response = await dio.post(url, data: formData);
    print(response.data);
    setState(() {
      users = response.data['res_data']['festival_details'];
    });
    return "Success";
  }
//  Future<String> getJsonData() async{
//    print(url);
////    final response = await dio.post(url, data: {"fest_id" : value});
////    setState(() {
////      users = response.data['res_data']['festival_details'];
////    });
////    print(response.data);
//
//    var response = await http.post(
//      // Encode the url
//        Uri.encodeFull(url), body: {
//      "fest_id" : value ,
//    }
//    );
//    if(response.statusCode == 200) {
//      print(response.body);
//        var convertDataToJson = json.decode(response.body);
//        users = convertDataToJson["res_data"]["festival_details"];
//    }
//    return "Success";
//  }
//  checkInternetConnectivity() async {
//    var result = await Connectivity().checkConnectivity();
//    if (result == ConnectivityResult.none) {
//      _showDialog(
//          'No internet',
//          "You're not connected to a network"
//      );
//    } else if (result == ConnectivityResult.mobile) {
//      isLoading = true;
//      this.getJsonData();
//    } else if (result == ConnectivityResult.wifi) {
//      this.getJsonData();
//    }
//
//
//  }
  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }


  @override
  void initState(){
    super.initState();
//    this.checkInternetConnectivity();
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
  Widget build(BuildContext context){
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
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
                if (index % 15 == 0 && index > 0) {
                  return _adsContainer();
                }
                else {
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
              }
                    }
                );
            }
          },
          future: getJsonData(),
        ),




      ),
    );
  }
}


