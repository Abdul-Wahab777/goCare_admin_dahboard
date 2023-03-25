import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Widgets/Buttons.dart';
import 'package:thinkcreative_technologies/Widgets/MySharedPrefs.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Widgets/launchurl.dart';

class ErrorScreen extends StatefulWidget {
  final String? reason;
  final String? uid;
  final String? message;
  final List? devicelisttrimmed;
  final Map? messagemap;
  final Map? correctinfomap;
  final bool? isupdatemandatory;
  final String? newappversion;
  final String? newapplink;
  ErrorScreen(
      {this.reason,
      this.uid,
      this.message,
      this.correctinfomap,
      this.devicelisttrimmed,
      this.messagemap,
      this.newapplink,
      this.newappversion,
      this.isupdatemandatory});
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  GlobalKey<State> _keyLoader =
      new GlobalKey<State>(debugLabel: 'qqqeqeqsssseqeqe');

  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_dsdssssfsaasfs');

  Future<void> _signOut(BuildContext context) async {
    // final user = Provider.of<CurrentUserProvider>(context, listen: false);
    // try {
    //   final AuthService auth = Provider.of<AuthService>(context, listen: false);
    //   await auth.signOut().then((value) {
    //     user.logoutUser();
    //     print('USER MAP AFTER LOGOUT : ${user.docmap}');
    //   });
    // } on PlatformException catch (e) {
    //   await PlatformExceptionAlertDialog(
    //     title: Strings.logoutFailed,
    //     exception: e,
    //   ).show(context);
    // }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    _signOut(context);
  }

