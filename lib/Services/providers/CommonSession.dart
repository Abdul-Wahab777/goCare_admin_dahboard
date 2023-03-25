import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseApi.dart';

class CommonSession with ChangeNotifier {
  String uid = 'admin';
  String fullname = 'Admin';
  String? photourl;
  String role = 'RoleValue1234';

  var userSettings;
  var adminSettings;
  var userCount;
  var chatData;

  setData(
      {String? newuid,
      newfullname,
      newphotourl,
      newrole,
      var newuserSettings,
      var newuserCount,
      var newadminSettings,
      var newchatData}) {
    uid = newuid != null ? newuid + 'admin' : uid;
    fullname = newfullname ?? fullname;
    photourl = newphotourl ?? photourl;
    role = newrole ?? role;
    userSettings = newuserSettings ?? userSettings;
    adminSettings = newadminSettings ?? adminSettings;
    userCount = newuserCount ?? userCount;
    chatData = newchatData ?? chatData;
    uid = newuid ?? uid;
    notifyListeners();
  }

  setUserAppSettingFromFirestore() async {
    await FirebaseFirestore.instance
        .collection(Dbkeys.appsettings)
        .doc(Dbkeys.userapp)
        .get()
        .then((doc) {
      userSettings = doc.data();
    });
    notifyListeners();
  }

  String? alertmsg;

  clearalert() {
    alertmsg = null;
    notifyListeners();
  }

  createalert(
      {BuildContext? context,
      DateTime? alerttime,
      String? alerttitle,
      String? alertdesc,
      String? alertuid,
      String? alertmsgforuser,
      String? alertcollection}) async {
    alertmsg = alertmsgforuser;
    notifyListeners();
    await FirebaseApi().runUPDATEtransactionNotification(
      context: context,
      isshowloader: false,
      isshowmsg: false,
      totallimitfordelete: Numberlimits.totalhistory,
      isusesecondfn: false,
      totaldeleterange: 40,
      refdata: FirebaseFirestore.instance
          .collection(alertcollection ?? DbPaths.collectionALLNORMALalerts)
          .doc(alertcollection ?? DbPaths.collectionALLNORMALalerts),
      newmapnotification: {
        Dbkeys.nOTIFICATIONxxtitle: alerttitle,
        Dbkeys.nOTIFICATIONxxdesc: alertdesc,
        Dbkeys.nOTIFICATIONxxaction: Dbkeys.nOTIFICATIONactionPUSH,
        Dbkeys.nOTIFICATIONxxlastupdate: alerttime,
      },
      newmapnotificationcontent: {
        Dbkeys.alertISSOLVED: false,
        Dbkeys.alertTITLE: alerttitle,
        Dbkeys.alertUSERSUID: Platform.isAndroid
            ? uid + '-BREAK-' + 'android'
            : Platform.isIOS
                ? uid + '-BREAK-' + 'ios'
                : Platform.isWindows
                    ? uid + '-BREAK-' + 'windows'
                    : Platform.isMacOS
                        ? uid + '-BREAK-' + 'mac'
                        : 'web',
        Dbkeys.alertDESC: alertdesc,
        Dbkeys.alertUSERSUID: uid,
        Dbkeys.alertTIMESTAMP: alerttime,
        Dbkeys.alertUSERSTYPE: AppConstants.apptype,
      },
    );
  }
}
