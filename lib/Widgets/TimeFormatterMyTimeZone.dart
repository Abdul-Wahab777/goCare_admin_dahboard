import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimeDateCOMLPETEString({
  BuildContext? context,
  Timestamp? timestamptargetTime,
  DateTime? datetimetargetTime,
  // int myTzoMinutes,
  bool? isdateTime,
  bool? isshowutc,
}) {
  int myTzoMinutes = DateTime.now().timeZoneOffset.inMinutes;
  // var myTzoMinutes = 330;
  DateTime sortedTime = isdateTime == true || isdateTime == null
      ? datetimetargetTime!.add(Duration(
          minutes: myTzoMinutes - datetimetargetTime.timeZoneOffset.inMinutes))
      : timestamptargetTime!.toDate().add(Duration(
          minutes: myTzoMinutes -
              timestamptargetTime.toDate().timeZoneOffset.inMinutes));

  final df = new DateFormat('dd MMM yyyy  hh:mm a');

  return isshowutc == true
      ? myTzoMinutes >= 0
          ? '${df.format(sortedTime)} (GMT+${minutesToHour(myTzoMinutes)})'
          : '${df.format(sortedTime)} (GMT${minutesToHour(myTzoMinutes)})'
      : '${df.format(sortedTime)}';
}

//--------------------
String minutesToHour(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2)}:${parts[1].padLeft(2, '0')}';
}
