import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Mycolors.primary,
      body: Padding(
        padding: EdgeInsets.fromLTRB(60, hi / 3.3, 60, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                AppConstants.logopath,
                // height: 100,
              ),
              SizedBox(
                height: 30,
              ),
              Text(AppConstants.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 27,
                      color: Mycolors.splashtextcolor.withOpacity(0.99))),
              // SizedBox(
              //   height: hi / 3.03,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       AppConstants.footersubtitle,
              //       style: TextStyle(
              //           color: Mycolors.splashtextcolor.withOpacity(0.5),
              //           fontSize: 17,
              //           fontWeight: FontWeight.w500),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
