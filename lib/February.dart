import 'dart:convert';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_native_admob/flutter_native_admob.dart';
//import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:http/http.dart' as http;

import 'model/color.dart';

class February extends StatefulWidget {



  @override

  _februaryState createState() => _februaryState();
}

class _februaryState extends State<February>{

//  static const _adUnitID = "ca-app-pub-3940256099942544/8135179316";
//  final _nativeAdController = NativeAdmobController();

  final String url = "http://4foxwebsolution.com/festivals.com/api/getFestivals";
  List data;
  var  newdata;
  String value = "2";

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
//     data = convertDataToJson['res_data'];

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
  }
  Random random = new Random();
  int index = 0;
  void changeIndex() {
    setState(() => index = random.nextInt(200));
  }
  Widget build(BuildContext context){
    return
      SafeArea(
        child: Scaffold(

          body:
          new ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index){
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
                                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                                child: Text(
                                    data[index]["fes_name"], style: new TextStyle(fontSize: 30.0,color: Colors.white)
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0, bottom: 30.0),
                              child: Text(data[index]["m_date"], style: new TextStyle(fontSize: 20.0,color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Text(data[index]["fes_cat"],maxLines: 2, style: new TextStyle(fontSize: 20.0,color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text("# Tag",style: new TextStyle(fontSize: 22.0,color: Colors.white70),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(data[index]["tags"],style: new TextStyle(fontSize: 18.0,color: Colors.white,
                              ),maxLines: 2,),
                            )
                          ],
                        ),
                      ),
                    ),
                  );


              }
          ),
        ),

      );
  }}


