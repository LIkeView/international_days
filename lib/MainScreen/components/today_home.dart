import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:international_days/CountryWiseData.dart';
import 'package:international_days/MainScreen/components/recomend_plants.dart';
import 'package:international_days/MainScreen/components/title_with_more_bbtn.dart';
import 'package:international_days/model/DayDetail.dart';

import '../../constants.dart';
import 'featurred_plants.dart';
class TodayHome extends StatefulWidget {
  @override
  _TodayHomeState createState() => _TodayHomeState();
}

class _TodayHomeState extends State<TodayHome> {

  List FestData = new List();
  List Country = new List();
  final dio = new Dio();
  String newindex = "";
  String CountryIndex = "";
  final _nativeAdController = NativeAdmobController();
  var FestUrl ="getTodayData";
  var CounrtyUrl ="getCountryList";

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


  Future<String> _getFestData() async {
//    print(url);
    final response = await dio.post("http://festivel.likeview.in/api/"+FestUrl, data: FestData);
    final response1 = await dio.post("http://festivel.likeview.in/api/"+CounrtyUrl, data: Country);
    setState(() {
      FestData = response.data['res_data']['festival_details'];
      Country = response1.data['res_data']['country_detail'];

    });
    print(response.data);
    return "success";
  }
  Random random = new Random();
  Widget _adsContainer(){
    return
      Container(
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

    List colors = [
      Colors.green, Colors.indigo,Colors.yellow,Colors.orange
    ];
    int colorIndex = 0;
    Size size = MediaQuery.of(context).size;

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
                children: <Widget>[

                  TitleWithMoreBtn(title: "Today : "+FestData[0]["m_date"][0].toString().toUpperCase()+FestData[0]["m_date"].toString().substring(1)),
                  Expanded(
                      child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: FestData == null ? 0 : FestData.length,
                          itemBuilder: (BuildContext context, int index) {
                             String abc = FestData[index]["image_name"];
                            if(FestData[index]["image_name"] == null){
                              abc = '11107036541598103066.png';
                            }
                            return new Row(
                              children: [
                                Container(

                                    margin: EdgeInsets.only(
                                      left: kDefaultPadding,
                                      top: kDefaultPadding / 2,
                                    ),
                                    width: size.width * 0.4,

                                    child: GestureDetector(
                                      onTap: () async {
                                        newindex = FestData[index]
                                        ["festival_id"]
                                            .toString();
                                        String FestName;
                                        FestName = FestData[index]
                                        ["fes_name"]
                                            .toString();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FestImageView(
                                                        newindex,FestName)));
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Image.network('http://festivel.likeview.in/assets/main_file/'+abc),
                                          GestureDetector(
//                        onTap: press,
                                            child: Container(
                                              padding: EdgeInsets.all(kDefaultPadding / 2),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 10),
                                                    blurRadius: 50,
                                                    color: kPrimaryColor.withOpacity(0.23),
                                                  ),
                                                ],
                                              ),
                                              child: new Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:5.0, bottom: 2.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: FestData[index]["fes_name"][0].toString().toUpperCase()+FestData[index]["fes_name"].toString().substring(1) +"\n",
                                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10.0,),
                                                          children: <TextSpan>[
                                                            TextSpan(text: FestData[index]["fes_cat"][0].toString().toUpperCase() + FestData[index]["fes_cat"].toString().substring(1)+'\n', style: TextStyle(fontSize: 8.0,color: Colors.cyan)),
                                                          ],
                                                        ),
                                                      )

//                                                    child: Row(
//                                                      children: <Widget>[
//                                                        new Text(
//                                                          FestData[index]["fes_name"][0].toString().toUpperCase()+FestData[index]["fes_name"].toString().substring(1),
//                                                          style: new TextStyle(
//                                                            color: Colors.black,
//                                                            fontWeight: FontWeight.w600,
//                                                            fontSize: 8.0,
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 0.0, bottom: 1.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                      ],
                                                    ),

                                                  ),




                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                    )
                                ),
                                SizedBox(height: kDefaultPadding),
                              ],
                            );
                          }
                      )
                  ),


                  TitleWithMoreBtn(title: "Country"),

                  Expanded(
                      child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Country == null ? 0 : Country.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new Wrap(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 150),
                                          blurRadius: 100,
                                          color: kPrimaryColor.withOpacity(0.13),
                                        ),
                                      ],
                                    ),

                                    margin: EdgeInsets.only(
                                      left: kDefaultPadding,
                                      top: kDefaultPadding / 2,
                                    ),
                                    width: size.width * 0.4,

                                    child: GestureDetector(
                                      onTap: () async {
                                        CountryIndex = Country[index]
                                        ["id"]
                                            .toString();
                                        String CountryName;
                                        CountryName = Country[index]
                                        ["country_name"]
                                            .toString();
                                        String CountryFlag;
                                        CountryFlag = Country[index]
                                        ["country_flag"]
                                            .toString();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CountryWiseData(
                                                        CountryIndex,CountryName,CountryFlag)));
                                      },
                                      child: Column(

                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(25),
                                            child: Image.network('http://festivel.likeview.in/assets/flag/'+Country[index]["country_flag"]+'.png'),

                                          ),
                                          new Divider(
                                            color: Colors.black,
                                            thickness: 0.1,
                                          ),

