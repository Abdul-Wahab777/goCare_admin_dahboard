import 'package:fluttertoast/fluttertoast.dart';

DateTime? currentBackPressTime;
//----- Double tap to go back -----
Future<bool> doubleTapTrigger() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 3)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(
      msg: 'Double Tap to go back',
      toastLength: Toast.LENGTH_LONG,
    );
    return Future.value(false);
  }
  return Future.value(true);
}
