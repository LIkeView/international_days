import 'dart:convert';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'model/color.dart';

class January extends StatefulWidget {



  @override

  _januaryState createState() => _januaryState();
}

class _januaryState extends State<January>{
//  static const _adUnitID = "ca-app-pub-8592144969637455/8186518809";
//  final _nativeAd = NativeAdmob();

  final String url = "http://4foxwebsolution.com/festivals.com/api/getFestivals";
  List data;
  var  newdata;
  String value = "1";

  final _nativeAdController = NativeAdmobController();
  static const _adUnitID = "ca-app-pub-8592144969637455/8186518809";


  Future<String> getJsonData() async{
    var response = await http.post(
      // Encode the url
        Uri.encodeFull(url), body: {
      "fest_id" : value ,
    }
    );
    if(response.statusCode == 200) {
      print(response.body);
      setState(() {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson["res_data"]["festival_details"];
      });
    }
    return "Success";
  }


  checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(
          'No internet',
          "You're not connected to a network"
      );
    } else if (result == ConnectivityResult.mobile) {
      this.getJsonData();
    } else if (result == ConnectivityResult.wifi) {
      this.getJsonData();
    }


  }
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
    this.checkInternetConnectivity();



//    _nativeAd.initialize(appID: "ca-app-pub-8592144969637455~5549457619");
  }
  Random random = new Random();
  int index = 0;
  void changeIndex() {
    setState(() => index = random.nextInt(200));
  }

  Widget adsContainer(){
    return Container(
      height: 250,
      child: NativeAdmob(
        // Your ad unit id
        adUnitID: _adUnitID,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
        error: CupertinoActivityIndicator(),
      ),
    );
  }
  Widget build(BuildContext context){
    return
      SafeArea(
      child: Scaffold(
        body:
        new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index % 5 == 0 && index > 0) {
                return adsContainer();
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
                                  data[index]["fes_name"], style: new TextStyle(
                                  fontSize: 30.0, color: Colors.white)
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 30.0),
                            child: Text(data[index]["m_date"],
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 4.0),
                            child: Text(data[index]["fes_cat"], maxLines: 2,
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
                            child: Text(data[index]["tags"],
                              style: new TextStyle(
                                fontSize: 18.0, color: Colors.white,
                              ), maxLines: 2,),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
        ),
      ),

    );
  }}


