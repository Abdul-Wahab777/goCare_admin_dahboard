import 'package:flutter/foundation.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int currentInd = 0;

  // get currentIndex => _currentIndex;

  setcurrentIndex(int index) {
    currentInd = index;
    notifyListeners();
  }
}
