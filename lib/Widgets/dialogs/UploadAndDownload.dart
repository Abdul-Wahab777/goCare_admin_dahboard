import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';

openUploadDownloaddialog(
    {BuildContext? context,
    double? percent,
    required String title,
    required String subtitle}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      new CircularPercentIndicator(
        radius: 25.0,
        lineWidth: 4.0,
        percent: percent ?? 0.0,
        center: new Text(
          percent == 0.001 ? '0%' : "${(percent! * 100).roundToDouble()}%",
          style: TextStyle(fontSize: 11),
        ),
        progressColor: Colors.green[400],
      ),
      Container(
        width: 195,
        padding: EdgeInsets.only(left: 3),
        child: ListTile(
          dense: false,
          title: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
                height: 1.3, fontWeight: FontWeight.w600, fontSize: 14),
          ),
          subtitle: Text(
            subtitle,
            textAlign: TextAlign.left,
            style: TextStyle(height: 2.2, color: Mycolors.grey),
          ),
        ),
      ),
    ],
  );
}
