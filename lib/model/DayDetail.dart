import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'ads.dart';
class FestImageView extends StatefulWidget {
  String index;

  FestImageView(String newindex) {
    this.index = newindex;
  }

  @override
  _ImageState createState() => _ImageState(index);
}

class _ImageState extends State<FestImageView> {
  String festival_id = "";

  _ImageState(String festival_id) {
    this.festival_id = festival_id;
  }

  final String url = "http://4foxwebsolution.com/festivals.com/api/getImages";
//  List data;
  List users = new List();

  String image_details = "";
  var userID = "";
  int index;
  final _nativeAdController = NativeAdmobController();

//    List users = new List();
  final dio = new Dio();

  @override
  void initState() {
    super.initState();
//    this.getJsonData();
  }

//    Future<String> _getMoreData() async {
//      print(url);
//      final response = await dio.post(url, data: users);
//      setState(() {
//        users = response.data['res_data']['image_details'];
//      });
//      print(response.data);
//      return "success";
//    }

  Future<String> _getMoreData() async {

    print(url);
    FormData formData = new FormData.fromMap({
      "festival_id": festival_id
    });
    final response = await dio.post(url, data: formData);
    print(response.data);
    setState(() {
      users = response.data['res_data']['image_details'];
    });
    return "Success";


//    print(url);
//
//    var response = await http.post(
//      // Encode the url
//        Uri.encodeFull(url),
//        body: {"festival_id": festival_id.toString()}
//      //only accept json response
//      //headers: {"Accept": "application/json"}
//    );
//    if (response.statusCode == 200) {
//      print(response.body);
//      setState(() {
//        var convertDataToJson = json.decode(response.body);
//        data = convertDataToJson["res_data"]["image_details"];
////        image_details = convertDataToJson["res_data"]["image_details"][0]["image_path"];
//      });
//    }
//    return "Success";
  }

  _showDialog(index) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage(users[index]["image_path"]),
                      fit: BoxFit.cover)),
            ),
          );
        });
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
//    print("Hello"+image_details);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Images"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: SpinKitSquareCircle(
                    color: Colors.black,
                    size: 50.0,

//                      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)
                      )
                  );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error",
                ),
              );
            } else {
              return GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                children:
                List.generate(users == null ? 0 : users.length, (index) {
                  print("Image1 : " + users[0]["image_path"]);

//                  if(users[index]["image_path"]=null){
//                    CircularProgressIndicator();
//                  }else{
                    return Container(
                      padding: EdgeInsets.all(1.0),
                      child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Dialog(
                                            backgroundColor: Colors.black,
                                            child: Column(

                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget> [

                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 4.0, bottom: 4.0),
                                                  child: Container(
                                                      child: Image(
                                                        image: NetworkImage(users[index]["image_path"]),
                                                        fit: BoxFit.cover,
                                                        width: MediaQuery.of(context).size.width,
                                                      )
                                                  ),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 4.0, bottom: 4.0),
                                                    child: Ink(
                                                      child: IconButton(
                                                        color: Colors.white,
                                                        icon: Icon(Icons.share),
                                                        onPressed: () async {
                                                          var request = await HttpClient().getUrl(Uri.parse(users[index]["image_path"]));
                                                          var response = await request.close();
                                                          Uint8List bytes = await consolidateHttpClientResponseBytes(response);
                                                          await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
                                                        },
                                                      ),
                                                    )
                                                ),


                                              ],
                                            ),
                                          )
//                                        Swiper(
//                                          itemBuilder: (BuildContext context, int newindex) {
//                                            this.index = newindex;
//                                            return   Container(
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       Dialog(
//                                                         child: Column(
//                                                           children: <Widget> [
//                                                             Center(
//                                                                 child: Image(
//                                                                   image: NetworkImage(data[index]["image_path"]),
//                                                                   fit: BoxFit.cover,
//                                                                   width: MediaQuery.of(context).size.width,
//                                                                 )
//                                                             ),
//                                              Ink(
//                                                child: IconButton(
//                                                  icon: Icon(Icons.share),
//                                                  onPressed: () async {
//                                                    var request = await HttpClient().getUrl(Uri.parse(data[index]["image_path"]));
//                                                    var response = await request.close();
//                                                    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
//                                                    await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
//                                                  },
//                                                ),
//                                              )
//                                                           ],
//                                                         ),
//                                                       )
////                                                       Image(
////                                                         image: NetworkImage(
////                                                             data[index]["image_path"]),
////                                                         fit: BoxFit.cover,
////                                                         width: MediaQuery.of(context).size.width,
////                                                       )
//                                                     ],
//                                                   ),
//                                            );
//                                          },
//                                          indicatorLayout: PageIndicatorLayout.COLOR,
//                                          itemCount: data.length,
//                                          pagination: new SwiperPagination(),
//                                          control: new SwiperControl(),
//                                        )
//                                        Dialog(
//                                          child: Column(
//                                              children: <Widget>[
//                                                RaisedButton(
//                                                  onPressed: () async {
////                                                    await screenshotController.capture().then((image) async {
//                                                      SocialShare.shareOptions("Hello world").then((data) {
//                                                        print(data);
//                                                      });
////                                                    });
//                                                  },
//                                                  child: Text("Share Options"),
//                                                ),
//                                                Container(
//                                                    child: Image(
//                                                      image: NetworkImage(
//                                                          data[index]["image_path"]),
//                                                      height: 400,
//                                                      fit: BoxFit.cover,
//                                                      width: MediaQuery.of(context).size.width,
//                                                    )),
//                                          ]
//                                        )
//
//
//                                       child: Container(
//                                          child: Image(
//                                            image: NetworkImage(
//                                                data[index]["image_path"]),
//                                            fit: BoxFit.cover,
//                                            width: MediaQuery.of(context).size.width,
//                                          )),
//                                )
                                  ));
                            },

                            child: Container(
                              child: ClipRRect(
//                                borderRadius: BorderRadius.circular(20.0),

                                child: Image(
                                  image: NetworkImage(users[index]["image_path"]),
                                  fit: BoxFit.cover,
//                    width: MediaQuery.of(context).size.width,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height,
                                ),
                              ),
                            ),
                          )
//                        child: Text(data[0]["image_path"]),

                      ),
                    );
//                  }

                }),
              );
            }
          },
          future: _getMoreData()),
      bottomNavigationBar: BottomAppBar(
        child: _adsContainer(),
      ),
    );
  }
}
//class ImageDialog extends StatelessWidget {
//  int newindex;
//  String imag;
//  ImageDialog(int index){
//    this.newindex = index;
//    this.imag  = index.toString();
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Dialog(
//      child: Container(
//        height: 400,
//            child: Image(
//                image: NetworkImage("http://4foxwebsolution.com/festivals.com/assets/main_file/3941155151597904607.png"),
//                fit: BoxFit.cover,
//              width: MediaQuery.of(context).size.width,
//            )
//      ),
//    );
//  }
//
//}
