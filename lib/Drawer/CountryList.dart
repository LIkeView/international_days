import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:international_days/model/DayDetail.dart';

import '../CountryWiseData.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  final dio = new Dio();
  String newindex = "";
  final _nativeAdController = NativeAdmobController();
  List Country = new List();
  List FilterCountry = new List();
  var CounrtyUrl = "getCountryList";
  TextEditingController controller = new TextEditingController();
  int newoneindex = 0;
  bool isfirstcall = true;

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
//    print(url);
    final response = await dio
        .post("http://festivel.likeview.in/api/" + CounrtyUrl, data: Country);
    setState(() {
      Country = response.data['res_data']['country_detail'];
      if (isfirstcall) {
        FilterCountry = Country;
        isfirstcall = false;
      }
    });
//    print(response.data);
    return "success";
  }

  Random random = new Random();

  Widget _adsContainer() {
    return Container(
      height: 60,
      child: NativeAdmob(
        // Your ad unit id
        adUnitID: "ca-app-pub-9549521101535952/7919737565",
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
    var duration = new Duration(seconds: 6);
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];
    int colorIndex = 0;
    return SafeArea(
      child: Scaffold(
        appBar: GradientAppBar(
          backgroundColorStart: Colors.cyan,
          backgroundColorEnd: Colors.indigo,
          centerTitle: true,
          title: Text("Country"),
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: SpinKitFadingGrid(
                      color: Colors.cyan, shape: BoxShape.rectangle));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error",
                ),
              );
            } else if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: (String text) {
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
                          for (int i = 0; i < Country.length; i++) {
                            if (Country[i]["country_name"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(text.toLowerCase()) ||
                                Country[i]["country_name"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(text.toLowerCase()) ||
                                Country[i]["country_name"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(text.toLowerCase())) {
                              filteru.add(Country[i]);
                            }
                          }
                          if (text.length == 0) {
                            isfirstcall = true;
                          }
//                  }
                          print(filteru.length);
                          FilterCountry = filteru;

//                  users.forEach((userDetail) {
//                    print("111DK");
//                    if(userDetail["fes_name"].contains(text)){
//                      filteredUser.add(userDetail);
//                    }
//                  });
                          setState(() {});
                        },
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          controller.clear();
                          isfirstcall = true;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      child: new ListView.builder(
                          itemCount: FilterCountry == null ? 0 : FilterCountry.length,
                          itemBuilder: (BuildContext context, int index) {
                            Random random = new Random();
                            var baseColor = colors[colorIndex] as dynamic;
                            Color color1 = baseColor[800];
                            Color color2 = baseColor[400];
                            colorIndex++;
                            if (colorIndex == colors.length) {
                              colorIndex = 0;
                            }
//                        if (index % 5 == 0 && index > 0) {
//                          return _adsContainer();
//                        }
//                        else {
                            return new Container(
                                child: GestureDetector(
                                  onTap: () async {
                                    String CountryIndex = "";
                                    CountryIndex = FilterCountry[index]["id"].toString();
                                    String CountryName;
                                    CountryName =
                                        FilterCountry[index]["country_name"].toString();
                                    String CountryFlag;
                                    CountryFlag =
                                        FilterCountry[index]["country_flag"].toString();
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CountryWiseData(
                                                CountryIndex,
                                                CountryName,
                                                CountryFlag)));
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 3.0, bottom: 3.0, left: 10, right: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: new Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, bottom: 4.0, left: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
//                                              decoration: BoxDecoration(
//                                                shape: BoxShape.circle,
//                                                gradient: LinearGradient(
//                                                  colors: [color1,color2],
//                                                  begin: Alignment.bottomLeft,
//                                                  end: Alignment.topRight
//                                                )
//                                              ),
                                                child: new CircleAvatar(
                                                  child: Image.network(
                                                      'http://festivel.likeview.in/assets/flag/' +
                                                          FilterCountry[index]
                                                          ["country_flag"] +
                                                          '.png'),

//                                                child: Text(Country[index]["country_name"][0]+Country[index]["country_name"][1],style: TextStyle(color: Colors.white),),
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
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10.0, bottom: 10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      new Text(
                                                        FilterCountry[index]["country_name"]
                                                        [0]
                                                            .toString()
                                                            .toUpperCase() +
                                                            FilterCountry[index]
                                                            ["country_name"]
                                                                .toString()
                                                                .substring(1),
                                                        style: new TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

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
//                                      Container(
//                                        child: new Column(
//                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                          children: <Widget>[
//                                            Ink(
//                                              child: IconButton(
//                                                color: Colors.black,
//                                                icon: Icon(Icons.image),
//                                                onPressed: () async {
//                                                  newindex = users[index]
//                                                  ["festival_id"]
//                                                      .toString();
//                                                  String FestName;
//                                                  FestName = users[index]
//                                                  ["fes_name"]
//                                                      .toString();
//                                                  Navigator.push(
//                                                      context,
//                                                      MaterialPageRoute(
//                                                          builder: (context) =>
//                                                              FestImageView(
//                                                                  newindex,FestName)));
//                                                },
//                                              ),
//                                            )
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
//                                          ],
//                                        ),
//                                      ),
                                      ],
                                    ),
                                  ),
                                ));
//                        }
                          })

                  )
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
