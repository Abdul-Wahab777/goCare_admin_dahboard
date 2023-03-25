import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';

class FirebaseApi {
  static Future<QuerySnapshot> getFirestoreCOLLECTIONData(int limit,
      {DocumentSnapshot? startAfter, String? dataType, Query? refdata}) async {
    if (startAfter == null) {
      return refdata!.get();
    } else {
      return refdata!.startAfterDocument(startAfter).get();
    }
  }

  static Future<DocumentSnapshot> getFirestoreDOCUMENTData(
      String? dataType, DocumentReference refdata) async {
    return refdata.get();
  }

  Future<void> runUPDATEtransaction({
    GlobalKey? keyloader,
    GlobalKey? scaffoldkey,
    BuildContext? context,
    DocumentReference? refdata,
    String? compareKey,
    bool? isshowmsg,
    bool? isusesecondfn,
    bool? isreplace,
    String? compareVal,
    Function? secondfn,
    String? listreplaceablekey,
    Map<String, dynamic>? updatemap,
    String? newstringinlist,
    bool? isincremental,
    String? incrementalkey,
    String? decrementalkey,
    bool? isshowloader,
  }) async {
    if (isshowloader == null || isshowloader == true) {
      ShowLoading().open(context: context!, key: keyloader);
    }

    FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      DocumentReference newrefdata = refdata!;
      DocumentSnapshot docSnapshot = await tx.get(newrefdata);

      if (docSnapshot.exists) {
        List? newlist = docSnapshot[listreplaceablekey ?? Dbkeys.list];
        if (isincremental == false || isincremental == null) {
          if (newstringinlist == null) {
            List mykeylist = updatemap!.keys.toList();
            List myvaluelist = updatemap.values.toList();
            int ind = newlist!.indexWhere((dc) => dc[compareKey] == compareVal);
            print(ind);
            if (ind >= 0) {
              // newlist[ind][];
              for (int i = 0; i < mykeylist.length; i++) {
                newlist[ind][mykeylist[i]] = myvaluelist[i];
                print('For Loop Called $i Times');
              }
              tx.update(
                  newrefdata,
                  listreplaceablekey == null
                      ? {Dbkeys.list: newlist}
                      : {listreplaceablekey: newlist});
            } else {
              if (isshowloader == null || isshowloader == true) {
                ShowLoading().close(context: context, key: keyloader!);
              }

              ShowSnackbar().open(
                  context: context,
                  scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
                  time: 4,
                  status: 1,
                  label: 'Field doesn\'t exists ! Please reload this page.');
            }
          } else {
            if (isreplace == false || isreplace == null) {
              newlist!.insert(newlist.length, newstringinlist);
              tx.update(
                  newrefdata,
                  listreplaceablekey == null
                      ? {Dbkeys.list: newlist}
                      : {listreplaceablekey: newlist});
            } else {
              // print(newstringinlist);
              int ind = newlist!.indexWhere(
                  (element) => element.toString() == compareKey.toString());
              newlist.removeAt(ind);
              newlist.insert(ind, newstringinlist);
              tx.update(
                  newrefdata,
                  listreplaceablekey == null
                      ? {Dbkeys.list: newlist}
                      : {listreplaceablekey: newlist});
            }
          }
        } else {
          int ind =
              newlist!.indexWhere((dc) => dc[compareKey].contains(compareVal));
          Map updateobject = newlist[ind];
          int val = updateobject[incrementalkey];
          updateobject[incrementalkey] = val + 1;
          if (decrementalkey != null) {
            updateobject[decrementalkey] = val - 1;
          }
          newlist.removeAt(ind);
          newlist.insert(ind, updateobject);
          tx.update(
              newrefdata,
              listreplaceablekey == null
                  ? {Dbkeys.list: newlist}
                  : {listreplaceablekey: newlist});
        }
      } else {
        if (isshowloader == null || isshowloader == true) {
          ShowLoading().close(context: context, key: keyloader!);
        }

        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 4,
            status: 1,
            label: 'Document doesn\'t exists ! Please reload this page.');
      }
    }).then((result) {
      print('success transaction');
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      if (isshowmsg == true || isshowmsg == null) {
        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 2,
            status: 2,
            label: 'Success ! Operation successfully performed.');
      }
      if (isusesecondfn == false || isusesecondfn == null) {
      } else {
        secondfn!();
      }

      //  FocusScope.of(context).requestFocus(new FocusNode());
      //  showSnackBar('File Added Succesfully', 2,1);
    }).catchError((error) {
      print('errorr');
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      //  FocusScope.of(context).requestFocus(new FocusNode());
      print('Error: $error');
      ShowCustomAlertDialog().open(
          context: context!,
          scaffoldkey: scaffoldkey,
          dialogtype: 'error',
          errorlog: error,
          title: 'Operation Failed !',
          description: 'An unexpected error occured. please try again !');
    });
  }

  Future<void> runUPDATEtransactionInDocument({
    GlobalKey? keyloader,
    GlobalKey? scaffoldkey,
    BuildContext? context,
    DocumentReference? refdata,
    bool? isshowmsg,
    bool? isusesecondfn,
    Function? secondfn,
    Map<String, dynamic>? updatemap,
    bool? isincremental,
    Map<String, dynamic>? insertMapInListfield,
    String? incrementalkey,
    String? decrementalkey,
    bool? isshowloader,
  }) async {
    if (isshowloader == null || isshowloader == true) {
      ShowLoading().open(context: context!, key: keyloader);
    }

    FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      DocumentReference newrefdata = refdata!;
      DocumentSnapshot docSnapshot = await tx.get(newrefdata);

      if (docSnapshot.exists) {
        // Extend 'favorites' if the list does not contain the recipe ID:

        if (isincremental == false || isincremental == null) {
          if (insertMapInListfield != null) {
            Map<String, dynamic> updateobject =
                docSnapshot.data() as Map<String, dynamic>;
            updateobject['list'].add(insertMapInListfield);
            updateobject.addAll(updatemap!);
            tx.update(newrefdata, updateobject);
          } else {
            tx.update(newrefdata, updatemap!);
          }
        } else {
          Map<String?, dynamic> updateobject =
              docSnapshot.data() as Map<String?, dynamic>;
          int valincr = updateobject[incrementalkey];
          int? valdecr = updateobject[decrementalkey];
          updateobject[incrementalkey] = valincr + 1;
          if (decrementalkey != null) {
            updateobject[decrementalkey] = valdecr! - 1;
          }

          tx.update(newrefdata, updateobject as Map<String, dynamic>);
        }

        // Delete the recipe ID from 'favorites':
        // } else {
        //   await tx.update(favoritesReference, <String, dynamic>{
        //     'favorites': FieldValue.arrayRemove([recipeId])
        //   });
        // }

      } else {
        if (isshowloader == null || isshowloader == true) {
          ShowLoading().close(context: context, key: keyloader!);
        }

        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 4,
            status: 1,
            label: 'Document doesn\'t exists ! Please reload this page.');
      }
    }).then((result) {
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      if (isshowmsg == true || isshowmsg == null) {
        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 2,
            status: 2,
            label: 'Success ! Operation successfully performed.');
      }
      if (isusesecondfn == false || isusesecondfn == null) {
      } else {
        secondfn!();
      }

      //  FocusScope.of(context).requestFocus(new FocusNode());
      //  showSnackBar('File Added Succesfully', 2,1);
    }).catchError((error) {
      print('errorr');
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      //  FocusScope.of(context).requestFocus(new FocusNode());
      print('Error: $error');
      ShowCustomAlertDialog().open(
          context: context!,
          scaffoldkey: scaffoldkey,
          dialogtype: 'error',
          errorlog: error,
          title: 'Operation Failed !',
          description: 'An unexpected error occured. please try again !');
    });
  }

  Future<void> runUPDATEtransactionWithQuantityCheck({
    GlobalKey? keyloader,
    GlobalKey? scaffoldkey,
    BuildContext? context,
    Function(String val)? onerror,
    DocumentReference? refdata,
    int? totallimitfordelete,
    int? totaldeleterange,
    bool? isshowmsg,
    String? listname,
    bool? isusesecondfn,
    Function? secondfn,
    var newmap,
    bool? isshowloader,
  }) async {
    if (isshowloader == null || isshowloader == true) {
      ShowLoading().open(context: context!, key: keyloader);
    }

    FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot docSnapshot = await tx.get(refdata ??
          FirebaseFirestore.instance
              .collection(DbPaths.collectionhistory)
              .doc(DbPaths.collectionhistory));

      if (docSnapshot.exists) {
        print('------- UPDATE CODE  Start--------');
        List templist = docSnapshot[listname ?? Dbkeys.list];
        if (templist.length > totallimitfordelete!) {
          templist.removeRange(0, totaldeleterange ?? 50);
        }
        templist.add(newmap);

        tx.update(
            refdata ??
                FirebaseFirestore.instance
                    .collection(DbPaths.collectionhistory)
                    .doc(DbPaths.collectionhistory),
            listname == null ? {Dbkeys.list: templist} : {listname: templist});
      } else {
        if (isshowloader == null || isshowloader == true) {
          ShowLoading().close(context: context, key: keyloader!);
        }

        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 4,
            status: 1,
            label: 'Document doesn\'t exists ! Please reload this page.');
      }
    }).then((result) {
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      if (isshowmsg == true || isshowmsg == null) {
        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 2,
            status: 2,
            label: 'Success ! Operation successfully performed.');
      }
      if (isusesecondfn == false || isusesecondfn == null) {
      } else {
        secondfn!();
      }

      //  FocusScope.of(context).requestFocus(new FocusNode());
      //  showSnackBar('File Added Succesfully', 2,1);
    }).catchError((error) {
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }
      if (onerror == null) {
        print('Error: $error');
        ShowCustomAlertDialog().open(
            context: context!,
            scaffoldkey: scaffoldkey,
            dialogtype: 'error',
            errorlog: error,
            title: 'Operation Failed !',
            description: 'An unexpected error occured. please try again !');
      } else {
        onerror(error);
      }
      //  FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  Future<void> runUPDATEtransactionNotification({
    GlobalKey? keyloader,
    GlobalKey? scaffoldkey,
    BuildContext? context,
    DocumentReference? refdata,
    int? totallimitfordelete,
    int? totaldeleterange,
    bool? isshowmsg,
    bool? isusesecondfn,
    Function? secondfn,
    Map<String, dynamic>? newmapnotificationcontent,
    Map<String, dynamic>? newmapnotification,
    bool? isshowloader,
  }) async {
    if (isshowloader == null || isshowloader == true) {
      ShowLoading().open(context: context!, key: keyloader);
    }

    FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot docSnapshot = await tx.get(refdata ??
          FirebaseFirestore.instance
              .collection(DbPaths.collectionnotifications)
              .doc(DbPaths.collectionnotifications));

      if (docSnapshot.exists) {
        print('------- UPDATE CODE  Start--------');
        List templist = docSnapshot[Dbkeys.list];
        if (templist.length > totallimitfordelete!) {
          templist.removeRange(0, totaldeleterange ?? 50);
        }

        templist.add(newmapnotificationcontent);
        Map<String, dynamic> firstMap = {Dbkeys.list: templist};
        Map<String, dynamic> secondMap = newmapnotification!;

        Map<String, dynamic> thirdMap = {};

        thirdMap.addAll(firstMap);
        thirdMap.addAll(secondMap);
        tx.update(
            refdata ??
                FirebaseFirestore.instance
                    .collection(DbPaths.collectionnotifications)
                    .doc(DbPaths.collectionnotifications),
            thirdMap);
      } else {
        if (isshowloader == null || isshowloader == true) {
          ShowLoading().close(context: context, key: keyloader!);
        }

        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 4,
            status: 1,
            label: 'Document doesn\'t exists ! Please reload this page.');
      }
    }).then((result) {
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      if (isshowmsg == true || isshowmsg == null) {
        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 2,
            status: 2,
            label: 'Success ! Operation successfully performed.');
      }
      if (isusesecondfn == false || isusesecondfn == null) {
      } else {
        secondfn!();
      }

      //  FocusScope.of(context).requestFocus(new FocusNode());
      //  showSnackBar('File Added Succesfully', 2,1);
    }).catchError((error) {
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      //  FocusScope.of(context).requestFocus(new FocusNode());
      print('Error: $error');
      ShowCustomAlertDialog().open(
          context: context!,
          scaffoldkey: scaffoldkey,
          dialogtype: 'error',
          errorlog: error,
          title: 'Operation Failed !',
          description: 'An unexpected error occured. please try again !');
    });
  }

  Future<void> runDELETEtransaction({
    GlobalKey? keyloader,
    GlobalKey? scaffoldkey,
    BuildContext? context,
    DocumentReference? refdata,
    String? compareKey,
    bool? isshowmsg,
    String? compareVal,
    Function? secondfn,
    bool? isusesecondfn,
    bool? iswholeelementcompareable,
    bool? isshowloader,
  }) async {
    if (isshowloader == null || isshowloader == true) {
      ShowLoading().open(context: context!, key: keyloader);
    }

    FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot docSnapshot = await tx.get(refdata!);

      if (docSnapshot.exists) {
        List? newlist = docSnapshot[Dbkeys.list];
        int ind = iswholeelementcompareable == false ||
                iswholeelementcompareable == null
            ? newlist!.indexWhere((dc) => dc[compareKey] == compareVal)
            : newlist!
                .indexWhere((dc) => dc.toString() == compareKey.toString());
        print(ind);
        if (ind >= 0) {
          // newlist[ind][];
          newlist.removeAt(ind);

          tx.update(refdata, {Dbkeys.list: newlist});
        } else {
          if (isshowloader == null || isshowloader == true) {
            ShowLoading().close(context: context, key: keyloader!);
          }

          ShowSnackbar().open(
              context: context,
              scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
              time: 4,
              status: 1,
              label: 'Field doesn\'t exists ! Please reload this page.');
        }
        print('------- UPDATE CODE End --------');
        // Delete the recipe ID from 'favorites':
        // } else {
        //   await tx.update(favoritesReference, <String, dynamic>{
        //     'favorites': FieldValue.arrayRemove([recipeId])
        //   });
        // }

      } else {
        if (isshowloader == null || isshowloader == true) {
          ShowLoading().close(context: context, key: keyloader!);
        }

        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 4,
            status: 1,
            label: 'Document doesn\'t exists ! Please reload this page.');
      }
    }).then((result) {
      print('success result ;$result');
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      if (isshowmsg == true || isshowmsg == null) {
        ShowSnackbar().open(
            context: context,
            scaffoldKey: scaffoldkey as GlobalKey<ScaffoldState>,
            time: 2,
            status: 2,
            label: 'Success ! Operation successfully performed.');
      }
      if (isusesecondfn == false || isusesecondfn == null) {
      } else {
        secondfn!();
      }
    }).catchError((error) {
      if (isshowloader == null || isshowloader == true) {
        ShowLoading().close(context: context, key: keyloader!);
      }

      //  FocusScope.of(context).requestFocus(new FocusNode());

      ShowCustomAlertDialog().open(
          context: context!,
          scaffoldkey: scaffoldkey,
          dialogtype: 'error',
          errorlog: error,
          title: 'Operation Failed !',
          description: 'An unexpected error occured. please try again !');
    });
  }
}