  //----- Double tap to go back -----
  DateTime? currentBackPressTime;
  Future<bool> onWillPopNEw() {
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
//----- -------------------- -----

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPopNEw,
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: ListView(children: [
            SizedBox(
              height: widget.reason == Dbkeys.errorREASONuserblocked ||
                      widget.reason == Dbkeys.errorREASONdeviceisemulator ||
                      widget.reason == Dbkeys.errorREASONissinglgeloginonly ||
                      widget.reason == Dbkeys.errorREASONuserpending
                  ? ((h / 4) - 79)
                  : ((h / 4) - 39),
            ),
            Center(
              child: Icon(
                widget.reason == Dbkeys.errorREASONupdaterequired
                    ? Icons.mobile_friendly_rounded
                    : widget.reason == Dbkeys.errorREASONissinglgeloginonly
                        ? Icons.login_rounded
                        : widget.reason == Dbkeys.errorREASONundermaintainance
                            ? Icons.settings_applications
                            : widget.reason == Dbkeys.errorREASONuserblocked
                                ? Icons.remove_circle_outline_sharp
                                : widget.reason == Dbkeys.errorREASONuserpending
                                    ? Icons.supervised_user_circle_rounded
                                    : widget.reason == Dbkeys.errorREASONerror
                                        ? Icons.error_outline_rounded
                                        : Icons.add_alert_rounded,
                size: 150,
                color: widget.reason == Dbkeys.errorREASONupdaterequired
                    ? Colors.cyan[500]
                    : widget.reason == Dbkeys.errorREASONissinglgeloginonly
                        ? Colors.purple[500]
                        : widget.reason == Dbkeys.errorREASONundermaintainance
                            ? Colors.orange[400]
                            : widget.reason == Dbkeys.errorREASONuserblocked
                                ? Colors.red[400]
                                : widget.reason == Dbkeys.errorREASONuserpending
                                    ? Colors.blue[400]
                                    : widget.reason == Dbkeys.errorREASONerror
                                        ? Colors.red[700]
                                        : Colors.red[400],
              ),
            ),
            SizedBox(
              height: (h / 10),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Center(
                  child: MtCustomfontBold(
                fontsize: 20,
                textalign: TextAlign.center,
                text: widget.reason == Dbkeys.errorREASONupdaterequired
                    ? 'App Update Available '
                    : widget.reason == Dbkeys.errorREASONissinglgeloginonly
                        ? 'Multiple Device Detected'
                        : widget.reason == Dbkeys.errorREASONundermaintainance
                            ? 'App Under Maintainance'
                            : widget.reason == Dbkeys.errorREASONuserblocked
                                ? 'Account Blocked'
                                : widget.reason == Dbkeys.errorREASONuserpending
                                    ? 'Activation Pending'
                                    : widget.reason == Dbkeys.errorREASONerror
                                        ? 'Error !'
                                        : widget.reason ==
                                                Dbkeys
                                                    .errorREASONdeviceisemulator
                                            ? 'Cannot Run on Emulator'
                                            : 'Error Occured !',
              )),
            ),
            widget.reason == Dbkeys.errorREASONupdaterequired
                ? Padding(
                    padding: EdgeInsets.fromLTRB(15, 9, 15, 4),
                    child: Center(
                        child: MtCustomfontRegular(
                      color: Mycolors.greytext,
                      fontsize: 16,
                      textalign: TextAlign.center,
                      text: 'Version: ${widget.newappversion}',
                    )),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONissinglgeloginonly
                ? Padding(
                    padding: EdgeInsets.fromLTRB(15, 9, 15, 4),
                    child: Center(
                        child: MtCustomfontRegular(
                      color: Mycolors.greytext,
                      fontsize: 16,
                      textalign: TextAlign.center,
                      text:
                          'Old device -   ${widget.messagemap![Dbkeys.deviceInfoMANUFACTURER]} ${widget.messagemap![Dbkeys.deviceInfoMODEL]}',
                    )),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONissinglgeloginonly
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                        child: MtCustomfontRegular(
                      textalign: TextAlign.center,
                      lineheight: 1.2,
                      color: Mycolors.grey,
                      fontsize: 15,
                      text: widget.message ?? '',
                    )),
                  ),
            widget.reason == Dbkeys.errorREASONissinglgeloginonly
                ? Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                        child: MtCustomfontRegular(
                      textalign: TextAlign.center,
                      lineheight: 1.2,
                      color: Mycolors.grey,
                      fontsize: 15,
                      text:
                          'As this account is operated from another device. You can only use a single device at once. If you continue using this device, other device will be automatically logout.',
                    )),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONdeviceisemulator
                ? Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                        child: MtCustomfontRegular(
                      textalign: TextAlign.center,
                      lineheight: 1.2,
                      color: Mycolors.grey,
                      fontsize: 15,
                      text: 'Please use a real device to access the app.',
                    )),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONupdaterequired
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20, h / 30, 20, 10),
                    child: MySimpleButton(
                      buttontext: 'UPDATE APP',
                      onpressed: () async {
                        await launchURL(widget.newapplink!);
                      },
                    ),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONupdaterequired &&
                    widget.isupdatemandatory == false
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: MySimpleButton(
                      buttoncolor: Mycolors.greylightcolor,
                      buttontextcolor: Mycolors.grey,
                      buttontext: 'NOT NOW',
                      onpressed: () async {
                        await MySharedPrefs().setmyString(
                            Dbkeys.sharedPREFisUpdateappSkipped,
                            'true${widget.uid}');
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(builder: (context) => UsersApp()),
                        //     (Route<dynamic> route) => false);
                      },
                    ),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONuserblocked ||
                    widget.reason == Dbkeys.errorREASONuserpending
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20, h / 30, 20, 4),
                    child: MySimpleButton(
                      buttontext: 'MANAGE PROFILE',
                      onpressed: () {
                        // pageNavigator(context, Account());
                      },
                    ),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONuserblocked ||
                    widget.reason == Dbkeys.errorREASONuserpending
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20, 27, 20, 10),
                    child: MySimpleButton(
                      buttoncolor: Mycolors.greylightcolor,
                      buttontextcolor: Mycolors.grey,
                      buttontext: 'LOGOUT',
                      onpressed: () {
                        _confirmSignOut(context);
                      },
                    ),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONissinglgeloginonly
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20, h / 30, 20, 4),
                    child: MySimpleButton(
                      buttontext: 'USE THIS DEVICE',
                      onpressed: () async {
                        Map m = widget.correctinfomap!;
                        List? newlist;
                        m[Dbkeys.deviceInfoLOGINTIMESTAMP] = DateTime.now();
                        setState(() {});
                        if (widget.devicelisttrimmed!.length > 0) {
                          newlist = widget.devicelisttrimmed;
                          newlist!.insert(widget.devicelisttrimmed!.length, m);
                          setState(() {});
                        }

                        ShowLoading().open(key: _keyLoader, context: context);
                        await FirebaseFirestore.instance
                            .collection(AppConstants.apptype == Dbkeys.userapp
                                ? Dbkeys.users
                                : AppConstants.apptype == Dbkeys.staffapp
                                    ? Dbkeys.staffs
                                    : AppConstants.apptype == Dbkeys.partnerapp
                                        ? Dbkeys.partners
                                        : Dbkeys.admin)
                            .doc(widget.uid.toString())
                            .update(widget.devicelisttrimmed!.length > 0
                                ? {
                                    Dbkeys.uSERdevicelist: newlist,
                                    Dbkeys.uSERlastlogin: DateTime.now(),
                                  }
                                : {
                                    Dbkeys.uSERdevicelist:
                                        FieldValue.arrayUnion([m]),
                                    Dbkeys.uSERlastlogin: DateTime.now(),
                                  })
                            .then((value) async {
                          ShowLoading()
                              .close(key: _keyLoader, context: context);
                          // pageNavigator(context, UsersApp());
                        });
                      },
                    ),
                  )
                : SizedBox(),
            widget.reason == Dbkeys.errorREASONissinglgeloginonly
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20, 9, 20, 10),
                    child: MySimpleButton(
                      buttoncolor: Mycolors.greylightcolor,
                      buttontextcolor: Mycolors.grey,
                      buttontext: 'NOT THIS DEVICE',
                      onpressed: () {
                        _confirmSignOut(context);
                      },
                    ),
                  )
                : SizedBox(),
          ])),
    );
  }
}
