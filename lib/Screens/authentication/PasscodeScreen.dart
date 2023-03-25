import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Screens/authentication/Setupdata.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Screens/bottomnavbar/BottomNavBarAdminApp.dart';
import 'package:thinkcreative_technologies/Screens/errorScreens/ErrorScreen.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseApi.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Widgets/DelayedFunction.dart';
import 'package:thinkcreative_technologies/Widgets/MyInkWell.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';

class PasscodeScreen extends StatefulWidget {
  @override
  _PasscodeScreenState createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  bool isobsured = true;
  int attempt = 0;
  bool isFirstTimeSetup = false;
  List<String> numbers = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_hhddbh');
  GlobalKey<State> _keyLoader = new GlobalKey<State>(debugLabel: '7338hh83833');
  bool isemulator = false;
  bool? isallowemulator = false;
  bool? isCollectDeviceInfoAndSavetoDatabase = false;
  var mapDeviceInfo = {};
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late FirebaseAuth _auth;
  Future<User?> signInAnonymously() async {
    _auth = FirebaseAuth.instance;
    UserCredential signin = await _auth.signInAnonymously();

    return signin.user;
  }

  signinToFirebase(BuildContext context) async {
    await signInAnonymously().then((user) async {
      ShowLoading().close(context: context, key: _keyLoader);

      // ignore: unnecessary_null_comparison
      if (user!.uid != null) {
        delayedFunction(
            durationmilliseconds: 500,
            setstatefn: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyBottomNavBarAdminApp(
                      isFirstTimeSetup: isFirstTimeSetup),
                ),
                (route) => false,
              );
            });
      } else {
        final session = Provider.of<CommonSession>(context, listen: false);

        ShowSnackbar().open(
            label: 'Login Failed ! Please try again later.',
            context: context,
            scaffoldKey: _scaffoldKey,
            time: 3,
            status: 1);
        await session.createalert(
            alertmsgforuser: null,
            context: context,
            alertcollection: DbPaths.collectionALLNORMALalerts,
            alerttime: DateTime.now(),
            alerttitle: 'Admin Signin Failed',
            alertdesc:
                'Error occured while signing Admin anonymously. \n[CAPTURED ERROR:  ]');
      }
    }).catchError((err) async {
      final session = Provider.of<CommonSession>(context, listen: false);
      final observer = Provider.of<Observer>(context, listen: false);
      ShowLoading().close(context: context, key: _keyLoader);
      print('ALERT: $err');
      ShowCustomAlertDialog().open(
        context: context,
        errorlog: '' + err.toString(),
        isshowerrorlog: observer.isshowerrorlog,
        dialogtype: 'error',
      );
      await session.createalert(
          alertmsgforuser: null,
          context: context,
          alertcollection: DbPaths.collectionALLNORMALalerts,
          alerttime: DateTime.now(),
          alerttitle: 'Admin Signin Failed',
          alertdesc:
              'Error occured while signing Admin anonymously. \n[CAPTURED ERROR:$err]');
    });
  }

  finalcheckInWeb(BuildContext context, DocumentSnapshot doc) async {
    await FirebaseApi().runUPDATEtransactionWithQuantityCheck(
        isshowmsg: false,
        context: context,
        scaffoldkey: _scaffoldKey,
        isusesecondfn: true,
        refdata: FirebaseFirestore.instance
            .collection(Dbkeys.admincredentials)
            .doc(Dbkeys.admincredentials),
        keyloader: _keyLoader,
        totaldeleterange: 30,
        totallimitfordelete: 50,
        isshowloader: false,
        newmap: mapDeviceInfo,
        secondfn: () async {
          await FirebaseFirestore.instance
              .collection(Dbkeys.admincredentials)
              .doc(Dbkeys.admincredentials)
              .update({
            Dbkeys.admincurrentdevice: mapDeviceInfo[Dbkeys.deviceInfoMODEL]
          });
        });

    await signinToFirebase(context);
  }

  finalcheckInAndroidIos(BuildContext context, DocumentSnapshot doc) async {
    if (isemulator == true && isallowemulator == false) {
      ShowLoading().close(context: context, key: _keyLoader);
      delayedFunction(
          durationmilliseconds: 100,
          setstatefn: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ErrorScreen(
                  uid: null,
                  reason: Dbkeys.errorREASONdeviceisemulator,
                ),
              ),
              (route) => false,
            );
          });
    } else {
      if (isCollectDeviceInfoAndSavetoDatabase == true) {
        await FirebaseApi().runUPDATEtransactionWithQuantityCheck(
            isshowmsg: false,
            context: context,
            scaffoldkey: _scaffoldKey,
            isusesecondfn: true,
            listname: Dbkeys.admindeviceslist,
            refdata: FirebaseFirestore.instance
                .collection(Dbkeys.admincredentials)
                .doc(Dbkeys.admincredentials),
            keyloader: _keyLoader,
            totaldeleterange: 30,
            totallimitfordelete: 50,
            isshowloader: false,
            newmap: mapDeviceInfo,
            secondfn: AppConstants.isdemomode == true
                ? () {}
                : () async {
                    await FirebaseFirestore.instance
                        .collection(Dbkeys.admincredentials)
                        .doc(Dbkeys.admincredentials)
                        .update({
                      Dbkeys.admincurrentdevice:
                          mapDeviceInfo[Dbkeys.deviceInfoMODEL]
                    });
                  });
        await signinToFirebase(context);
      } else {
        await signinToFirebase(context);
      }
    }
  }

  checkdevice(BuildContext context) async {
    final session = Provider.of<CommonSession>(context, listen: false);
    final observer = Provider.of<Observer>(context, listen: false);

    await FirebaseFirestore.instance
        .collection(Dbkeys.appsettings)
        .doc(Dbkeys.adminapp)
        .get()
        .then((docsetting) async {
      if (docsetting.exists) {
        session.setData(newadminSettings: docsetting.data());
        if (mounted) {
          setState(() {
            isallowemulator = docsetting[Dbkeys.isemulatorallowed];
            isCollectDeviceInfoAndSavetoDatabase =
                docsetting[Dbkeys.isCollectDeviceInfoAndSavetoDatabase];
          });
        }
        print('step 1');
        if (Platform.isAndroid == true || Platform.isIOS == true) {
          //FOR ANDROID & IOS *************
          print('step 2');
          if (isallowemulator == false) {
            if (mounted) {
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
              setState(() {
                isemulator = !androidInfo.isPhysicalDevice;
              });
            }
          }
          if (isCollectDeviceInfoAndSavetoDatabase == true) {
            if (Platform.isAndroid) {
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

              if (mounted) {
                setState(() {
                  mapDeviceInfo = {
                    Dbkeys.deviceInfoMODEL: androidInfo.model,
                    Dbkeys.deviceInfoOS: 'android',
                    Dbkeys.deviceInfoISPHYSICAL: androidInfo.isPhysicalDevice,
                    Dbkeys.deviceInfoDEVICEID: androidInfo.id,
                    Dbkeys.deviceInfoOSID: androidInfo.androidId,
                    Dbkeys.deviceInfoOSVERSION: androidInfo.version.baseOS,
                    Dbkeys.deviceInfoMANUFACTURER: androidInfo.manufacturer,
                    Dbkeys.deviceInfoLOGINTIMESTAMP: DateTime.now(),
                  };
                });
                setState(() {
                  isemulator = !androidInfo.isPhysicalDevice;
                });

                Future.delayed(const Duration(milliseconds: 10), () async {
                  finalcheckInAndroidIos(context, docsetting);
                });
              }
            } else if (Platform.isIOS) {
              IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

              if (mounted) {
                setState(() {
                  mapDeviceInfo = {
                    Dbkeys.deviceInfoMODEL: iosInfo.model,
                    Dbkeys.deviceInfoOS: 'ios',
                    Dbkeys.deviceInfoISPHYSICAL: iosInfo.isPhysicalDevice,
                    Dbkeys.deviceInfoDEVICEID: iosInfo.identifierForVendor,
                    Dbkeys.deviceInfoOSID: iosInfo.name,
                    Dbkeys.deviceInfoOSVERSION: iosInfo.name,
                    Dbkeys.deviceInfoMANUFACTURER: iosInfo.name,
                    Dbkeys.deviceInfoLOGINTIMESTAMP: DateTime.now(),
                  };
                });
                setState(() {
                  isemulator = !iosInfo.isPhysicalDevice;
                });
              }
              print('Running on $mapDeviceInfo');
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(milliseconds: 10), () async {
                print('android check started');
                finalcheckInAndroidIos(context, docsetting);
              });
              // });
            } else {
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(milliseconds: 10), () async {
                finalcheckInAndroidIos(context, docsetting);
              });
              // });
            }
          } else {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(milliseconds: 10), () async {
              finalcheckInAndroidIos(context, docsetting);
            });
            // });
          }
        } else {
          //FOR WEB *************
          if (mounted) {
            setState(() {
              mapDeviceInfo = {
                Dbkeys.deviceInfoMODEL: 'web',
                Dbkeys.deviceInfoOS: 'web',
                Dbkeys.deviceInfoISPHYSICAL: 'true',
                Dbkeys.deviceInfoDEVICEID: 'web',
                Dbkeys.deviceInfoOSID: 'web',
                Dbkeys.deviceInfoOSVERSION: 'web',
                Dbkeys.deviceInfoMANUFACTURER: 'web',
                Dbkeys.deviceInfoLOGINTIMESTAMP: DateTime.now(),
              };
            });
          }
          Future.delayed(const Duration(milliseconds: 10), () async {
            finalcheckInWeb(context, docsetting);
          });
        }
      } else {
        ShowLoading().close(context: context, key: _keyLoader);

        ShowCustomAlertDialog().open(
          context: context,
          errorlog:
              'Cannot find the adminappsettings. Please restart the app & try again.',
          isshowerrorlog: observer.isshowerrorlog,
          dialogtype: 'error',
        );
        await session.createalert(
            alertmsgforuser: null,
            context: context,
            alertcollection: DbPaths.collectionALLNORMALalerts,
            alerttime: DateTime.now(),
            alerttitle: 'Admin Device Virification Failed',
            alertdesc:
                'Error occured while verifying device of Admin. \n[CAPTURED ERROR: adminappsettings Document Does not exists. Please restart the app & try again.]');
      }
    }).catchError((onError) async {
      ShowLoading().close(context: context, key: _keyLoader);
      print(onError);
      ShowCustomAlertDialog().open(
        context: context,
        errorlog: '' + onError.toString(),
        isshowerrorlog: observer.isshowerrorlog,
        dialogtype: 'error',
      );
      await session.createalert(
          alertmsgforuser: null,
          context: context,
          alertcollection: DbPaths.collectionALLNORMALalerts,
          alerttime: DateTime.now(),
          alerttitle: 'Admin Device Virification Failed',
          alertdesc:
              'Error occured while verifying device of Admin. \n[CAPTURED ERROR:$onError]');
    });
  }

  initialcheck(BuildContext context) async {
    final session = Provider.of<CommonSession>(context, listen: false);
    final observer = Provider.of<Observer>(context, listen: false);
    //----  Checking if entered pin correct-------
    String formattedpin =
        '${numbers[0]}${numbers[1]}${numbers[2]}${numbers[3]}${numbers[4]}${numbers[5]}';
    print("pibPrintes"+formattedpin);
    ShowLoading().open(context: context, key: _keyLoader);
    await FirebaseFirestore.instance
        .collection(Dbkeys.admincredentials)
        .doc(Dbkeys.admincredentials)
        .get()
        .then((doc) async {
      if (!doc.exists) {
        ShowLoading().close(context: context, key: _keyLoader);
        ShowSnackbar().open(
            context: context,
            scaffoldKey: _scaffoldKey,
            label: 'Cannot verify PIN. Please Contact the Developer.',
            status: 1,
            time: 3);

        numbers.clear();

        setState(() {});
      } else if (doc[Dbkeys.adminpin] == formattedpin ||
          AppConstants.isdemomode == true) {
        //----  Perform if authentication is verified / correct pin entered-------
        print('verified');

        isFirstTimeSetup =
            (doc[Dbkeys.adminpin] == initialadminloginpin) ? true : false;

        setState(() {});
        session.setData(
          newfullname: doc[Dbkeys.adminfullname],
          newphotourl: doc[Dbkeys.adminphotourl],
        );

        checkdevice(context);
      } else {
        //----  Incorrect pin entered-------
        ShowLoading().close(context: context, key: _keyLoader);
        Utils.toast(attempt > 5
            ? 'Incorrect PIN. Please contact the developer !'
            : 'Incorrect PIN. Please make sure the pin you entered is correct !');
        // ShowSnackbar().open(
        //     context: context,
        //     scaffoldKey: _scaffoldKey,
        //     label: attempt > 5
        //         ? 'Incorrect PIN. Please contact the developer !'
        //         : 'Incorrect PIN. Please make sure the pin you entered is correct !',
        //     status: 1,
        //     time: attempt > 5 ? 5 : 2);

        numbers.clear();
        attempt++;
        setState(() {});
      }
    }).catchError((err) async {
      //----  Throw error-------
      ShowLoading().close(context: context, key: _keyLoader);

      ShowCustomAlertDialog().open(
        context: context,
        errorlog: err.toString(),
        isshowerrorlog: observer.isshowerrorlog,
        dialogtype: 'error',
      );
      await session.createalert(
          alertmsgforuser: null,
          context: context,
          alertcollection: DbPaths.collectionALLNORMALalerts,
          alerttime: DateTime.now(),
          alerttitle: 'Admin PIN matching Failed',
          alertdesc:
              'Admin PIN Verification failed (${AppConstants.apptype}). Check the admin credentials and help verify securily.\n[CAPTURED ERROR:$err]');
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Mycolors.scaffoldbcg,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text('Enter 6-Digit PIN',
            style: TextStyle(color: Colors.black87, fontSize: 19)),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(18.0),
        //     child: Icon(Icons.help_outline_rounded, color: Colors.grey),
        //   )
        // ],
      ),
      bottomSheet: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppConstants.isdemomode == true
              ? MtCustomfontRegular(
                  text: 'Enter any 6-digit PIN for Demo Mode',
                  fontsize: 14,
                )
              : SizedBox(height: 0),
          SizedBox(
            height: 60,
          ),
          Container(
            alignment: Alignment.center,
            decoration: boxDecoration(bgColor: Colors.white, showShadow: true),
            height: 80,
            width: w / 1.2,
            child: ListView.builder(
                itemCount: numbers.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isobsured == false ? numbers[i].toString() : '\•',
                      style: TextStyle(
                          fontSize: isobsured == true ? 42 : 28,
                          fontWeight: FontWeight.bold,
                          color: Mycolors.primary),
                    ),
                  ));
                }),
          ),
          SizedBox(height: 18),
          Container(
              color: Colors.white,
              height: h / 2,
              width: w,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 2),
                shrinkWrap: true,
                children: [
                  cutomtexttappable(context, 1),
                  cutomtexttappable(context, 2),
                  cutomtexttappable(context, 3),
                  cutomtexttappable(context, 4),
                  cutomtexttappable(context, 5),
                  cutomtexttappable(context, 6),
                  cutomtexttappable(context, 7),
                  cutomtexttappable(context, 8),
                  cutomtexttappable(context, 9),
                  widget10(),
                  // widget11(),
                  cutomtexttappable(context, 0),
                  widget12(),
                ],
              )),
        ],
      ),
    
    );
  }

  widget12() {
    return myinkwell(
      onLongPress: () {
        numbers.clear();
        setState(() {});
      },
      onTap: numbers.length <= 0
          ? () {}
          : () {
              setState(() {
                numbers.removeLast();
              });
              HapticFeedback.lightImpact();
            },
      child: Container(
        child: Icon(Icons.backspace_rounded, size: 30, color: Colors.grey),
      ),
    );
  }

  widget10() {
    return myinkwell(
      onTap: numbers.length == 0
          ? null
          : () {
              setState(() {
                isobsured = !isobsured;
              });
              HapticFeedback.mediumImpact();
            },
      child: Container(
        child: Icon(
            isobsured == true
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 30,
            color: Colors.grey),
      ),
    );
  }

  widget11() {
    return Container(
      child: Icon(Icons.check_circle,
          size: 50, color: numbers.length == 6 ? Colors.green : Colors.grey),
    );
  }

  cutomtexttappable(BuildContext context, int number) {
    return myinkwell(
      onTap: () {
        if (numbers.length == 6) {
        } else if (numbers.length == 5) {
          numbers.add('$number');
          setState(() {});
          HapticFeedback.lightImpact();
          initialcheck(context);
        } else {
          numbers.add('$number');
          setState(() {});
          HapticFeedback.lightImpact();
        }
      },
      child: Container(
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800]),
          )),
    );
  }
}
