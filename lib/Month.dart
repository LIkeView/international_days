import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  Future<String> _getMoreData() async{
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
        height: 60,
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
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return
      SafeArea(
        child: Scaffold(
          body:FutureBuilder(
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(
                    child: SpinKitWave(color: Colors.black,size: 30, type: SpinKitWaveType.center)
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
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            margin: const EdgeInsets.all(5.0),
                            child: new Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0, bottom: 4.0,left: 5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: new CircleAvatar(
                                          child: Text(users[index]["m_date"][0],style: TextStyle(color: Colors.white),),
                                          backgroundImage: new NetworkImage(url),
                                          backgroundColor: Colors.black45,
                                          radius: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: new Container(
                                    padding: new EdgeInsets.only(left: 8.0),
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0, bottom: 2.0),
                                            child: Text(
                                                users[index]["fes_name"], style: new TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0,)
                                            )
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 0.0, bottom: 1.0),
                                          child: Row(
                                            children: <Widget>[
//                                  Icon(Icons.person),
                                              Text(users[index]["m_date"][0].toString().toUpperCase() + users[index]["m_date"].toString().substring(1),
                                                style: new TextStyle(color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,

                                                ),

                                              ),

                                            ],
                                          ),

                                        ),


                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: .0, bottom: 30.0),
                                            child: Text(users[index]["fes_cat"],
                                              style: new TextStyle(color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0,

                                              ),

                                            )
                                        )


//                              Padding(
//                                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
//                                child: Row(
//                                  children: <Widget>[
//                                    FaIcon(FontAwesomeIcons.whatsapp),
//                                    RichText(
//                                      text: TextSpan(
//                                        style: defaultStyle,
//                                        children: <TextSpan>[
////                                      TextSpan(text: 'By clicking Sign Up, you agree to our '),
//                                          TextSpan(
//                                            text: "  "+data[index]["wp_no"],
//                                            style: new TextStyle(
//                                              fontSize: 14.0,
//
//                                              color: Colors.grey,
//                                            ),
//                                            recognizer: TapGestureRecognizer()
//                                              ..onTap = () async {
//                                                await FlutterLaunch.launchWathsApp(phone: data[index]["wp_no"], message: "Hello");},
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//
//                                  ],
//                                ),
//                              ),

                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Ink(
                                        child: IconButton(
                                          color: Colors.black,
                                          icon: Icon(Icons.image),
                                          onPressed: () async {
                                            newindex = users[index]
                                            ["festival_id"]
                                                .toString();
                                            String FestName;
                                            FestName = users[index]
                                            ["fes_name"]
                                                .toString();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FestImageView(
                                                            newindex,FestName)));
                                          },
                                        ),
                                      )

//                            new Text(
//                              "9:50",
//                              style: new TextStyle(
//                                  color: Colors.lightGreen, fontSize: 12.0),
//                            ),
//                            new CircleAvatar(
//                              backgroundColor: Colors.lightGreen,
//                              radius: 10.0,
//                              child: new Text(
//                                "2",
//                                style: new TextStyle(
//                                    color: Colors.white, fontSize: 12.0),
//                              ),
//                            )
                                    ],
                                  ),
                                ),
                              ],
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


