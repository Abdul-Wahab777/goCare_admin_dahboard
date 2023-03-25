import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseApi.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';

//  _________ NOTIFICATION____________
class FirestoreDataProviderDocNOTIFICATION with ChangeNotifier {
  List? listmap = [];
  String _errorMessage = '';
  // bool _hasNext = true;
  bool isFetchingData = false;

  String get errorMessage => _errorMessage;

  // bool get hasNext => _hasNext;

  Future fetchLISTDOCUMENT(String? dataType, DocumentReference? refdataa,
      bool isAfterNewdocCreated) async {
    if (isFetchingData) return;

    _errorMessage = '';
    isFetchingData = true;

    try {
      print('starttttteddd');
      final doc =
          await FirebaseApi.getFirestoreDOCUMENTData(dataType, refdataa!);
      if (!doc.exists) {
        await refdataa.set({
          Dbkeys.list: [],
        });
        listmap!.clear();
        listmap = [];
      } else {
        listmap = [];
        listmap = doc[Dbkeys.list];
        print('successsssss');
      }

      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    isFetchingData = false;
  }

  updateparticulardocinLISTDOCUMENTProvider({
    String? compareKey,
    String? compareVal,
    String? correctKey,
    dynamic correctVal,
  }) async {
    int index = listmap!.indexWhere((prod) => prod[compareKey] == compareVal);

    listmap![index][correctKey] = correctVal;

    notifyListeners();
  }

  deleteparticulardocinLISTDOCUMENTProvider({
    String? compareKey,
    String? compareVal,
  }) async {
    int index = listmap!.indexWhere((prod) => prod[compareKey] == compareVal);

    listmap!.removeAt(index);
    notifyListeners();
  }
}
