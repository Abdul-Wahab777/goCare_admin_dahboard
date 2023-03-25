import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseApi.dart';

//  _________ USERS ____________
class FirestoreDataProviderUSERS extends ChangeNotifier {
  final _datalistSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  bool _hasNext = true;
  bool _isFetchingData = false;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  List get recievedDocs => _datalistSnapshot.map((snap) {

    // if(snap.get("specialization")!="[]"){}
        final recievedData = snap.data();

        return recievedData;
      }).toList();

  reset() {
    _hasNext = true;
    _datalistSnapshot.clear();
    _isFetchingData = false;
    _errorMessage = '';
    recievedDocs.clear();
    notifyListeners();
  }

  Future fetchNextData(
      String? dataType, Query? refdataa, bool isAfterNewdocCreated) async {
    if (_isFetchingData) return;

    _errorMessage = '';
    _isFetchingData = true;

    try {
      final snap = isAfterNewdocCreated == true
          ? await FirebaseApi.getFirestoreCOLLECTIONData(
              Numberlimits.totalDatatoLoadAtOnceFromFirestore,
              // startAfter: null,
              refdata: refdataa)
          : await FirebaseApi.getFirestoreCOLLECTIONData(
              Numberlimits.totalDatatoLoadAtOnceFromFirestore,
              startAfter:
                  _datalistSnapshot.isNotEmpty ? _datalistSnapshot.last : null,
              refdata: refdataa);
      if (isAfterNewdocCreated == true) {
        _datalistSnapshot.clear();
        _datalistSnapshot.addAll(snap.docs);
      } else {
        _datalistSnapshot.addAll(snap.docs);
      }
      // notifyListeners();
      if (snap.docs.length < Numberlimits.totalDatatoLoadAtOnceFromFirestore)
        _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingData = false;
  }

  updateparticulardocinProvider({
    required String collection,
    String? document,
    String? compareKey,
    String? compareVal,
    GlobalKey? scaffoldkey,
    BuildContext? context,
  }) async {
    int index =
        _datalistSnapshot.indexWhere((prod) => prod[compareKey!] == compareVal);
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .get()
        .then((value) {
      _datalistSnapshot.removeAt(index);
      _datalistSnapshot.insert(index, value);
      notifyListeners();
    });
  }

  deleteparticulardocinProvider({
    String? collection,
    String? document,
    String? compareKey,
    String? compareVal,
    GlobalKey? scaffoldkey,
    GlobalKey? keyloader,
    BuildContext? context,
  }) async {
    int index =
        _datalistSnapshot.indexWhere((prod) => prod[compareKey!] == compareVal);

    _datalistSnapshot.removeAt(index);
    notifyListeners();
  }
}

//  _________ CALL HISTORY ____________
class FirestoreDataProviderCALLHISTORY extends ChangeNotifier {
  final _datalistSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  bool _hasNext = true;
  bool _isFetchingData = false;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  List get recievedDocs => _datalistSnapshot.map((snap) {
        final recievedData = snap.data();

        return recievedData;
      }).toList();

  Future fetchNextData(
      String? dataType, Query? refdataa, bool isAfterNewdocCreated) async {
    if (_isFetchingData) return;

    _errorMessage = '';
    _isFetchingData = true;

    try {
      final snap = isAfterNewdocCreated == true
          ? await FirebaseApi.getFirestoreCOLLECTIONData(
              Numberlimits.totalDatatoLoadAtOnceFromFirestore,
              // startAfter: null,
              refdata: refdataa)
          : await FirebaseApi.getFirestoreCOLLECTIONData(
              Numberlimits.totalDatatoLoadAtOnceFromFirestore,
              startAfter:
                  _datalistSnapshot.isNotEmpty ? _datalistSnapshot.last : null,
              refdata: refdataa);
      if (isAfterNewdocCreated == true) {
        _datalistSnapshot.clear();
        _datalistSnapshot.addAll(snap.docs);
      } else {
        _datalistSnapshot.addAll(snap.docs);
      }
      // notifyListeners();
      if (snap.docs.length < Numberlimits.totalDatatoLoadAtOnceFromFirestore)
        _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingData = false;
  }

  updateparticulardocinProvider({
    required String collection,
    String? document,
    String? compareKey,
    String? compareVal,
    GlobalKey? scaffoldkey,
    BuildContext? context,
  }) async {
    int index =
        _datalistSnapshot.indexWhere((prod) => prod[compareKey!] == compareVal);
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .get()
        .then((value) {
      _datalistSnapshot.removeAt(index);
      _datalistSnapshot.insert(index, value);
      notifyListeners();
    });
  }

  deleteparticulardocinProvider({
    String? collection,
    String? document,
    String? compareKey,
    String? compareVal,
    GlobalKey? scaffoldkey,
    GlobalKey? keyloader,
    BuildContext? context,
  }) async {
    int index =
        _datalistSnapshot.indexWhere((prod) => prod[compareKey!] == compareVal);

    _datalistSnapshot.removeAt(index);
    notifyListeners();
  }
}

//  _________ REPORTS ____________
class FirestoreDataProviderREPORTS extends ChangeNotifier {
  final _datalistSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  bool _hasNext = true;
  bool _isFetchingData = false;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  List get recievedDocs => _datalistSnapshot.map((snap) {
        final recievedData = snap.data();

        return recievedData;
      }).toList();

  reset() {
    _hasNext = true;
    _datalistSnapshot.clear();
    _isFetchingData = false;
    _errorMessage = '';
    recievedDocs.clear();
    notifyListeners();
  }

  Future fetchNextData(
      String? dataType, Query? refdataa, bool isAfterNewdocCreated) async {
    if (_isFetchingData) return;

    _errorMessage = '';
    _isFetchingData = true;

    try {
      final snap = isAfterNewdocCreated == true
          ? await FirebaseApi.getFirestoreCOLLECTIONData(
              Numberlimits.totalDatatoLoadAtOnceFromFirestore,
              // startAfter: null,
              refdata: refdataa)
          : await FirebaseApi.getFirestoreCOLLECTIONData(
              Numberlimits.totalDatatoLoadAtOnceFromFirestore,
              startAfter:
                  _datalistSnapshot.isNotEmpty ? _datalistSnapshot.last : null,
              refdata: refdataa);
      if (isAfterNewdocCreated == true) {
        _datalistSnapshot.clear();
        _datalistSnapshot.addAll(snap.docs);
      } else {
        _datalistSnapshot.addAll(snap.docs);
      }
      // notifyListeners();
      if (snap.docs.length < Numberlimits.totalDatatoLoadAtOnceFromFirestore)
        _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingData = false;
  }

  updateparticulardocinProvider({
    required String collection,
    String? document,
    String? compareKey,
    String? compareVal,
    GlobalKey? scaffoldkey,
    BuildContext? context,
  }) async {
    int index =
        _datalistSnapshot.indexWhere((prod) => prod[compareKey!] == compareVal);
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .get()
        .then((value) {
      _datalistSnapshot.removeAt(index);
      _datalistSnapshot.insert(index, value);
      notifyListeners();
    });
  }

  deleteparticulardocinProvider({
    required String compareKey,
    required int compareVal,
  }) async {
    int index =
        _datalistSnapshot.indexWhere((prod) => prod[compareKey] == compareVal);

    _datalistSnapshot.removeAt(index);
    notifyListeners();
  }
}
