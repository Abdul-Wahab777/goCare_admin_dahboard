import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ntp/ntp.dart';

class Utils {
  static Future<int> getNTPOffset() {
    return NTP.getNtpOffset();
  }

  static void toast(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.black87, textColor: Colors.white);
  }

  static Widget getNTPWrappedWidget(Widget child) {
    return FutureBuilder(
        future: NTP.getNtpOffset(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data! > Duration(minutes: 1).inMilliseconds ||
                snapshot.data! < -Duration(minutes: 1).inMilliseconds)
              return Material(
                  color: Colors.white,
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            "Your device clock time is out of sync with the server time. Please set it right to continue.",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18),
                          ))));
          }
          return child;
        });
  }
}
