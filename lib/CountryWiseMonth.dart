import 'dart:async';
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

class CountryWiseMonth extends StatefulWidget {
  String index;
  String id;
  CountryWiseMonth(String s,String id){
   this.index = s;
   this.id = id;
  }
//  January(String newindex) {
//    this.index = newindex;
//  }
  @override
  _CountryWiseMonthState createState() => _CountryWiseMonthState(index ,id);
}
class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
class _CountryWiseMonthState extends State<CountryWiseMonth>{
//  static const _adUnitID = "ca-app-pub-8592144969637455/8186518809";
//  final _nativeAd = NativeAdmob();

  final String url = "http://4foxwebsolution.com/festivals.com/api/getFestivalsCountryWise";
//  List data;
  var  newdata;
  String newindex = "";
  final dio = new Dio();
  String value;
  bool isLoading = false;
  final _nativeAdController = NativeAdmobController();
  List users = new List();
  List filteredUser = new List();
  final _debouncer = Debouncer(milliseconds: 500);
  TextEditingController controller = new TextEditingController();
  int newoneindex =0;
  bool isfirstcall =true;
  String id;



  _CountryWiseMonthState(String index,String id){
      this.value = index;
      this.id = id;

    }
    Future<String> _getMoreData() async{
      var url ="http://festivel.likeview.in/api/getFestivalsCountryWise";
//    print(url);
    FormData formData = new FormData.fromMap({
      "fest_id" : value,
      "country_id" : id
    });
    final response = await dio.post(url, data: formData);
//    print(response.data);
    setState(() {
      users = response.data['res_data']['festival_details'];
      if(isfirstcall)
        {
          filteredUser = users;
          isfirstcall = false;
        }
//      filteredUser = users;
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
          adUnitID: "ca-app-pub-9549521101535952/4172064241",
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
    List colors = [
      Colors.green, Colors.indigo,Colors.yellow,Colors.orange
    ];
    int colorIndex = 0;
    return
      SafeArea(
        child: Scaffold(
          body:FutureBuilder(
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(
                    child: SpinKitFadingGrid(color: Colors.cyan,shape: BoxShape.rectangle)
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
                return Column(
                  children: [
                new Padding(
                padding: const EdgeInsets.all(8.0),
              child: new Card(
              child: new ListTile(
              leading: new Icon(Icons.search),
              title: new TextField(
                controller: controller,
                decoration: new InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                onChanged:(String text) {
//                  print(newoneindex);
//                  print("DK1"+users.length.toString());
//                  print("DK2"+filteredUser.length.toString());
//                  users.clear();
//                  print("DK3"+users.length.toString());
//                  print("DK4"+filteredUser.length.toString());
                  if (text.isEmpty) {
                    setState(() {});
                    return;
                  }
                  print("DK1");

                  List filteru = new List();
                  for(int i=0;i<users.length;i++)
                    {

                      if(users[i]["fes_name"].toString().toLowerCase().contains(text.toLowerCase()) || users[i]["m_date"].toString().toLowerCase().contains(text.toLowerCase())|| users[i]["fes_cat"].toString().toLowerCase().contains(text.toLowerCase()) ){
                        filteru.add(users[i]);
                      }
                    }
                  if(text.length == 0){
                    isfirstcall = true;
                  }
//                  }
                  print(filteru.length);
                  filteredUser = filteru;
                  print(filteredUser[0]["fes_name"].toString());

//                  users.forEach((userDetail) {
//                    print("111DK");
//                    if(userDetail["fes_name"].contains(text)){
//                      filteredUser.add(userDetail);
//                    }
//                  });
                  setState(() {});

                },
              ),
              trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
              controller.clear();
              isfirstcall = true;
              },),
              ),
              ),
              ),
                    Expanded(
                    child:
                    // filteredUser.length != 0 || controller.text.isNotEmpty?
                    new      ListView.builder(
                      itemCount: filteredUser == null ? 0 : filteredUser.length,

                      itemBuilder: (BuildContext context, int index ) {
                        this.newoneindex=index;
//                        print(index);
                      Random random = new Random();
                      var baseColor = colors[colorIndex] as dynamic;
                      Color color1 = baseColor[800];
                      Color color2  = baseColor[400];
                      colorIndex++;
                      if(colorIndex == colors.length){
                        colorIndex = 0;
                      }
                      //                        if (index % 5 == 0 && index > 0) {
                      //                          return _adsContainer();
                      //                        }
                      //                        else {
                      return new Container(

                        child: GestureDetector(
                          onTap: () async {
                            newindex = filteredUser[index]
                            ["festival_id"]
                                .toString();
                            String FestName;
                            FestName = filteredUser[index]
                            ["fes_name"]
                                .toString();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FestImageView(
                                            newindex,FestName)));
                          },                              child: Card(

                          //                            onPressed: () async {
                          //                              newindex = users[index]
                          //                              ["festival_id"]
                          //                                  .toString();
                          //                              String FestName;
                          //                              FestName = users[index]
                          //                              ["fes_name"]
                          //                                  .toString();
                          //                              Navigator.push(
                          //                                  context,
                          //                                  MaterialPageRoute(
                          //                                      builder: (context) =>
                          //                                          FestImageView(
                          //                                              newindex,FestName)));
                          //                            },

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          margin: const EdgeInsets.only(top: 3.0, bottom: 3.0,left: 10,right: 10),

                          child: new Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0, bottom: 4.0,left: 15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              colors: [color1,color2],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight
                                          )
                                      ),
                                      child: new CircleAvatar(
                                        child: Text(filteredUser[index]["date"][0]+filteredUser[index]["date"][1],style: TextStyle(color: Colors.white),),
                                        backgroundColor: Colors.transparent,
                                        radius: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: new Container(
                                  padding: new EdgeInsets.only(left: 15.0),
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30.0, bottom: 2.0),
                                          child: Text(
                                              filteredUser[index]["fes_name"], style: new TextStyle(
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
                                            Text(filteredUser[index]["m_date"][0].toString().toUpperCase() + filteredUser[index]["m_date"].toString().substring(1),
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
                                          child: Text(filteredUser[index]["fes_cat"],
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
                              //                                    Container(
                              //                                      child: new Column(
                              //                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //                                        children: <Widget>[
                              //                                          Ink(
                              //                                            child: IconButton(
                              //                                              icon: Icon(Icons.image),
                              //                                              onPressed: () async {
                              //                                                newindex = users[index]
                              //                                                ["festival_id"]
                              //                                                    .toString();
                              //                                                String FestName;
                              //                                                FestName = users[index]
                              //                                                ["fes_name"]
                              //                                                    .toString();
                              //                                                Navigator.push(
                              //                                                    context,
                              //                                                    MaterialPageRoute(
                              //                                                        builder: (context) =>
                              //                                                            FestImageView(
                              //                                                                newindex,FestName)));
                              //                                              },
                              //                                            ),
                              //                                          )
                              //
                              ////                            new Text(
                              ////                              "9:50",
                              ////                              style: new TextStyle(
                              ////                                  color: Colors.lightGreen, fontSize: 12.0),
                              ////                            ),
                              ////                            new CircleAvatar(
                              ////                              backgroundColor: Colors.lightGreen,
                              ////                              radius: 10.0,
                              ////                              child: new Text(
                              ////                                "2",
                              ////                                style: new TextStyle(
                              ////                                    color: Colors.white, fontSize: 12.0),
                              ////                              ),
                              ////                            )
                              //                                        ],
                              //                                      ),
                              //                                    ),
                            ],
                          ),
                        ),
                        ),

                      );
                      //                        }
                    }
                )
                    //     :ListView.builder(
                    //     itemCount: users == null ? 0 : users.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       Random random = new Random();
                    //       var baseColor = colors[colorIndex] as dynamic;
                    //       Color color1 = baseColor[800];
                    //       Color color2  = baseColor[400];
                    //       colorIndex++;
                    //       if(colorIndex == colors.length){
                    //         colorIndex = 0;
                    //       }
                    //       //                        if (index % 5 == 0 && index > 0) {
                    //       //                          return _adsContainer();
                    //       //                        }
                    //       //                        else {
                    //       return new Container(
                    //         child: GestureDetector(
                    //           onTap: () async {
                    //             newindex = users[index]
                    //             ["festival_id"]
                    //                 .toString();
                    //             String FestName;
                    //             FestName = users[index]
                    //             ["fes_name"]
                    //                 .toString();
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         FestImageView(
                    //                             newindex,FestName)));
                    //           },                              child: Card(
                    //
                    //           //                            onPressed: () async {
                    //           //                              newindex = users[index]
                    //           //                              ["festival_id"]
                    //           //                                  .toString();
                    //           //                              String FestName;
                    //           //                              FestName = users[index]
                    //           //                              ["fes_name"]
                    //           //                                  .toString();
                    //           //                              Navigator.push(
                    //           //                                  context,
                    //           //                                  MaterialPageRoute(
                    //           //                                      builder: (context) =>
                    //           //                                          FestImageView(
                    //           //                                              newindex,FestName)));
                    //           //                            },
                    //
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(5.0),
                    //           ),
                    //           margin: const EdgeInsets.only(top: 3.0, bottom: 3.0,left: 10,right: 10),
                    //
                    //           child: new Row(
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: const EdgeInsets.only(top: 2.0, bottom: 4.0,left: 15.0),
                    //                 child: Row(
                    //                   children: <Widget>[
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                           shape: BoxShape.circle,
                    //                           gradient: LinearGradient(
                    //                               colors: [color1,color2],
                    //                               begin: Alignment.bottomLeft,
                    //                               end: Alignment.topRight
                    //                           )
                    //                       ),
                    //                       child: new CircleAvatar(
                    //                         child: Text(users[index]["date"][0]+users[index]["date"][1],style: TextStyle(color: Colors.white),),
                    //                         backgroundColor: Colors.transparent,
                    //                         radius: 24.0,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               Expanded(
                    //                 child: new Container(
                    //                   padding: new EdgeInsets.only(left: 15.0),
                    //                   child: new Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                     children: <Widget>[
                    //                       Padding(
                    //                           padding: const EdgeInsets.only(
                    //                               top: 30.0, bottom: 2.0),
                    //                           child: Text(
                    //                               users[index]["fes_name"], style: new TextStyle(
                    //                             color: Colors.black,
                    //                             fontWeight: FontWeight.w600,
                    //                             fontSize: 18.0,)
                    //                           )
                    //                       ),
                    //
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(top: 0.0, bottom: 1.0),
                    //                         child: Row(
                    //                           children: <Widget>[
                    //                             //                                  Icon(Icons.person),
                    //                             Text(users[index]["m_date"][0].toString().toUpperCase() + users[index]["m_date"].toString().substring(1),
                    //                               style: new TextStyle(color: Colors.black,
                    //                                 fontWeight: FontWeight.w600,
                    //                                 fontSize: 14.0,
                    //
                    //                               ),
                    //
                    //                             ),
                    //
                    //                           ],
                    //                         ),
                    //
                    //                       ),
                    //
                    //
                    //                       Padding(
                    //                           padding: const EdgeInsets.only(
                    //                               top: .0, bottom: 30.0),
                    //                           child: Text(users[index]["fes_cat"],
                    //                             style: new TextStyle(color: Colors.black,
                    //                               fontWeight: FontWeight.w600,
                    //                               fontSize: 14.0,
                    //
                    //                             ),
                    //
                    //                           )
                    //                       )
                    //
                    //
                    //                       //                              Padding(
                    //                       //                                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    //                       //                                child: Row(
                    //                       //                                  children: <Widget>[
                    //                       //                                    FaIcon(FontAwesomeIcons.whatsapp),
                    //                       //                                    RichText(
                    //                       //                                      text: TextSpan(
                    //                       //                                        style: defaultStyle,
                    //                       //                                        children: <TextSpan>[
                    //                       ////                                      TextSpan(text: 'By clicking Sign Up, you agree to our '),
                    //                       //                                          TextSpan(
                    //                       //                                            text: "  "+data[index]["wp_no"],
                    //                       //                                            style: new TextStyle(
                    //                       //                                              fontSize: 14.0,
                    //                       //
                    //                       //                                              color: Colors.grey,
                    //                       //                                            ),
                    //                       //                                            recognizer: TapGestureRecognizer()
                    //                       //                                              ..onTap = () async {
                    //                       //                                                await FlutterLaunch.launchWathsApp(phone: data[index]["wp_no"], message: "Hello");},
                    //                       //                                          ),
                    //                       //                                        ],
                    //                       //                                      ),
                    //                       //                                    ),
                    //                       //
                    //                       //                                  ],
                    //                       //                                ),
                    //                       //                              ),
                    //
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //               //                                    Container(
                    //               //                                      child: new Column(
                    //               //                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //               //                                        children: <Widget>[
                    //               //                                          Ink(
                    //               //                                            child: IconButton(
                    //               //                                              icon: Icon(Icons.image),
                    //               //                                              onPressed: () async {
                    //               //                                                newindex = users[index]
                    //               //                                                ["festival_id"]
                    //               //                                                    .toString();
                    //               //                                                String FestName;
                    //               //                                                FestName = users[index]
                    //               //                                                ["fes_name"]
                    //               //                                                    .toString();
                    //               //                                                Navigator.push(
                    //               //                                                    context,
                    //               //                                                    MaterialPageRoute(
                    //               //                                                        builder: (context) =>
                    //               //                                                            FestImageView(
                    //               //                                                                newindex,FestName)));
                    //               //                                              },
                    //               //                                            ),
                    //               //                                          )
                    //               //
                    //               ////                            new Text(
                    //               ////                              "9:50",
                    //               ////                              style: new TextStyle(
                    //               ////                                  color: Colors.lightGreen, fontSize: 12.0),
                    //               ////                            ),
                    //               ////                            new CircleAvatar(
                    //               ////                              backgroundColor: Colors.lightGreen,
                    //               ////                              radius: 10.0,
                    //               ////                              child: new Text(
                    //               ////                                "2",
                    //               ////                                style: new TextStyle(
                    //               ////                                    color: Colors.white, fontSize: 12.0),
                    //               ////                              ),
                    //               ////                            )
                    //               //                                        ],
                    //               //                                      ),
                    //               //                                    ),
                    //             ],
                    //           ),
                    //         ),
                    //         ),
                    //
                    //       );
                    //       //                        }
                    //     }
                    // )

                  ),

              ],
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



