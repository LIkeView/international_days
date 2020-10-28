import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: GradientAppBar(
            backgroundColorStart: Colors.cyan,
            backgroundColorEnd: Colors.indigo,
            centerTitle: true,
            title: Text("About Us"),
          ),
          body: Container(

            child: Card(
                margin: const EdgeInsets.only(top: 3.0, bottom: 3.0,left: 10,right: 10),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),

              ),
              child: Row(
                children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 4.0,left: 15.0,right:10.0),
                   child: RichText(
                    text: TextSpan(
                      text: '\n'+"INTERNATIONAL DAYS :  " +"\n\n",semanticsLabel:"hellphgjgj" ,
                      style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 18.0,),
                      children: <TextSpan>[
                        TextSpan(text: "OVERVIEW :\n\n", style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.bold,color: Colors.black54)),
                        TextSpan(text: " INTERNATIONAL DAYS (TODAY) application provide category,\n hashtags and date of historical days,\n birth-death anniversary of history creator,\n historical events,\n festival dates and accurate date of particular special day.\n (international days also known as national day or\n international day app.)"+'\n\n',style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.w400,color: Colors.black54)),
                        TextSpan(text: "INTERNATIONAL & NATIONAL DAY :\n\n", style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.bold,color: Colors.black54)),
                        TextSpan(text: "This application is provide more than 980+ days name,\ndate, hashtags, and category for 365 days\nwhich are celebrated across the globe.\nExplore each day, know more about it."+'\n\n', style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.w400,color: Colors.black54)),
                        TextSpan(text: "HASHTAGS & CATEGORIES : \n\n", style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.bold,color: Colors.black54)),
                        TextSpan(text: "it will provide event wise hashtags and categories\nof each and everyday. Which are very helpful for that day."+'\n\n', style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.w400,color: Colors.black54)),
                        TextSpan(text: "SPECIAL FEACTURE : : \n\n", style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.bold,color: Colors.black54)),
                        TextSpan(text: "By click on today section,\nIt will provide huge variety of images base on that day\nevent or anniversary wise with accurate description.\nWhich is very helpful for users. These images are different \nfrom other website/application Because \nimages are available with high quality and different creativity \nwhich are not available anywhere."+'\n\n', style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.w400,color: Colors.black54)),
                        TextSpan(text: "Contect US :\n\n", style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 18.0,)),
                        TextSpan(text: "Countect Email :\n", style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.bold,color: Colors.black54)),
                        TextSpan(text: "darshan.likeview@gmail.com"+'\n',style: TextStyle(fontSize: 12.0,fontWeight : FontWeight.w400,color: Colors.black54)),

                      ],
                    ),
                  )
              ),
                ],
              )
            ),

          ),
        )
    );
  }
}
