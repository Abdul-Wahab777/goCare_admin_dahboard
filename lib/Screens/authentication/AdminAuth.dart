import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Screens/authentication/PasscodeScreen.dart';
import 'package:thinkcreative_technologies/Screens/splashScreen/SplashScreen.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Utils/custom_url_launcher.dart';
import 'package:thinkcreative_technologies/Widgets/Buttons.dart';
import 'package:thinkcreative_technologies/Widgets/InputBox.dart';
import 'package:thinkcreative_technologies/Widgets/MySharedPrefs.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Widgets/hideKeyboard.dart';
import 'package:thinkcreative_technologies/Widgets/pageNavigator.dart';

class AdminAauth extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> doc;
  AdminAauth({required this.doc, key}) : super(key: key);
  @override
  _AdminAauthState createState() => _AdminAauthState();
}

class _AdminAauthState extends State<AdminAauth> {
  bool isloading = true;
  bool isloggedin = false;
  bool isfirsttimesetup = false;
  bool iserror = false;
  bool isundermaintainance = false;
  Map<dynamic, dynamic>? settingsMap = {};

  String? errormsg = '';
  int attempt = 0;
  TextEditingController _enteredusernamecontroller =
      new TextEditingController();
  TextEditingController _enteredpasswordcontroller =
      new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_hhddbh');
  GlobalKey<State> _keyLoader =
      new GlobalKey<State>(debugLabel: '7338dshh83833');
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLoginStatus();
    });

    if (AppConstants.isdemomode == true) {
      _enteredusernamecontroller.text = 'abcdef';
      _enteredpasswordcontroller.text = 'abcdef';
    }
  }

  checkLoginStatus() async {
    final observer = Provider.of<Observer>(context, listen: false);
    observer.setSettingsForAdminApp(widget.doc);
    if (mounted) {
      setState(() {
        settingsMap = widget.doc.data();
      });
    }

    if (widget.doc[Platform.isAndroid
            ? Dbkeys.isappunderconstructionandroid
            : Platform.isIOS
                ? Dbkeys.isappunderconstructionios
                : Platform.isMacOS
                    ? Dbkeys.isappunderconstructionmac
                    : Platform.isWindows
                        ? Dbkeys.isappunderconstructionwindows
                        : Dbkeys.isappunderconstructionweb] ==
        true) {
      //---maintaiance mode show ------
      if (mounted) {
        setState(() {
          settingsMap = widget.doc.data();
          isundermaintainance = true;
          errormsg = widget.doc[Dbkeys.maintainancemessage];

          isloading = false;
        });
      }
    } else {
      final PackageInfo info = await PackageInfo.fromPlatform();
      int currentAppVersionInPhone = int.tryParse(info.version
                  .trim()
                  .split(".")[0]
                  .toString()
                  .padLeft(3, '0') +
              info.version.trim().split(".")[1].toString().padLeft(3, '0') +
              info.version.trim().split(".")[2].toString().padLeft(3, '0')) ??
          0;
      int currentNewAppVersionInServer =
          int.tryParse(widget.doc[Platform.isAndroid
                          ? Dbkeys.latestappversionandroid
                          : Platform.isIOS
                              ? Dbkeys.latestappversionios
                              : Dbkeys.latestappversionweb]
                      .trim()
                      .split(".")[0]
                      .toString()
                      .padLeft(3, '0') +
                  widget.doc[Platform.isAndroid
                          ? Dbkeys.latestappversionandroid
                          : Platform.isIOS
                              ? Dbkeys.latestappversionios
                              : Dbkeys.latestappversionweb]
                      .trim()
                      .split(".")[1]
                      .toString()
                      .padLeft(3, '0') +
                  widget.doc[Platform.isAndroid
                          ? Dbkeys.latestappversionandroid
                          : Platform.isIOS
                              ? Dbkeys.latestappversionios
                              : Dbkeys.latestappversionweb]
                      .trim()
                      .split(".")[2]
                      .toString()
                      .padLeft(3, '0')) ??
              0;
      print(currentNewAppVersionInServer);
      print(currentAppVersionInPhone);
      if (((currentNewAppVersionInServer > currentAppVersionInPhone
          //  &&
          //     doc[Dbkeys.isupdatemandatory] == true
          ))) {
//---show update popup ------
        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            String title = 'App Update Available';
            String message = 'Please update the app to continue using app.';
            String btnLabel = 'Update Now';
            // String btnLabelCancel = "Later";
            return
                // Platform.isIOS
                //     ? new CupertinoAlertDialog(
                //         title: Text(title),
                //         content: Text(message),
                //         actions: <Widget>[
                //           TextButton(
                //             child: Text(btnLabel),
                //             onPressed: () => launch(doc['url']),
                //           ),
                //           // TextButton(
                //           //   child: Text(btnLabelCancel),
                //           //   onPressed: () => Navigator.pop(context),
                //           // ),
                //         ],
                //       )
                //     :
                new WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      title: Text(
                        title,
                        style: TextStyle(color: Mycolors.black),
                      ),
                      content: Text(message),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            btnLabel,
                            style: TextStyle(color: Mycolors.primary),
                          ),
                          onPressed: () =>
                              custom_url_launcher(widget.doc[Platform.isAndroid
                                  ? Dbkeys.newapplinkandroid
                                  : Platform.isIOS
                                      ? Dbkeys.newapplinkios
                                      : Platform.isMacOS
                                          ? Dbkeys.newapplinkmac
                                          : Platform.isWindows
                                              ? Dbkeys.newapplinkwindows
                                              : Dbkeys.newapplinkweb]),
                        ),
                        // TextButton(
                        //   child: Text(btnLabelCancel),
                        //   onPressed: () => Navigator.pop(context),
                        // ),
                      ],
                    ));
          },
        );
      } else {
        MySharedPrefs().getmybool('isLoggedIn').then((isAlreadyLoggedIn) {
          if (isAlreadyLoggedIn == null || isAlreadyLoggedIn == false) {
            if (mounted) {
              //---- all ok ----
              isloading = false;
              isfirsttimesetup = false;
              iserror = false;
              setState(() {});
            }
          } else if (isAlreadyLoggedIn == true) {
            pageNavigator(context, PasscodeScreen());
          }
        });
      }
    }
    // } else {
    //   await firsttimeWriteDatabase();
    // }
  }

  bool istask1done = false;
  bool isLoading = false;
  loginWdget(BuildContext context) {
    // log("-=---------------->${widget.doc.data()}");
    var h = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(28, 45, 28, 17),
                    child: Image.asset(
                      AppConstants.logopath,
                      height: 90,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(28, h / 47, 28, 10),
                    child: MtCustomfontBoldSemi(
                      text: 'Welcome to',
                      color: Colors.white54,
                      fontsize: 23,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(28, 5, 13, 17),
                    child: MtCustomfontBoldExtra(
                      text: AppConstants.title,
                      color: Colors.white,
                      fontsize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                      color: Colors.white.withOpacity(0.3),
                      spreadRadius: 1.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                margin: EdgeInsets.fromLTRB(15, h / 20.3, 16, 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 13,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                      child: MtCustomfontBold(
                        text: 'Login to Admin Account',
                        color: Mycolors.secondary,
                        fontsize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: InpuTextBox(
                        boxbordercolor: Colors.white,
                        boxbcgcolor: Mycolors.greylightcolor,
                        hinttext: 'Login ID',
                        boxcornerradius: 6,
                        boxheight: 50,
                        controller: _enteredusernamecontroller,
                        forcedmargin: EdgeInsets.only(bottom: 0),
                        autovalidate: false,
                        contentpadding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 20, right: 20),
                        keyboardtype: TextInputType.text,
                        inputFormatter: [],
                        onSaved: (val) {},
                        isboldinput: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                      child: InpuTextBox(
                        boxbordercolor: Colors.white,
                        boxbcgcolor: Mycolors.greylightcolor,
                        hinttext: 'Password',
                        boxcornerradius: 6,
                        boxheight: 50,
                        autovalidate: false,
                        contentpadding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 20, right: 20),
                        keyboardtype: TextInputType.text,
                        inputFormatter: [],
                        obscuretext: true,
                        controller: _enteredpasswordcontroller,
                        isboldinput: true,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(17),
                    //   child: Text(
                    //     'Send a SMS Code to Verify your number.',
                    //     // 'Send a SMS Code to verify your number',
                    //     textAlign: TextAlign.center,
                    //     // style: TextStyle(color: Mycolors.black),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 12, 15, 0),
                      child: isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : MySimpleButton(
                              buttoncolor: Mycolors.black,
                              buttontext: 'LOGIN',
                              onpressed: 
                              AppConstants.isdemomode == true
                                  ? () {
                                      pageNavigator(context, PasscodeScreen());
                                    }
                                  : settingsMap![Dbkeys.isblocknewlogins] ==
                                          true
                                      ? () {
                                          ShowSnackbar().open(
                                              label:
                                                  'Login temporarily blocked by admin.',
                                              context: context,
                                              scaffoldKey: _scaffoldKey,
                                              time: 2,
                                              status: 0);
                                        }
                                      // ignore: unnecessary_null_comparison
                                      : _enteredusernamecontroller.text ==
                                                  null ||
                                              // ignore: unnecessary_null_comparison
                                              _enteredpasswordcontroller.text ==
                                                  null
                                          ? () {
                                              ShowSnackbar().open(
                                                  label:
                                                      'Please enter login credentials',
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  time: 2,
                                                  status: 0);
                                            }
                                          : 
                                          () async {
                                              await loginCredentialsCheck(
                                                  context);
                                                  //  pageNavigator(context, PasscodeScreen());
                                            },
                            ),
                    ),

                    SizedBox(
                      height: 11,
                    ),
                    AppConstants.isdemomode
                        ? MtCustomfontRegular(
                            text: 'Just Tap on the Login Button',
                            fontsize: 12,
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 11,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  loginCredentialsCheck(BuildContext context) async {
    final session = Provider.of<CommonSession>(context, listen: false);
    hidekeyboard(context);

    ShowLoading().open(
      context: context,
      key: _keyLoader,
    );
    await FirebaseFirestore.instance
        .collection(Dbkeys.admincredentials)
        .doc(Dbkeys.admincredentials)
        .get()
        .then((doc) async {
      if (doc.exists) {
        if (doc[Dbkeys.adminusername] == _enteredusernamecontroller.text &&
            doc[Dbkeys.adminpassword] == _enteredpasswordcontroller.text) {
          //--- entered credentials are correct
          ShowLoading().close(
            context: context,
            key: _keyLoader,
          );
          pageNavigator(context, PasscodeScreen());
        } else {
          //--- entered credentials are incorrect
          ShowLoading().close(
            context: context,
            key: _keyLoader,
          );
          ShowSnackbar().open(
              label: 'Invalid Credentials. Please try again !',
              context: context,
              scaffoldKey: _scaffoldKey,
              time: 3,
              status: 1);
          await session.createalert(
              alertmsgforuser: null,
              context: context,
              alertcollection: DbPaths.collectionALLNORMALalerts,
              alerttime: DateTime.now(),
              alerttitle: 'Admin Credentials incorrect',
              alertdesc:
                  'Error occured while matching admin entered login credentials in admin app \n[CAPTURED ERROR: Firestore document does not exists. This message is showing ]');
        }
      } else {
        setState(() {
          attempt = attempt + 1;
        });
        ShowLoading().close(
          context: context,
          key: _keyLoader,
        );
        ShowSnackbar().open(
            label: 'Login Failed ! Please enter correct credentials',
            context: context,
            scaffoldKey: _scaffoldKey,
            time: 3,
            status: 1);
        if (attempt > 3) {
          await session.createalert(
              alertmsgforuser: null,
              context: context,
              alertcollection: DbPaths.collectionTXNHIGHalerts,
              alerttime: DateTime.now(),
              alerttitle: 'Admin Credentials Incorrect',
              alertdesc:
                  'More than 3 attempts to login admin app has been made \n[CAPTURED ERROR: Incorrect admin credentials]');
        }
      }
    }).catchError((err) async {
      ShowLoading().close(
        context: context,
        key: _keyLoader,
      );
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
          alerttitle: 'Admin Credentials match failed',
          alertdesc:
              'Error occured while matching admin entered login credentials in admin app \n[CAPTURED ERROR: $err ]');
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading == true
        ? Splashscreen()
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: Mycolors.primary,
            body: isundermaintainance == true
                ? Center(
                    child: Padding(
                    padding: EdgeInsets.all(68.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.settings_applications,
                              size: 88, color: Colors.cyanAccent[400]),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'App Under Maintainance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.4,
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            errormsg!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.4,
                                fontSize: 17,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ))
                : iserror == true
                    ? Center(
                        child: Padding(
                        padding: EdgeInsets.all(68.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.error_outline,
                                  size: 88, color: Colors.pinkAccent[400]),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Cannot Load !',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.4,
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                errormsg!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.4,
                                    fontSize: 17,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ))
                    : 
                    loginWdget(context));
  }
}
