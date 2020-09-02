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
  String ImageFestName;
  FestImageView(String newindex,String FestName) {
    this.index = newindex;
    this.ImageFestName = FestName;
  }

  @override
  _ImageState createState() => _ImageState(index,ImageFestName);
}

class _ImageState extends State<FestImageView> {
  String festival_id = "";
  String Image_FestName = "";
  _ImageState(String festival_id,String Image_FestName) {
    this.festival_id = festival_id;
    this.Image_FestName = Image_FestName;
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
  }

  Future<String> _getImageData() async {

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
        title:
        Text(Image_FestName),
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

//                                  Swiper(
//                                          itemBuilder: (BuildContext context, int newindex) {
//                                            this.index = newindex;
                                             Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Stack(
                                                    children: <Widget>[
                                                      new Container(
                                                          padding: EdgeInsets
                                                              .zero,
                                                          child: Image(
                                                            image: NetworkImage(
                                                                users[index]["image_path"]),
                                                            fit: BoxFit.cover,
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width,
                                                          )
                                                      ),
                                                      Positioned(
                                                        right: 5.0,
                                                        bottom: 5.0,
                                                        child: new FloatingActionButton(
                                                          child: const Icon(
                                                              Icons.share),
                                                          backgroundColor: Colors
                                                              .grey.shade800,
                                                          onPressed: () async {
                                                            var request = await HttpClient()
                                                                .getUrl(
                                                                Uri.parse(
                                                                    users[index]["image_path"]));
                                                            var response = await request
                                                                .close();
                                                            Uint8List bytes = await consolidateHttpClientResponseBytes(
                                                                response);
                                                            await Share.file(
                                                                'ESYS AMLOG',
                                                                'amlog.jpg',
                                                                bytes,
                                                                'image/jpg');
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
//                                          },
//                                          indicatorLayout: PageIndicatorLayout.COLOR,
//                                          itemCount: users.length,
//                                          pagination: new SwiperPagination(),
//                                          control: new SwiperControl(),
//                                  )
                                  ),

                              );
                            },

                            child: Container(
                              child: ClipRRect(
//                                borderRadius: BorderRadius.circular(20.0),

                                child: Image(
                                  image: NetworkImage(users[index]["image_path"]),
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                        child: SpinKitWave(
                                            color: Colors.black, size: 20, type: SpinKitWaveType.center,)
//                                      child: CircularProgressIndicator(
//                                        value: loadingProgress.expectedTotalBytes != null
//                                            ? loadingProgress.cumulativeBytesLoaded /
//                                            loadingProgress.expectedTotalBytes
//                                            : null,
//                                      ),
                                    );
                                  },
//                                  fit: BoxFit.cover,
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
