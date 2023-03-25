import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';

class AskPermission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Utils.getNTPWrappedWidget(Material(
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                '1. Open App Settings.\n\n2. Go to Permissions.\n\n3.Allow permission for the required service.\n\n4. Return to app & reload the page.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                child: Text(
                  'Open App Settings',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  openAppSettings();
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0.5,
                    backgroundColor: Mycolors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                child: Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ))));
  }
}
