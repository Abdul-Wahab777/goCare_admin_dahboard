// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:intl/intl.dart';
// import 'package:ntp/ntp.dart';

// class LiveTimeProvider with ChangeNotifier {
//   // bool _initialized = false;
//   DateTime currentlivetime = DateTime.now();
//   Timestamp t;
//   int session = 0;
//   bool isdeactivate = false;
//   Timer timer;
//   updateLiveTime({bool isdeactivate}) async {
//     DateTime now;
//     try {
//       now = await NTP.now();
//       notifyListeners();
//       print('Live Time Calculating Started !');
//     } catch (e) {
//       now = DateTime.now();
//       notifyListeners();
//       print('Timeee  Erororororoororoorooro isssss : $e');
//     }
//     // String minutesToHour(int minutes) {
//     //   var d = Duration(minutes: minutes);
//     //   List<String> parts = d.toString().split(':');
//     //   return '${parts[0].padLeft(2)}:${parts[1].padLeft(2, '0')}';
//     // }

//     // String displayinmytimezone({int myTzoMinutes, DateTime targetTime}) {}

//     // print(durationToString(100));

//     if (isdeactivate == true && session != 0) {
//       timer.cancel();
//       notifyListeners();
//     }
//     session = session + 1;
//     const oneSec = const Duration(seconds: 8);
//     timer = Timer.periodic(oneSec, (Timer t) async {
//       //  DateTime now = await NTP.now().catchError((onError){print('TIME ERRRORRRRR::::::'+onError.toString());});
//       now = now.add(Duration(seconds: 8));
//       currentlivetime = now;
//       // timezoneoffsetminutes = now.timeZoneOffset.inMinutes;
//       //  currenttime=now;

//       notifyListeners();
//       // print('LIVE TIME $currentlivetime          SESSION:$session');
//       // displayinmytimezone(myTzoMinutes: -860, targetTime: now);
//     });
//     // print('IS TIMER ACTIVE ::' + timer.isActive.toString());
//     notifyListeners();
//   }
// }