//                                          ClipRRect(
//                                borderRadius: BorderRadius.circular(20.0),

//                                            child: Image(
//
//                                              image: NetworkImage('http://festivel.likeview.in/assets/flag/ad.png'),
////                                              loadingBuilder: (BuildContext context, Widget child,
////                                                  ImageChunkEvent loadingProgress) {
////                                                if (loadingProgress == null) return child;
////                                                return Center(
////                                                    child: SpinKitFadingGrid(color: Colors.cyan,shape: BoxShape.rectangle,size: 20,)
////
////                                                );
////                                              },
//                                              height: MediaQuery
//                                                  .of(context)
//                                                  .size
//                                                  .height,
//                                            ),
//                                          ),

                                          GestureDetector(
//                                            onTap: () async {
//                                              newindex = FestData[index]
//                                              ["festival_id"]
//                                                  .toString();
//                                              String FestName;
//                                              FestName = FestData[index]
//                                              ["fes_name"]
//                                                  .toString();
//                                              Navigator.push(
//                                                  context,
//                                                  MaterialPageRoute(
//                                                      builder: (context) =>
//                                                          FestImageView(
//                                                              newindex,FestName)));
//                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),

                                              child: new Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  Padding(
                                                      padding: const EdgeInsets.only(top: 0.0, bottom: 1.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: Country[index]["country_name"][0].toString().toUpperCase() + Country[index]["country_name"].toString().substring(1) +"\n",
                                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10.0,),
                                                          children: <TextSpan>[
                                                            TextSpan(text: Country[index]["shortname"].toString().toUpperCase() , style: TextStyle(fontSize: 8.0,color: Colors.cyan)),
                                                          ],
                                                        ),
                                                      )



//                                                    child: Row(
//                                                      children: <Widget>[
////                                  Icon(Icons.person),
//                                                        Text(Country[index]["country_flag"][0].toString().toUpperCase() + Country[index]["country_flag"].toString().substring(1),
//                                                          style: new TextStyle(color: Colors.black,
//                                                            fontWeight: FontWeight.w600,
//                                                            fontSize: 12.0,
//
//                                                          ),
//
//                                                        ),
//
//                                                      ],
//                                                    ),

                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(top:.0, bottom: 2.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                      ],
                                                    ),
                                                  ),




                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                    )
                                ),
                                SizedBox(height: kDefaultPadding),
                              ],
                            );
                          }
                      )
                  ),

                ],
              );
//                TitleWithMoreBtn(title: "Today", press: () {})

              }
            },
            future: _getFestData(),
          ),
          bottomNavigationBar: BottomAppBar(
            child: _adsContainer(),
          ),
        ),
      );
  }



}
