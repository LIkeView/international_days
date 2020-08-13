
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class CheckInternet{
  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(
          'No internet',
          "You're not connected to a network"
      );
    } else if (result == ConnectivityResult.mobile) {
      _showDialog(
          'Internet access',
          "You're connected over mobile data"
      );
    } else if (result == ConnectivityResult.wifi) {
      _showDialog(
          'Internet access',
          "You're connected over wifi"
      );
    }
  }
  _showDialog(title, text) {
    showDialog(
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
}
