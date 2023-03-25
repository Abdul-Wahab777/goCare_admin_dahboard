import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseUploader.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Widgets/InputBox.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/FormDialog.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/loadingDialog.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Widgets/DelayedFunction.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Widgets/eachtile.dart';
import 'package:thinkcreative_technologies/Widgets/hideKeyboard.dart';

class UserAppSettings extends StatefulWidget {
  final String? pagetype;
  UserAppSettings({this.pagetype});
  @override
  _UserAppSettingsState createState() => _UserAppSettingsState();
}

class _UserAppSettingsState extends State<UserAppSettings> {
//----- App basic Settings fields ----
  bool? isapprovalneeded = false;
  bool? ismaintainncemodeandroid = false;
  bool? ismaintainncemodeios = false;
  bool? isblocknewlogins = false;
  bool? isshowerrorlog = false;
  String? maintainancemessage;
  String? accountapprovalmessage;
  String? latestappversionandroid;
  String? appupdatelinkandroid;
  String? latestappversionios;
  String? appupdatelinkios;
  bool? isemulatorallowed = false;

//-----App Controls fields-------------------
  bool? iscallsallowed = false;
  bool? isadmobshow = false;
  bool? ismediamessageallowed = false;
  bool? istextmessageallowed = false;
  bool isloading = true;
//--
  bool? isCallFeatureTotallyHide = false;
  bool? is24hrsTimeformat = true;
  bool? isPercentProgressShowWhileUploading = true;
  bool? isAllowCreatingGroups = true;
  bool? isAllowCreatingBroadcasts = true;
  bool? isAllowCreatingStatus = true;
  bool? isLogoutButtonShowInSettingsPage = true;
  int? maxFileSizeAllowedInMB;
  int? groupMemberslimit;
  int? broadcastMemberslimit;
  int? statusDeleteAfterInHours;
  String? feedbackEmail = '';

  int? maxNoOfFilesInMultiSharing;
  int? maxNoOfContactsSelectForForward;
  bool? isCustomAppShareLink = false;
  String? appShareMessageStringAndroid = '';
  String? appShareMessageStringiOS = '';

//-----TnC & Privacy Policy Settings fields-------------------
  String? privacypolicyTYPE;
  String? privacypolicy;
  String? privacypolicyfilename;
  String? tncTYPE;
  String? tnc;
  String? tncfilename;

  TextEditingController _controller = new TextEditingController();
  final GlobalKey<State> _keyLoader =
      new GlobalKey<State>(debugLabel: '272hu1');
  final GlobalKey<State> _keyLoader2 =
      new GlobalKey<State>(debugLabel: '272hu2');
  final GlobalKey<State> _keyLoader3 =
      new GlobalKey<State>(debugLabel: '272hu3');
  final GlobalKey<State> _keyLoader4 =
      new GlobalKey<State>(debugLabel: '272hu4');
  final GlobalKey<State> _keyLoader5 =
      new GlobalKey<State>(debugLabel: '272hu5');

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  fetchdata() async {
    await FirebaseFirestore.instance
        .collection(Dbkeys.appsettings)
        .doc(Dbkeys.userapp)
        .get()
        .then((dc) async {
      if (widget.pagetype == Dbkeys.userapp) {
        setState(() {
          isemulatorallowed = dc[Dbkeys.isemulatorallowed];
          isapprovalneeded = dc[Dbkeys.isaccountapprovalbyadminneeded];
          ismaintainncemodeandroid = dc[Dbkeys.isappunderconstructionandroid];
          ismaintainncemodeios = dc[Dbkeys.isappunderconstructionios];
          isblocknewlogins = dc[Dbkeys.isblocknewlogins];
          isshowerrorlog = dc[Dbkeys.isshowerrorlog];
          accountapprovalmessage = dc[Dbkeys.accountapprovalmessage];
          maintainancemessage = dc[Dbkeys.maintainancemessage];
          latestappversionandroid = dc[Dbkeys.latestappversionandroid];
          appupdatelinkandroid = dc[Dbkeys.newapplinkandroid];
          latestappversionios = dc[Dbkeys.latestappversionios];
          appupdatelinkios = dc[Dbkeys.newapplinkios];
          isloading = false;
        });
      } else if (widget.pagetype == 'controls') {
        setState(() {
          iscallsallowed = dc[Dbkeys.iscallsallowed];
          isadmobshow = dc[Dbkeys.isadmobshow];
          ismediamessageallowed = dc[Dbkeys.ismediamessageallowed];
          istextmessageallowed = dc[Dbkeys.istextmessageallowed];

          isCallFeatureTotallyHide = dc[Dbkeys.isCallFeatureTotallyHide];
          is24hrsTimeformat = dc[Dbkeys.is24hrsTimeformat];
          isPercentProgressShowWhileUploading =
              dc[Dbkeys.isPercentProgressShowWhileUploading];
          isAllowCreatingGroups = dc[Dbkeys.isAllowCreatingGroups];
          isAllowCreatingBroadcasts = dc[Dbkeys.isAllowCreatingBroadcasts];
          isAllowCreatingStatus = dc[Dbkeys.isAllowCreatingStatus];
          isLogoutButtonShowInSettingsPage =
              dc[Dbkeys.isLogoutButtonShowInSettingsPage];
          maxFileSizeAllowedInMB = dc[Dbkeys.maxFileSizeAllowedInMB];
          groupMemberslimit = dc[Dbkeys.groupMemberslimit];
          broadcastMemberslimit = dc[Dbkeys.broadcastMemberslimit];
          statusDeleteAfterInHours = dc[Dbkeys.statusDeleteAfterInHours];
          maxNoOfContactsSelectForForward =
              dc[Dbkeys.maxNoOfContactsSelectForForward];
          maxNoOfFilesInMultiSharing = dc[Dbkeys.maxNoOfFilesInMultiSharing];
          appShareMessageStringAndroid =
              dc[Dbkeys.appShareMessageStringAndroid];
          appShareMessageStringiOS = dc[Dbkeys.appShareMessageStringiOS];
          isCustomAppShareLink = dc[Dbkeys.isCustomAppShareLink];
          feedbackEmail = dc[Dbkeys.feedbackEmail];
          isloading = false;
        });
      } else if (widget.pagetype == Dbkeys.tnc) {
        setState(() {
          privacypolicyTYPE = dc[Dbkeys.privacypolicyTYPE];
          privacypolicy = dc[Dbkeys.privacypolicy];
          tncTYPE = dc[Dbkeys.tncTYPE];
          tnc = dc[Dbkeys.tnc];
          isloading = false;
        });
      }
    });
  }

  confirmchangeswitch(
      {required BuildContext context,
      bool? currentlbool,
      String? toONmessage,
      String? toOFFmessage,
      Map<String, dynamic>? map,
      Function? setstateMap}) {
    ShowConfirmDialog().open(
        context: context,
        subtitle: currentlbool == false
            ? toONmessage ?? 'Are you sure you want to make this switch ON.'
            : toOFFmessage ?? 'Are you sure you want to make this switch OFF.',
        title: 'Alert !',
        rightbtnonpress: () async {
          final session = Provider.of<CommonSession>(context, listen: false);
          Navigator.pop(context);
          ShowLoading().open(context: context, key: _keyLoader);
          await FirebaseFirestore.instance
              .collection(Dbkeys.appsettings)
              .doc(Dbkeys.userapp)
              .update(map!)
              .then((value) async {
            ShowLoading().close(context: context, key: _keyLoader);
            setState(setstateMap as void Function());

            ShowSnackbar().open(
                context: context,
                scaffoldKey: _scaffoldKey,
                status: 2,
                time: 2,
                label:
                    'SUCCESS!  Value updated succesfully. Restart User app to see the change.');
            session.setUserAppSettingFromFirestore();
          }).catchError((error) {
            ShowLoading().close(context: context, key: _keyLoader);
            print('Error: $error');
            ShowSnackbar().open(
                context: context,
                scaffoldKey: _scaffoldKey,
                status: 1,
                time: 3,
                label: 'ERROR OCCURED: $error \nPlease try again !');
          });
        });
  }

  fieldupdate(
      {required BuildContext context,
      required Map<String, dynamic> map,
      Function? setstateMap}) async {
    // setState(() {
    //   widget.cpnisvisible = !widget.cpnisvisible;
    // });
    final session = Provider.of<CommonSession>(context, listen: false);
    Navigator.pop(context);
    ShowLoading().open(context: context, key: _keyLoader);
    await FirebaseFirestore.instance
        .collection(Dbkeys.appsettings)
        .doc(Dbkeys.userapp)
        .update(map)
        .then((value) async {
      ShowLoading().close(context: context, key: _keyLoader);
      setState(setstateMap as void Function());
      _controller.clear();
      ShowSnackbar().open(
          context: context,
          scaffoldKey: _scaffoldKey,
          status: 2,
          time: 2,
          label: 'SUCCESS!  Value updated succesfully.');
      session.setUserAppSettingFromFirestore();
    }).catchError((error) {
      ShowLoading().close(context: context, key: _keyLoader);
      print('Error: $error');
      ShowSnackbar().open(
          context: context,
          scaffoldKey: _scaffoldKey,
          status: 1,
          time: 3,
          label: 'ERROR OCCURED: $error \nPlease try again !');
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MyScaffold(
        scaffoldkey: _scaffoldKey,
        titlespacing: 18,
        title: widget.pagetype == Dbkeys.userapp
            ? 'User app Settings'
            : widget.pagetype == Dbkeys.staffapp
                ? 'Staff app Settings'
                : widget.pagetype == Dbkeys.partnerapp
                    ? 'Partner app Settings'
                    : widget.pagetype == 'controls'
                        ? 'Usage Controls'
                        : 'Settings',
        body: isloading == true
            ? circularProgress()

// ignore: todo
//TODO:----------- App Basic Settings ------

            : widget.pagetype == Dbkeys.userapp
                ? ListView(padding: EdgeInsets.only(top: 4), children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
                      child: Text(
                        'VERSION CONTROL',
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.9,
                            color: Mycolors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    //* ----Android app version control --------
                    profileTile(
                        margin: 5,
                        iconsize: 30,
                        trailingicondata: Icons.edit_outlined,
                        title: 'Android Latest Version',
                        subtitle: latestappversionandroid ?? '0.0.0',
                        leadingicondata: Icons.settings_applications_rounded,
                        ontap: () {
                          _controller.text = latestappversionandroid!;
                          ShowFormDialog().open(
                              inputFormatter: [
                                // LengthLimitingTextInputFormatter(AppSettings.maxcoupondigits),
                                FilteringTextInputFormatter.allow(
                                    // RegExp("[0-9a-zA-Z,.-_]")),

                                    RegExp(r"[\d.]")) //-- Only Number &dot
                                // RegExp("[0-9A-Z]")//-- Only Number & Aplhabets
                                // ), //-- Only Number & Aplhabets
                              ],
                              iscapital: false,
                              controller: _controller,
                              maxlength: 8,
                              // maxlines: 4,
                              // minlines: 2,
                              iscentrealign: true,
                              context: context,
                              title: 'Android Latest version',
                              subtitle: 'Format should be strictly X.X.X',
                              onpressed: AppConstants.isdemomode == true
                                  ? () {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : () async {
                                      if (_controller.text.trim().length < 5) {
                                        ShowSnackbar().open(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            time: 3,
                                            label:
                                                'Please enter a valid version number (X.X.X)');
                                        delayedFunction(setstatefn: () {
                                          ShowSnackbar().close(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                          );
                                        });
                                      } else {
                                        await fieldupdate(
                                            context: context,
                                            map: {
                                              Dbkeys.latestappversionandroid:
                                                  _controller.text.trim()
                                            },
                                            setstateMap: () {
                                              latestappversionandroid =
                                                  _controller.text.trim();
                                            });
                                      }
                                    },
                              buttontext: 'UPDATE',
                              hinttext: 'Enter App Version (X.X.X)');
                        }),

                    profileTile(
                        isthreelines: true,
                        margin: 5,
                        iconsize: 30,
                        trailingicondata: Icons.edit_outlined,
                        title: 'Android Update Link',
                        subtitle:
                            appupdatelinkandroid ?? 'URL of new android app',
                        leadingicondata: Icons.settings_applications_rounded,
                        ontap: () {
                          _controller.text = appupdatelinkandroid!;
                          ShowFormDialog().open(
                              inputFormatter: [
                                // LengthLimitingTextInputFormatter(AppSettings.maxcoupondigits),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9a-zA-Z,.-_]")),

                                // RegExp(r"[\d.]")//-- Only Number &dot
                                // RegExp("[0-9A-Z]")//-- Only Number & Aplhabets
                                // ), //-- Only Number & Aplhabets
                              ],
                              iscapital: false,
                              controller: _controller,
                              maxlength: 500,
                              maxlines: 4,
                              minlines: 2,
                              iscentrealign: true,
                              context: context,
                              title: 'App Update Link',
                              onpressed: AppConstants.isdemomode == true
                                  ? () {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : () async {
                                      if (_controller.text.trim().length < 2) {
                                        ShowSnackbar().open(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            time: 3,
                                            label: 'Please enter a valid URL');
                                        delayedFunction(setstatefn: () {
                                          ShowSnackbar().close(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                          );
                                        });
                                      } else {
                                        await fieldupdate(
                                            context: context,
                                            map: {
                                              Dbkeys.newapplinkandroid:
                                                  _controller.text.trim()
                                            },
                                            setstateMap: () {
                                              appupdatelinkandroid =
                                                  _controller.text.trim();
                                            });
                                      }
                                    },
                              buttontext: 'UPDATE',
                              hinttext: 'Enter URL');
                        }),

                    //* ----ios app version control --------
                    profileTile(
                        margin: 5,
                        iconsize: 30,
                        trailingicondata: Icons.edit_outlined,
                        title: 'iOS Latest Version',
                        subtitle: latestappversionios ?? '0.0.0',
                        leadingicondata: Icons.settings_applications_rounded,
                        ontap: () {
                          _controller.text = latestappversionios!;
                          ShowFormDialog().open(
                              inputFormatter: [
                                // LengthLimitingTextInputFormatter(AppSettings.maxcoupondigits),
                                FilteringTextInputFormatter.allow(
                                    // RegExp("[0-9a-zA-Z,.-_]")),

                                    RegExp(r"[\d.]")) //-- Only Number &dot
                                // RegExp("[0-9A-Z]")//-- Only Number & Aplhabets
                                // ), //-- Only Number & Aplhabets
                              ],
                              iscapital: false,
                              controller: _controller,
                              maxlength: 8,
                              // maxlines: 4,
                              // minlines: 2,
                              iscentrealign: true,
                              context: context,
                              title: 'iOS Latest version',
                              subtitle: 'Format should be strictly X.X.X',
                              onpressed: AppConstants.isdemomode == true
                                  ? () {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : () async {
                                      if (_controller.text.trim().length < 5) {
                                        ShowSnackbar().open(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            time: 3,
                                            label:
                                                'Please enter a valid version number (X.X.X)');
                                        delayedFunction(setstatefn: () {
                                          ShowSnackbar().close(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                          );
                                        });
                                      } else {
                                        await fieldupdate(
                                            context: context,
                                            map: {
                                              Dbkeys.latestappversionios:
                                                  _controller.text.trim()
                                            },
                                            setstateMap: () {
                                              latestappversionios =
                                                  _controller.text.trim();
                                            });
                                      }
                                    },
                              buttontext: 'UPDATE',
                              hinttext: 'Enter App Version (X.X.X)');
                        }),

                    profileTile(
                        isthreelines: true,
                        margin: 5,
                        iconsize: 30,
                        trailingicondata: Icons.edit_outlined,
                        title: 'iOS Update Link',
                        subtitle: appupdatelinkios ?? 'URL of new ios app',
                        leadingicondata: Icons.settings_applications_rounded,
                        ontap: () {
                          _controller.text = appupdatelinkios!;
                          ShowFormDialog().open(
                              inputFormatter: [
                                // LengthLimitingTextInputFormatter(AppSettings.maxcoupondigits),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9a-zA-Z,.-_]")),

                                // RegExp(r"[\d.]")//-- Only Number &dot
                                // RegExp("[0-9A-Z]")//-- Only Number & Aplhabets
                                // ), //-- Only Number & Aplhabets
                              ],
                              iscapital: false,
                              controller: _controller,
                              maxlength: 500,
                              maxlines: 4,
                              minlines: 2,
                              iscentrealign: true,
                              context: context,
                              title: 'App Update Link',
                              onpressed: AppConstants.isdemomode == true
                                  ? () {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : () async {
                                      if (_controller.text.trim().length < 2) {
                                        ShowSnackbar().open(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            time: 3,
                                            label: 'Please enter a valid URL');
                                        delayedFunction(setstatefn: () {
                                          ShowSnackbar().close(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                          );
                                        });
                                      } else {
                                        await fieldupdate(
                                            context: context,
                                            map: {
                                              Dbkeys.newapplinkios:
                                                  _controller.text.trim()
                                            },
                                            setstateMap: () {
                                              appupdatelinkios =
                                                  _controller.text.trim();
                                            });
                                      }
                                    },
                              buttontext: 'UPDATE',
                              hinttext: 'Enter URL');
                        }),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 39, 7, 5),
                      child: Text(
                        'LOGIN RULES',
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.9,
                            color: Mycolors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ),

                    // profileTile(
                    //     isthreelines: true,
                    //     margin: 5,
                    //     iconsize: 30,
                    //     trailingicondata: Icons.edit_outlined,
                    //     title: 'Privacy Policy URL',
                    //     subtitle: privacypolicy ?? 'URL of Privacy Policy',
                    //     leadingicondata: Icons.settings_applications_rounded,
                    //     ontap: () {
                    //       _controller.text = privacypolicy;
                    //       ShowFormDialog().open(
                    //           inputFormatter: [
                    //             // LengthLimitingTextInputFormatter(AppSettings.maxcoupondigits),
                    //             FilteringTextInputFormatter.allow(
                    //                 RegExp("[0-9a-zA-Z,.-_]")),

                    //             // RegExp(r"[\d.]")//-- Only Number &dot
                    //             // RegExp("[0-9A-Z]")//-- Only Number & Aplhabets
                    //             // ), //-- Only Number & Aplhabets
                    //           ],
                    //           iscapital: false,
                    //           controller: _controller,
                    //           maxlength: 100,
                    //           maxlines: 4,
                    //           minlines: 2,
                    //           iscentrealign: true,
                    //           context: context,
                    //           title: 'Privacy Policy URL',
                    //           onpressed: () async {
                    //             if (_controller.text.trim().length < 2) {
                    //               ShowSnackbar().open(
                    //                   context: context,
                    //                   scaffoldKey: _scaffoldKey,
                    //                   time: 3,
                    //                   label: 'Please enter a valid URL');
                    //               delayedFunction(setstatefn: () {
                    //                 ShowSnackbar().close(
                    //                   context: context,
                    //                   scaffoldKey: _scaffoldKey,
                    //                 );
                    //               });
                    //             } else {
                    //               await fieldupdate(
                    //                   context: context,
                    //                   map: {
                    //                     Dbkeys.privacypolicy: _controller.text.trim()
                    //                   },
                    //                   setstateMap: () {
                    //                     privacypolicy = _controller.text.trim();
                    //                   });
                    //             }
                    //           },
                    //           buttontext: 'UPDATE',
                    //           hinttext: 'Enter URL');
                    //     }),

                    profileTile(
                        margin: 5,
                        iconsize: 30,
                        trailingWidget: Container(
                          margin: EdgeInsets.only(right: 3, top: 5),
                          width: 50,
                          height: 19,
                          child: FlutterSwitch(
                              activeText: '',
                              inactiveText: '',
                              width: 46.0,
                              activeColor: Mycolors.green.withOpacity(0.85),
                              inactiveColor: Mycolors.grey,
                              height: 19.0,
                              valueFontSize: 12.0,
                              toggleSize: 15.0,
                              value: isapprovalneeded ?? false,
                              borderRadius: 25.0,
                              padding: 3.0,
                              showOnOff: true,
                              onToggle: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      await confirmchangeswitch(
                                          context: context,
                                          currentlbool: isapprovalneeded,
                                          setstateMap: () {
                                            isapprovalneeded =
                                                !isapprovalneeded!;
                                          },
                                          map: {
                                            Dbkeys.isaccountapprovalbyadminneeded:
                                                !isapprovalneeded!,
                                          });
                                    }),
                        ),
                        title: 'Approval Needed',
                        isthreelines: true,
                        subtitle:
                            'Is approval by admin needed for new account?',
                        leadingicondata: Icons.settings_applications_rounded),
                    profileTile(
                        isthreelines: true,
                        margin: 5,
                        iconsize: 30,
                        trailingicondata: Icons.edit_outlined,
                        title: 'Approval message',
                        subtitle: accountapprovalmessage ??
                            'Message for user while waiting for approval',
                        leadingicondata: Icons.settings_applications_rounded,
                        ontap: () {
                          _controller.text = accountapprovalmessage!;
                          ShowFormDialog().open(
                              inputFormatter: [
                                // LengthLimitingTextInputFormatter(AppSettings.maxcoupondigits),
                                // FilteringTextInputFormatter.allow(
                                // RegExp("[0-9a-zA-Z,.-_]")),

                                // RegExp(r"[\d.]")//-- Only Number &dot
                                // RegExp("[0-9A-Z]")//-- Only Number & Aplhabets
                                // ), //-- Only Number & Aplhabets
                              ],
                              iscapital: false,
                              controller: _controller,
                              maxlength: 200,
                              maxlines: 5,
                              minlines: 4,
                              iscentrealign: true,
                              context: context,
                              title: 'Approval waiting message',
                              onpressed: AppConstants.isdemomode == true
                                  ? () {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : () async {
                                      if (_controller.text.trim().length < 5) {
                                        ShowSnackbar().open(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            time: 3,
                                            label:
                                                'Please enter a valid approval message');
                                        delayedFunction(setstatefn: () {
                                          ShowSnackbar().close(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                          );
                                        });
                                      } else {
                                        await fieldupdate(
                                            context: context,
                                            map: {
                                              Dbkeys.accountapprovalmessage:
                                                  _controller.text.trim()
                                            },
                                            setstateMap: () {
                                              accountapprovalmessage =
                                                  _controller.text.trim();
                                            });
                                      }
                                    },
                              buttontext: 'UPDATE',
                              hinttext: 'Enter Message');
                        }),
                    // profileTile(
                    //     margin: 5,
                    //     iconsize: 30,
                    //     trailingWidget: Container(
                    //       margin: EdgeInsets.only(right: 3, top: 5),
                    //       width: 50,
                    //       height: 19,
                    //       child: FlutterSwitch(
                    //           activeText: '',
                    //           inactiveText: '',
                    //           width: 35.0,
                    //           activeColor: Mycolors.green.withOpacity(0.85),
                    //           inactiveColor: Mycolors.grey,
                    //           height: 19.0,
                    //           valueFontSize: 12.0,
                    //           toggleSize: 15.0,
                    //           value: isgeolocationprefered ?? false,
                    //           borderRadius: 25.0,
                    //           padding: 3.0,
                    //           showOnOff: true,
                    //           onToggle: (val) async {
                    //             await confirmchangeswitch(
                    //                 context: context,
                    //                 currentlbool: isgeolocationprefered,
                    //                 setstateMap: () {
                    //                   isgeolocationprefered = !isgeolocationprefered;
                    //                 },
                    //                 map: {
                    //                   Dbkeys.isgeolocationprefered:
                    //                       !isgeolocationprefered,
                    //                 });
                    //           }),
                    //     ),
                    //     title: 'Geolocation Preffered',
                    //     isthreelines: true,
                    //     subtitle:
                    //         'User can Allow/Deny to detect geolocation when prompted.',
                    //     leadingicondata: Icons.settings_applications_rounded),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 39, 7, 5),
                      child: Text(
                        'USAGE RULES',
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.9,
                            color: Mycolors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    profileTile(
                        margin: 5,
                        iconsize: 30,
                        trailingWidget: Container(
                          margin: EdgeInsets.only(right: 3, top: 5),
                          width: 50,
                          height: 19,
                          child: FlutterSwitch(
                              activeText: '',
                              inactiveText: '',
                              width: 46.0,
                              activeColor: Mycolors.green.withOpacity(0.85),
                              inactiveColor: Mycolors.grey,
                              height: 19.0,
                              valueFontSize: 12.0,
                              toggleSize: 15.0,
                              value: isemulatorallowed ?? false,
                              borderRadius: 25.0,
                              padding: 3.0,
                              showOnOff: true,
                              onToggle: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      await confirmchangeswitch(
                                          context: context,
                                          currentlbool: isemulatorallowed,
                                          setstateMap: () {
                                            isemulatorallowed =
                                                !isemulatorallowed!;
                                          },
                                          map: {
                                            Dbkeys.isemulatorallowed:
                                                !isemulatorallowed!,
                                          });
                                    }),
                        ),
                        title: 'Allow emulators',
                        isthreelines: true,
                        subtitle:
                            'Users can use Emulator/ Stimulator to access the app',
                        leadingicondata: Icons.settings_applications_rounded),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 39, 7, 5),
                      child: Text(
                        'MAINTENANCE',
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.9,
                            color: Mycolors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ),

                    profileTile(
                        margin: 5,
                        iconsize: 30,
                        trailingWidget: Container(
                          margin: EdgeInsets.only(right: 3, top: 5),
                          width: 50,
                          height: 19,
                          child: FlutterSwitch(
                              activeText: '',
                              inactiveText: '',
                              width: 46.0,
                              activeColor: Mycolors.green.withOpacity(0.85),
                              inactiveColor: Mycolors.grey,
                              height: 19.0,
                              valueFontSize: 12.0,
                              toggleSize: 15.0,
                              value: ismaintainncemodeandroid ?? false,
                              borderRadius: 25.0,
                              padding: 3.0,
                              showOnOff: true,
                              onToggle: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      await confirmchangeswitch(
                                          context: context,
                                          currentlbool:
                                              ismaintainncemodeandroid,
                                          setstateMap: () {
                                            ismaintainncemodeandroid =
                                                !ismaintainncemodeandroid!;
                                          },
                                          map: {
                                            Dbkeys.isappunderconstructionandroid:
                                                !ismaintainncemodeandroid!,
                                          });
                                    }),
                        ),
                        title: 'Android Maintenance Mode',
                        isthreelines: true,
                        subtitle:
                            'All logins/sessions will be blocked with a message',
                        leadingicondata: Icons.settings_applications_rounded),
                    profileTile(
                        margin: 5,
                        iconsize: 30,
                        trailingWidget: Container(
                          margin: EdgeInsets.only(right: 3, top: 5),
                          width: 50,
                          height: 19,
                          child: FlutterSwitch(
                              activeText: '',
                              inactiveText: '',
                              width: 46.0,
                              activeColor: Mycolors.green.withOpacity(0.85),
                              inactiveColor: Mycolors.grey,
                              height: 19.0,
                              valueFontSize: 12.0,
                              toggleSize: 15.0,
                              value: ismaintainncemodeios ?? false,
                              borderRadius: 25.0,
                              padding: 3.0,
                              showOnOff: true,
                              onToggle: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      await confirmchangeswitch(
                                          context: context,
                                          currentlbool: ismaintainncemodeios,
                                          setstateMap: () {
                                            ismaintainncemodeios =
                                                !ismaintainncemodeios!;
                                          },
                                          map: {
                                            Dbkeys.isappunderconstructionios:
                                                !ismaintainncemodeios!,
                                          });
                                    }),
                        ),
                        title: 'iOS Maintenance Mode',
                        isthreelines: true,
                        subtitle:
                            'All logins/sessions will be blocked with a message',
                        leadingicondata: Icons.settings_applications_rounded),

                    profileTile(
                        isthreelines: true,
                        margin: 5,
                        iconsize: 30,
                        trailingicondata: Icons.edit_outlined,
                        title: 'Maintenance message',
                        subtitle: maintainancemessage ??
                            'Write the message to be displayed to User',
                        leadingicondata: Icons.settings_applications_rounded,
                        ontap: () {
                          _controller.text = maintainancemessage!;
                          ShowFormDialog().open(
                              inputFormatter: [
                                // LengthLimitingTextInputFormatter(AppSettings.maxcoupondigits),
                                // FilteringTextInputFormatter.allow(
                                // RegExp("[0-9a-zA-Z,.-_]")),

                                // RegExp(r"[\d.]")//-- Only Number &dot
                                // RegExp("[0-9A-Z]")//-- Only Number & Aplhabets
                                // ), //-- Only Number & Aplhabets
                              ],
                              iscapital: false,
                              controller: _controller,
                              maxlength: 200,
                              maxlines: 5,
                              minlines: 4,
                              iscentrealign: true,
                              context: context,
                              title: 'Maintenance message',
                              onpressed: AppConstants.isdemomode == true
                                  ? () {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : () async {
                                      if (_controller.text.trim().length < 5) {
                                        ShowSnackbar().open(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            time: 3,
                                            label:
                                                'Please enter a valid Maintenance message');
                                        delayedFunction(setstatefn: () {
                                          ShowSnackbar().close(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                          );
                                        });
                                      } else {
                                        await fieldupdate(
                                            context: context,
                                            map: {
                                              Dbkeys.maintainancemessage:
                                                  _controller.text.trim()
                                            },
                                            setstateMap: () {
                                              maintainancemessage =
                                                  _controller.text.trim();
                                            });
                                      }
                                    },
                              buttontext: 'UPDATE',
                              hinttext: 'Enter Message');
                        }),

                    profileTile(
                        margin: 5,
                        iconsize: 30,
                        trailingWidget: Container(
                          margin: EdgeInsets.only(right: 3, top: 5),
                          width: 50,
                          height: 19,
                          child: FlutterSwitch(
                              activeText: '',
                              inactiveText: '',
                              width: 46.0,
                              activeColor: Mycolors.green.withOpacity(0.85),
                              inactiveColor: Mycolors.grey,
                              height: 19.0,
                              valueFontSize: 12.0,
                              toggleSize: 15.0,
                              value: isblocknewlogins ?? false,
                              borderRadius: 25.0,
                              padding: 3.0,
                              showOnOff: true,
                              onToggle: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      await confirmchangeswitch(
                                          context: context,
                                          currentlbool: isblocknewlogins,
                                          setstateMap: () {
                                            isblocknewlogins =
                                                !isblocknewlogins!;
                                          },
                                          map: {
                                            Dbkeys.isblocknewlogins:
                                                !isblocknewlogins!,
                                          });
                                    }),
                        ),
                        title: 'Block New Logins',
                        isthreelines: true,
                        subtitle:
                            'New Login/Signup will be blocked. However, already loggedIn user can use the app',
                        leadingicondata: Icons.settings_applications_rounded),

                    // profileTile(
                    //     margin: 5,
                    //     iconsize: 30,
                    //     trailingWidget: Container(
                    //       margin: EdgeInsets.only(right: 3, top: 5),
                    //       width: 50,
                    //       height: 19,
                    //       child: FlutterSwitch(
                    //           activeText: '',
                    //           inactiveText: '',
                    //           width: 35.0,
                    //           activeColor: Mycolors.green.withOpacity(0.85),
                    //           inactiveColor: Mycolors.grey,
                    //           height: 19.0,
                    //           valueFontSize: 12.0,
                    //           toggleSize: 15.0,
                    //           value: false,
                    //           borderRadius: 25.0,
                    //           padding: 3.0,
                    //           showOnOff: true,
                    //           onToggle: (val) {
                    //             // widget.onChanged(val);
                    //           }),
                    //     ),
                    //     title: 'Geolocation Mandatory',
                    //     isthreelines: true,
                    //     subtitle:
                    //         'User must have to Allow to detect geolocation when prompted.',
                    //     leadingicondata: Icons.settings_applications_rounded),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
                    //   child: Text(
                    //     'DEVELOPER SETTINGS',
                    //     style: TextStyle(
                    //         fontSize: 12,
                    //         letterSpacing: 0.9,
                    //         color: Mycolors.grey,
                    //         fontWeight: FontWeight.w700),
                    //   ),
                    // ),
                    profileTile(
                        margin: 5,
                        iconsize: 30,
                        trailingWidget: Container(
                          margin: EdgeInsets.only(right: 3, top: 5),
                          width: 50,
                          height: 19,
                          child: FlutterSwitch(
                              activeText: '',
                              inactiveText: '',
                              width: 46.0,
                              activeColor: Mycolors.green.withOpacity(0.85),
                              inactiveColor: Mycolors.grey,
                              height: 19.0,
                              valueFontSize: 12.0,
                              toggleSize: 15.0,
                              value: isshowerrorlog ?? false,
                              borderRadius: 25.0,
                              padding: 3.0,
                              showOnOff: true,
                              onToggle: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      await confirmchangeswitch(
                                          context: context,
                                          currentlbool: isshowerrorlog,
                                          setstateMap: () {
                                            isshowerrorlog = !isshowerrorlog!;
                                          },
                                          map: {
                                            Dbkeys.isshowerrorlog:
                                                !isshowerrorlog!,
                                          });
                                    }),
                        ),
                        title: 'Show Error Log',
                        isthreelines: true,
                        subtitle:
                            'Users can see the error log when an error occurs.',
                        leadingicondata: Icons.settings_applications_rounded),

                    SizedBox(height: 7)
                  ])
                : widget.pagetype == 'controls'
                    ? ListView(
                        children: [
// ignore: todo
//TODO:----   User app controls
                          isCallFeatureTotallyHide == true
                              ? SizedBox()
                              : profileTile(
                                  margin: 5,
                                  iconsize: 30,
                                  trailingWidget: Container(
                                    margin: EdgeInsets.only(right: 3, top: 5),
                                    width: 50,
                                    height: 19,
                                    child: FlutterSwitch(
                                        activeText: '',
                                        inactiveText: '',
                                        width: 46.0,
                                        activeColor:
                                            Mycolors.green.withOpacity(0.85),
                                        inactiveColor: Mycolors.grey,
                                        height: 19.0,
                                        valueFontSize: 12.0,
                                        toggleSize: 15.0,
                                        value: iscallsallowed ?? false,
                                        borderRadius: 25.0,
                                        padding: 3.0,
                                        showOnOff: true,
                                        onToggle:
                                            AppConstants.isdemomode == true
                                                ? (val) {
                                                    Utils.toast(
                                                        'Not Allowed in Demo App');
                                                  }
                                                : (val) async {
                                                    await confirmchangeswitch(
                                                        context: context,
                                                        currentlbool:
                                                            iscallsallowed,
                                                        setstateMap: () {
                                                          iscallsallowed =
                                                              !iscallsallowed!;
                                                        },
                                                        map: {
                                                          Dbkeys.iscallsallowed:
                                                              !iscallsallowed!,
                                                        });
                                                  }),
                                  ),
                                  title: 'Calls Allowed',
                                  isthreelines: true,
                                  subtitle: 'Users can make call if its true',
                                  leadingicondata:
                                      Icons.settings_applications_rounded),

                          iscallsallowed == true
                              ? SizedBox()
                              : profileTile(
                                  margin: 5,
                                  iconsize: 30,
                                  trailingWidget: Container(
                                    margin: EdgeInsets.only(right: 3, top: 5),
                                    width: 50,
                                    height: 19,
                                    child: FlutterSwitch(
                                        activeText: '',
                                        inactiveText: '',
                                        width: 46.0,
                                        activeColor:
                                            Mycolors.green.withOpacity(0.85),
                                        inactiveColor: Mycolors.grey,
                                        height: 19.0,
                                        valueFontSize: 12.0,
                                        toggleSize: 15.0,
                                        value:
                                            isCallFeatureTotallyHide ?? false,
                                        borderRadius: 25.0,
                                        padding: 3.0,
                                        showOnOff: true,
                                        onToggle:
                                            AppConstants.isdemomode == true
                                                ? (val) {
                                                    Utils.toast(
                                                        'Not Allowed in Demo App');
                                                  }
                                                : (val) async {
                                                    await confirmchangeswitch(
                                                        context: context,
                                                        currentlbool:
                                                            isCallFeatureTotallyHide,
                                                        setstateMap: () {
                                                          isCallFeatureTotallyHide =
                                                              !isCallFeatureTotallyHide!;
                                                        },
                                                        map: {
                                                          Dbkeys.isCallFeatureTotallyHide:
                                                              !isCallFeatureTotallyHide!,
                                                        });
                                                  }),
                                  ),
                                  title: 'Call Buttons Hide',
                                  isthreelines: true,
                                  subtitle:
                                      'Hide call button everywhere from User app',
                                  leadingicondata:
                                      Icons.settings_applications_rounded),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: istextmessageallowed ?? false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool:
                                                    istextmessageallowed,
                                                setstateMap: () {
                                                  istextmessageallowed =
                                                      !istextmessageallowed!;
                                                },
                                                map: {
                                                  Dbkeys.istextmessageallowed:
                                                      !istextmessageallowed!,
                                                });
                                          }),
                              ),
                              title: 'Text Messaging Allowed',
                              isthreelines: true,
                              subtitle: 'Users can send text messaging in Chat',
                              leadingicondata:
                                  Icons.settings_applications_rounded),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: ismediamessageallowed ?? false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool:
                                                    ismediamessageallowed,
                                                setstateMap: () {
                                                  ismediamessageallowed =
                                                      !ismediamessageallowed!;
                                                },
                                                map: {
                                                  Dbkeys.ismediamessageallowed:
                                                      !ismediamessageallowed!,
                                                });
                                          }),
                              ),
                              title: 'Media Sending Allowed',
                              isthreelines: true,
                              subtitle: 'Users can send files in Chat',
                              leadingicondata:
                                  Icons.settings_applications_rounded),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: isAllowCreatingGroups ?? false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool:
                                                    isAllowCreatingGroups,
                                                setstateMap: () {
                                                  isAllowCreatingGroups =
                                                      !isAllowCreatingGroups!;
                                                },
                                                map: {
                                                  Dbkeys.isAllowCreatingGroups:
                                                      !isAllowCreatingGroups!,
                                                });
                                          }),
                              ),
                              title: 'Allow Creating Groups',
                              isthreelines: true,
                              subtitle: 'Users can create Group for Group chat',
                              leadingicondata:
                                  Icons.settings_applications_rounded),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: isAllowCreatingStatus ?? false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool:
                                                    isAllowCreatingStatus,
                                                setstateMap: () {
                                                  isAllowCreatingStatus =
                                                      !isAllowCreatingStatus!;
                                                },
                                                map: {
                                                  Dbkeys.isAllowCreatingStatus:
                                                      !isAllowCreatingStatus!,
                                                });
                                          }),
                              ),
                              title: 'Allow Creating Status',
                              isthreelines: true,
                              subtitle: 'Users can post new Status Stories',
                              leadingicondata:
                                  Icons.settings_applications_rounded),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: isAllowCreatingBroadcasts ?? false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool:
                                                    isAllowCreatingBroadcasts,
                                                setstateMap: () {
                                                  isAllowCreatingBroadcasts =
                                                      !isAllowCreatingBroadcasts!;
                                                },
                                                map: {
                                                  Dbkeys.isAllowCreatingBroadcasts:
                                                      !isAllowCreatingBroadcasts!,
                                                });
                                          }),
                              ),
                              title: 'Allow Creating Broadcasts',
                              isthreelines: true,
                              subtitle:
                                  'Users can create new Broadcast group (*If features is available in App)',
                              leadingicondata:
                                  Icons.settings_applications_rounded),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: isadmobshow ?? false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool: isadmobshow,
                                                setstateMap: () {
                                                  isadmobshow = !isadmobshow!;
                                                },
                                                map: {
                                                  Dbkeys.isadmobshow:
                                                      !isadmobshow!,
                                                });
                                          }),
                              ),
                              title: 'Show Admob Ads',
                              isthreelines: true,
                              subtitle:
                                  'Ads will be displayed if enabled in the source code > app_constants.dart file also.',
                              leadingicondata:
                                  Icons.settings_applications_rounded),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: is24hrsTimeformat ?? false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool: is24hrsTimeformat,
                                                setstateMap: () {
                                                  is24hrsTimeformat =
                                                      !is24hrsTimeformat!;
                                                },
                                                map: {
                                                  Dbkeys.is24hrsTimeformat:
                                                      !is24hrsTimeformat!,
                                                });
                                          }),
                              ),
                              title: 'Show 24Hrs Format',
                              isthreelines: true,
                              subtitle: is24hrsTimeformat == true
                                  ? 'Time displayed in 24hrs format in User App'
                                  : 'Time displayed in AM/PM format is User App',
                              leadingicondata:
                                  Icons.settings_applications_rounded),

                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value:
                                        isPercentProgressShowWhileUploading ??
                                            false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool:
                                                    isPercentProgressShowWhileUploading,
                                                setstateMap: () {
                                                  isPercentProgressShowWhileUploading =
                                                      !isPercentProgressShowWhileUploading!;
                                                },
                                                map: {
                                                  Dbkeys.isPercentProgressShowWhileUploading:
                                                      !isPercentProgressShowWhileUploading!,
                                                });
                                          }),
                              ),
                              title: 'Show progress Indicator',
                              isthreelines: true,
                              subtitle:
                                  'Upload/Download progress can be seen by users',
                              leadingicondata:
                                  Icons.settings_applications_rounded),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: isLogoutButtonShowInSettingsPage ??
                                        false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool:
                                                    isLogoutButtonShowInSettingsPage,
                                                setstateMap: () {
                                                  isLogoutButtonShowInSettingsPage =
                                                      !isLogoutButtonShowInSettingsPage!;
                                                },
                                                map: {
                                                  Dbkeys.isLogoutButtonShowInSettingsPage:
                                                      !isLogoutButtonShowInSettingsPage!,
                                                });
                                          }),
                              ),
                              title: 'Show Logout button',
                              isthreelines: true,
                              subtitle: 'Logout button Show in Settings page',
                              leadingicondata:
                                  Icons.settings_applications_rounded),

                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingicondata: Icons.edit_outlined,
                              title: 'Max. File Size (MB)',
                              subtitle: maxFileSizeAllowedInMB.toString(),
                              leadingicondata:
                                  Icons.settings_applications_rounded,
                              ontap: () {
                                _controller.text =
                                    maxFileSizeAllowedInMB.toString();
                                ShowFormDialog().open(
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                              "[0-9]") //-- Only Number & Aplhabets
                                          )
                                    ],
                                    iscapital: false,
                                    controller: _controller,
                                    keyboardtype: TextInputType.number,
                                    maxlength: 8,
                                    // maxlines: 4,
                                    // minlines: 2,
                                    iscentrealign: true,
                                    context: context,
                                    title: 'Max. File Size (MB)',
                                    subtitle:
                                        maxFileSizeAllowedInMB.toString() +
                                            ' MB',
                                    onpressed: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            if (_controller.text.trim().length <
                                                1) {
                                              ShowSnackbar().open(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  time: 3,
                                                  label:
                                                      'Please enter a valid number');
                                              delayedFunction(setstatefn: () {
                                                ShowSnackbar().close(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                );
                                              });
                                            } else {
                                              await fieldupdate(
                                                  context: context,
                                                  map: {
                                                    Dbkeys.maxFileSizeAllowedInMB:
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim())
                                                  },
                                                  setstateMap: () {
                                                    maxFileSizeAllowedInMB =
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim());
                                                  });
                                            }
                                          },
                                    buttontext: 'UPDATE',
                                    hinttext: 'Enter Max. File Size');
                              }),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingicondata: Icons.edit_outlined,
                              title: 'Group Members Limit',
                              subtitle: groupMemberslimit.toString(),
                              leadingicondata:
                                  Icons.settings_applications_rounded,
                              ontap: () {
                                _controller.text = groupMemberslimit.toString();
                                ShowFormDialog().open(
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                              "[0-9]") //-- Only Number & Aplhabets
                                          )
                                    ],
                                    iscapital: false,
                                    controller: _controller,
                                    keyboardtype: TextInputType.number,
                                    maxlength: 8,
                                    iscentrealign: true,
                                    context: context,
                                    title: 'Group Members Limit',
                                    subtitle:
                                        'Max. no. of users can be added into Group chat',
                                    onpressed: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            if (_controller.text.trim().length <
                                                1) {
                                              ShowSnackbar().open(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  time: 3,
                                                  label:
                                                      'Please enter a valid number');
                                              delayedFunction(setstatefn: () {
                                                ShowSnackbar().close(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                );
                                              });
                                            } else {
                                              await fieldupdate(
                                                  context: context,
                                                  map: {
                                                    Dbkeys.groupMemberslimit:
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim())
                                                  },
                                                  setstateMap: () {
                                                    groupMemberslimit =
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim());
                                                  });
                                            }
                                          },
                                    buttontext: 'UPDATE',
                                    hinttext: 'Enter Members Limit');
                              }),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingicondata: Icons.edit_outlined,
                              title: 'Broadcast Members Limit',
                              subtitle: broadcastMemberslimit.toString(),
                              leadingicondata:
                                  Icons.settings_applications_rounded,
                              ontap: () {
                                _controller.text =
                                    broadcastMemberslimit.toString();
                                ShowFormDialog().open(
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                              "[0-9]") //-- Only Number & Aplhabets
                                          )
                                    ],
                                    iscapital: false,
                                    controller: _controller,
                                    keyboardtype: TextInputType.number,
                                    maxlength: 8,
                                    // maxlines: 4,
                                    // minlines: 2,
                                    iscentrealign: true,
                                    context: context,
                                    title: 'Broadcast Members limit',
                                    subtitle:
                                        'Max. no of Users can be added into ',
                                    onpressed: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            if (_controller.text.trim().length <
                                                1) {
                                              ShowSnackbar().open(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  time: 3,
                                                  label:
                                                      'Please enter a valid number');
                                              delayedFunction(setstatefn: () {
                                                ShowSnackbar().close(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                );
                                              });
                                            } else {
                                              await fieldupdate(
                                                  context: context,
                                                  map: {
                                                    Dbkeys.broadcastMemberslimit:
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim())
                                                  },
                                                  setstateMap: () {
                                                    broadcastMemberslimit =
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim());
                                                  });
                                            }
                                          },
                                    buttontext: 'UPDATE',
                                    hinttext:
                                        'Enter Broadcast Recipients Limit');
                              }),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingicondata: Icons.edit_outlined,
                              title: 'Status Delete Time (Hrs)',
                              subtitle:
                                  statusDeleteAfterInHours.toString() + ' Hrs',
                              leadingicondata:
                                  Icons.settings_applications_rounded,
                              ontap: () {
                                _controller.text =
                                    statusDeleteAfterInHours.toString();
                                ShowFormDialog().open(
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                              "[0-9]") //-- Only Number & Aplhabets
                                          )
                                    ],
                                    iscapital: false,
                                    controller: _controller,
                                    keyboardtype: TextInputType.number,
                                    maxlength: 8,
                                    // maxlines: 4,
                                    // minlines: 2,
                                    iscentrealign: true,
                                    context: context,
                                    title: 'Status Delete Time',
                                    subtitle:
                                        'Status will be deleted after mentioned hours of creating',
                                    onpressed: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            if (_controller.text.trim().length <
                                                1) {
                                              ShowSnackbar().open(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  time: 3,
                                                  label:
                                                      'Please enter a valid number');
                                              delayedFunction(setstatefn: () {
                                                ShowSnackbar().close(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                );
                                              });
                                            } else {
                                              await fieldupdate(
                                                  context: context,
                                                  map: {
                                                    Dbkeys.statusDeleteAfterInHours:
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim())
                                                  },
                                                  setstateMap: () {
                                                    statusDeleteAfterInHours =
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim());
                                                  });
                                            }
                                          },
                                    buttontext: 'UPDATE',
                                    hinttext: 'Status Delete after (Hrs)');
                              }),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingicondata: Icons.edit_outlined,
                              title: 'Max. Files for Multi Sharing',
                              subtitle: maxNoOfFilesInMultiSharing.toString(),
                              leadingicondata:
                                  Icons.settings_applications_rounded,
                              ontap: () {
                                _controller.text =
                                    maxNoOfFilesInMultiSharing.toString();
                                ShowFormDialog().open(
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                              "[0-9]") //-- Only Number & Aplhabets
                                          )
                                    ],
                                    iscapital: false,
                                    controller: _controller,
                                    keyboardtype: TextInputType.number,
                                    maxlength: 8,
                                    // maxlines: 4,
                                    // minlines: 2,
                                    iscentrealign: true,
                                    context: context,
                                    title: 'Max. Files for Multi Sharing',
                                    subtitle:
                                        'Maximum number of multiple files that can be selected for sharing at once.',
                                    onpressed: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            if (_controller.text.trim().length <
                                                1) {
                                              ShowSnackbar().open(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  time: 3,
                                                  label:
                                                      'Please enter a valid number');
                                              delayedFunction(setstatefn: () {
                                                ShowSnackbar().close(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                );
                                              });
                                            } else {
                                              await fieldupdate(
                                                  context: context,
                                                  map: {
                                                    Dbkeys.maxNoOfFilesInMultiSharing:
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim())
                                                  },
                                                  setstateMap: () {
                                                    maxNoOfFilesInMultiSharing =
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim());
                                                  });
                                            }
                                          },
                                    buttontext: 'UPDATE',
                                    hinttext:
                                        'No. of Files for Multi Sharing (Max. Preferred. 15)');
                              }),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingicondata: Icons.edit_outlined,
                              title: 'Max. Contacts select to Forward',
                              subtitle:
                                  maxNoOfContactsSelectForForward.toString(),
                              leadingicondata:
                                  Icons.settings_applications_rounded,
                              ontap: () {
                                _controller.text =
                                    maxNoOfContactsSelectForForward.toString();
                                ShowFormDialog().open(
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                              "[0-9]") //-- Only Number & Aplhabets
                                          )
                                    ],
                                    iscapital: false,
                                    controller: _controller,
                                    keyboardtype: TextInputType.number,
                                    maxlength: 8,
                                    // maxlines: 4,
                                    // minlines: 2,
                                    iscentrealign: true,
                                    context: context,
                                    title: 'Max. Contacts select to Forward',
                                    subtitle:
                                        'Select a list of users to Forward a message.',
                                    onpressed: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            if (_controller.text.trim().length <
                                                1) {
                                              ShowSnackbar().open(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  time: 3,
                                                  label:
                                                      'Please enter a valid number');
                                              delayedFunction(setstatefn: () {
                                                ShowSnackbar().close(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                );
                                              });
                                            } else {
                                              await fieldupdate(
                                                  context: context,
                                                  map: {
                                                    Dbkeys.maxNoOfContactsSelectForForward:
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim())
                                                  },
                                                  setstateMap: () {
                                                    maxNoOfContactsSelectForForward =
                                                        int.tryParse(_controller
                                                            .text
                                                            .trim());
                                                  });
                                            }
                                          },
                                    buttontext: 'UPDATE',
                                    hinttext:
                                        'No. of Contacts select to Forward (Max.Preffered- 10)');
                              }),
                          profileTile(
                              isthreelines: true,
                              margin: 5,
                              iconsize: 30,
                              trailingicondata: Icons.edit_outlined,
                              title: 'Feedback Email',
                              subtitle: feedbackEmail == null ||
                                      feedbackEmail == ''
                                  ? 'Users can give feedback from thier Settings Page'
                                  : feedbackEmail,
                              leadingicondata:
                                  Icons.settings_applications_rounded,
                              ontap: () {
                                _controller.text = feedbackEmail!;
                                ShowFormDialog().open(
                                    inputFormatter: [],
                                    iscapital: false,
                                    controller: _controller,
                                    maxlength: 100,
                                    maxlines: 4,
                                    minlines: 3,
                                    iscentrealign: true,
                                    context: context,
                                    title: 'Feedback Email',
                                    onpressed: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            if (_controller.text.trim().length <
                                                5) {
                                              ShowSnackbar().open(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  time: 3,
                                                  label:
                                                      'Please enter a valid email');
                                              delayedFunction(setstatefn: () {
                                                ShowSnackbar().close(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                );
                                              });
                                            } else {
                                              await fieldupdate(
                                                  context: context,
                                                  map: {
                                                    Dbkeys.feedbackEmail:
                                                        _controller.text.trim()
                                                  },
                                                  setstateMap: () {
                                                    feedbackEmail =
                                                        _controller.text.trim();
                                                  });
                                            }
                                          },
                                    buttontext: 'UPDATE',
                                    hinttext: 'Enter Email');
                              }),
                          profileTile(
                              margin: 5,
                              iconsize: 30,
                              trailingWidget: Container(
                                margin: EdgeInsets.only(right: 3, top: 5),
                                width: 50,
                                height: 19,
                                child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: 46.0,
                                    activeColor:
                                        Mycolors.green.withOpacity(0.85),
                                    inactiveColor: Mycolors.grey,
                                    height: 19.0,
                                    valueFontSize: 12.0,
                                    toggleSize: 15.0,
                                    value: isCustomAppShareLink ?? false,
                                    borderRadius: 25.0,
                                    padding: 3.0,
                                    showOnOff: true,
                                    onToggle: AppConstants.isdemomode == true
                                        ? (val) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (val) async {
                                            await confirmchangeswitch(
                                                context: context,
                                                currentlbool:
                                                    isCustomAppShareLink,
                                                setstateMap: () {
                                                  isCustomAppShareLink =
                                                      !isCustomAppShareLink!;
                                                },
                                                map: {
                                                  Dbkeys.isCustomAppShareLink:
                                                      !isCustomAppShareLink!,
                                                });
                                          }),
                              ),
                              title: 'Custom ShareApp Message ',
                              isthreelines: true,
                              subtitle:
                                  'If OFF, App will provide auto-generated share app message.',
                              leadingicondata:
                                  Icons.settings_applications_rounded),
                          isCustomAppShareLink == true
                              ? profileTile(
                                  isthreelines: true,
                                  margin: 5,
                                  iconsize: 30,
                                  trailingicondata: Icons.edit_outlined,
                                  title: 'Share App Message Android',
                                  subtitle:
                                      appShareMessageStringAndroid == null ||
                                              appShareMessageStringAndroid == ''
                                          ? '......'
                                          : appShareMessageStringAndroid,
                                  leadingicondata:
                                      Icons.settings_applications_rounded,
                                  ontap: () {
                                    _controller.text =
                                        appShareMessageStringAndroid!;
                                    ShowFormDialog().open(
                                        inputFormatter: [],
                                        iscapital: false,
                                        controller: _controller,
                                        maxlength: 500,
                                        maxlines: 9,
                                        minlines: 5,
                                        iscentrealign: true,
                                        context: context,
                                        title: 'Share App Message Android',
                                        onpressed: AppConstants.isdemomode ==
                                                true
                                            ? () {
                                                Utils.toast(
                                                    'Not Allowed in Demo App');
                                              }
                                            : () async {
                                                if (_controller.text
                                                        .trim()
                                                        .length <
                                                    5) {
                                                  ShowSnackbar().open(
                                                      context: context,
                                                      scaffoldKey: _scaffoldKey,
                                                      time: 3,
                                                      label:
                                                          'Please enter valid text');
                                                  delayedFunction(
                                                      setstatefn: () {
                                                    ShowSnackbar().close(
                                                      context: context,
                                                      scaffoldKey: _scaffoldKey,
                                                    );
                                                  });
                                                } else {
                                                  await fieldupdate(
                                                      context: context,
                                                      map: {
                                                        Dbkeys.appShareMessageStringAndroid:
                                                            _controller.text
                                                                .trim()
                                                      },
                                                      setstateMap: () {
                                                        appShareMessageStringAndroid =
                                                            _controller.text
                                                                .trim();
                                                      });
                                                }
                                              },
                                        buttontext: 'UPDATE',
                                        hinttext:
                                            'Share App Message for Android');
                                  })
                              : SizedBox(),

                          isCustomAppShareLink == true
                              ? profileTile(
                                  isthreelines: true,
                                  margin: 5,
                                  iconsize: 30,
                                  trailingicondata: Icons.edit_outlined,
                                  title: 'Share App Message iOS',
                                  subtitle: appShareMessageStringiOS == null ||
                                          appShareMessageStringiOS == ''
                                      ? '......'
                                      : appShareMessageStringiOS,
                                  leadingicondata:
                                      Icons.settings_applications_rounded,
                                  ontap: () {
                                    _controller.text =
                                        appShareMessageStringiOS!;
                                    ShowFormDialog().open(
                                        inputFormatter: [],
                                        iscapital: false,
                                        controller: _controller,
                                        maxlength: 500,
                                        maxlines: 9,
                                        minlines: 5,
                                        iscentrealign: true,
                                        context: context,
                                        title: 'Share App Message iOS',
                                        onpressed: AppConstants.isdemomode ==
                                                true
                                            ? () {
                                                Utils.toast(
                                                    'Not Allowed in Demo App');
                                              }
                                            : () async {
                                                if (_controller.text
                                                        .trim()
                                                        .length <
                                                    5) {
                                                  ShowSnackbar().open(
                                                      context: context,
                                                      scaffoldKey: _scaffoldKey,
                                                      time: 3,
                                                      label:
                                                          'Please enter valid text');
                                                  delayedFunction(
                                                      setstatefn: () {
                                                    ShowSnackbar().close(
                                                      context: context,
                                                      scaffoldKey: _scaffoldKey,
                                                    );
                                                  });
                                                } else {
                                                  await fieldupdate(
                                                      context: context,
                                                      map: {
                                                        Dbkeys.appShareMessageStringiOS:
                                                            _controller.text
                                                                .trim()
                                                      },
                                                      setstateMap: () {
                                                        appShareMessageStringiOS =
                                                            _controller.text
                                                                .trim();
                                                      });
                                                }
                                              },
                                        buttontext: 'UPDATE',
                                        hinttext: 'Share App Message for iOS');
                                  })
                              : SizedBox(),
                        ],
                      )
                    : (widget.pagetype == Dbkeys.tnc
                        ? ListView(children: [
//**---  TnC  controls
                            Padding(
                              padding: const EdgeInsets.fromLTRB(7, 39, 7, 5),
                              child: Text(
                                'TERMS & CONDITIONS',
                                style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 0.9,
                                    color: Mycolors.grey,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            InputGroup2large(
                              title: 'Content Type',
                              val1: Dbkeys.file,
                              val2: Dbkeys.url,
                              selectedvalue: this.tncTYPE,
                              onChanged: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      if (this.tnc != null &&
                                          this.tncTYPE == Dbkeys.file) {
                                        ShowSnackbar().open(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            time: 4,
                                            label:
                                                'Please delete the file to Switch this value.',
                                            status: 0);
                                        this.tncTYPE = Dbkeys.file;
                                      } else if (this.tnc != null &&
                                          this.tncTYPE == Dbkeys.url) {
                                        setState(() {
                                          this.tncTYPE = val;
                                          this.tnc = null;
                                        });
                                        await FirebaseFirestore.instance
                                            .collection(Dbkeys.appsettings)
                                            .doc(Dbkeys.userapp)
                                            .update({
                                          Dbkeys.tncTYPE: val,
                                          Dbkeys.tnc: null,
                                        });
                                      } else {
                                        this.tncTYPE = val;
                                        this.tnc = null;
                                        setState(() {});
                                        await FirebaseFirestore.instance
                                            .collection(Dbkeys.appsettings)
                                            .doc(Dbkeys.userapp)
                                            .update({
                                          Dbkeys.tncTYPE: val,
                                          Dbkeys.tnc: null,
                                        });
                                      }
                                    },
                            ),

                            this.tncTYPE == Dbkeys.file
                                ? InputPDFFile(
                                    // iseditvisible: false,
                                    boxwidth: w,
                                    iseditvisible: false,
                                    // placeholder: '1024x465',
                                    title: ' File',
                                    filename: this.tncfilename,
                                    fileurl: this.tnc,
                                    uploadfn: AppConstants.isdemomode == true
                                        ? (file, filetype, basename) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (file, filetype, basename) async {
                                            FirebaseUploader()
                                                .uploadFile(
                                              context: context,
                                              scaffoldkey: _scaffoldKey,
                                              keyLoader: _keyLoader2,
                                              file: file,
                                              fileType: 'pdf',
                                              filename: file.path
                                                  .split('/')
                                                  .last
                                                  .toString(),
                                              folder: Dbkeys.tnc,
                                              collection: DbPaths
                                                  .collectioncompanydetails,
                                            )
                                                .then((value) {
                                              setState(() {
                                                tnc = value;
                                                tncfilename = file.path
                                                    .split('/')
                                                    .last
                                                    .toString();
                                              });
                                            }).then((value) async {
                                              await firestoreupdatedoc(
                                                  context: context,
                                                  scaffoldkey: _scaffoldKey,
                                                  keyloader: _keyLoader3,
                                                  collection:
                                                      Dbkeys.appsettings,
                                                  document: Dbkeys.userapp,
                                                  updatemap: {
                                                    Dbkeys.tnc: tnc,
                                                  });
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      Dbkeys.appsettings)
                                                  .doc(Dbkeys.userapp)
                                                  .update({
                                                Dbkeys.tncTYPE: Dbkeys.file,
                                              });
                                              hidekeyboard(context);
                                            });
                                          },
                                    deletefn: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            await FirebaseUploader()
                                                .deleteFile(
                                              context: context,
                                              scaffoldkey: _scaffoldKey,
                                              mykeyLoader: _keyLoader4,
                                              isDeleteUsingUrl: true,
                                              fileType: 'pdf',
                                              filename: this.tncfilename,
                                              url: this.tnc,
                                            )
                                                .then((isDeleted) {
                                              if (isDeleted == true) {
                                                setState(() {
                                                  tnc = null;
                                                  tncfilename = null;
                                                  // _tc11CONTENTtitleRG.clear();
                                                });
                                              }
                                            }).then((value) async {
                                              await firestoreupdatedoc(
                                                  context: context,
                                                  scaffoldkey: _scaffoldKey,
                                                  keyloader: _keyLoader5,
                                                  collection:
                                                      Dbkeys.appsettings,
                                                  document: Dbkeys.userapp,
                                                  updatemap: {
                                                    Dbkeys.tnc: null,
                                                  });
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      Dbkeys.appsettings)
                                                  .doc(Dbkeys.userapp)
                                                  .update({
                                                Dbkeys.tncTYPE: Dbkeys.url,
                                              });
                                              setState(() {
                                                tnc = null;
                                                tncTYPE = Dbkeys.url;
                                              });
                                              hidekeyboard(context);
                                            });
                                          },
                                  )
                                : this.tncTYPE == Dbkeys.url
                                    ? profileTile(
                                        isthreelines: true,
                                        margin: 5,
                                        iconsize: 30,
                                        trailingicondata: Icons.edit_outlined,
                                        title: 'Terms & Conditions URL',
                                        subtitle:
                                            this.tnc ?? 'Paste your URL here',
                                        leadingicondata:
                                            Icons.settings_applications_rounded,
                                        ontap: () {
                                          _controller.text = tnc ?? '';
                                          ShowFormDialog().open(
                                              iscapital: false,
                                              controller: _controller,
                                              maxlength: 500,
                                              maxlines: 5,
                                              minlines: 4,
                                              iscentrealign: true,
                                              context: context,
                                              title: 'Terms & Conditions URL',
                                              onpressed: AppConstants
                                                          .isdemomode ==
                                                      true
                                                  ? () {
                                                      Utils.toast(
                                                          'Not Allowed in Demo App');
                                                    }
                                                  : () async {
                                                      if (_controller.text
                                                              .trim()
                                                              .length <
                                                          5) {
                                                        ShowSnackbar().open(
                                                            context: context,
                                                            scaffoldKey:
                                                                _scaffoldKey,
                                                            time: 3,
                                                            label:
                                                                'Please enter a valid URL');
                                                        delayedFunction(
                                                            setstatefn: () {
                                                          ShowSnackbar().close(
                                                            context: context,
                                                            scaffoldKey:
                                                                _scaffoldKey,
                                                          );
                                                        });
                                                      } else {
                                                        await fieldupdate(
                                                            context: context,
                                                            map: {
                                                              Dbkeys.tnc:
                                                                  _controller
                                                                      .text
                                                                      .trim(),
                                                              Dbkeys.tncTYPE:
                                                                  Dbkeys.url
                                                            },
                                                            setstateMap: () {
                                                              tnc = _controller
                                                                  .text
                                                                  .trim();
                                                              tncTYPE =
                                                                  Dbkeys.url;
                                                            });
                                                      }
                                                    },
                                              buttontext: 'UPDATE',
                                              hinttext: 'Enter URL');
                                        })
                                    : SizedBox(),
                            //**---  Privacy Policy  controls
                            Padding(
                              padding: const EdgeInsets.fromLTRB(7, 39, 7, 5),
                              child: Text(
                                'POLICY POLICY',
                                style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 0.9,
                                    color: Mycolors.grey,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            InputGroup2large(
                              title: 'Content Type',
                              val1: Dbkeys.file,
                              val2: Dbkeys.url,
                              selectedvalue: this.privacypolicyTYPE,
                              onChanged: AppConstants.isdemomode == true
                                  ? (val) {
                                      Utils.toast('Not Allowed in Demo App');
                                    }
                                  : (val) async {
                                      if (this.privacypolicy != null &&
                                          this.privacypolicyTYPE ==
                                              Dbkeys.file) {
                                        ShowSnackbar().open(
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            time: 4,
                                            label:
                                                'Please delete the file to Switch this value.',
                                            status: 0);
                                        this.privacypolicyTYPE = Dbkeys.file;
                                      } else if (this.privacypolicy != null &&
                                          this.privacypolicyTYPE ==
                                              Dbkeys.url) {
                                        setState(() {
                                          this.privacypolicyTYPE = val;
                                          this.privacypolicy = null;
                                        });
                                        await FirebaseFirestore.instance
                                            .collection(Dbkeys.appsettings)
                                            .doc(Dbkeys.userapp)
                                            .update({
                                          Dbkeys.privacypolicyTYPE: val,
                                          Dbkeys.privacypolicy: null,
                                        });
                                      } else {
                                        this.privacypolicyTYPE = val;
                                        this.privacypolicy = null;
                                        setState(() {});
                                        await FirebaseFirestore.instance
                                            .collection(Dbkeys.appsettings)
                                            .doc(Dbkeys.userapp)
                                            .update({
                                          Dbkeys.privacypolicyTYPE: val,
                                          Dbkeys.privacypolicy: null,
                                        });
                                      }
                                    },
                            ),

                            this.privacypolicyTYPE == Dbkeys.file
                                ? InputPDFFile(
                                    // iseditvisible: false,
                                    boxwidth: w,
                                    iseditvisible: false,
                                    // placeholder: '1024x465',
                                    title: ' File',
                                    filename: this.privacypolicyfilename,
                                    fileurl: this.privacypolicy,
                                    uploadfn: AppConstants.isdemomode == true
                                        ? (file, filetype, basename) {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : (file, filetype, basename) async {
                                            FirebaseUploader()
                                                .uploadFile(
                                              context: context,
                                              scaffoldkey: _scaffoldKey,
                                              keyLoader: _keyLoader2,
                                              file: file,
                                              fileType: 'pdf',
                                              filename: file.path
                                                  .split('/')
                                                  .last
                                                  .toString(),
                                              folder: Dbkeys.privacypolicy,
                                              collection: DbPaths
                                                  .collectioncompanydetails,
                                            )
                                                .then((value) {
                                              setState(() {
                                                privacypolicy = value;
                                                privacypolicyfilename = file
                                                    .path
                                                    .split('/')
                                                    .last
                                                    .toString();
                                              });
                                            }).then((value) async {
                                              await firestoreupdatedoc(
                                                  context: context,
                                                  scaffoldkey: _scaffoldKey,
                                                  keyloader: _keyLoader3,
                                                  collection:
                                                      Dbkeys.appsettings,
                                                  document: Dbkeys.userapp,
                                                  updatemap: {
                                                    Dbkeys.privacypolicy:
                                                        privacypolicy,
                                                  });
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      Dbkeys.appsettings)
                                                  .doc(Dbkeys.userapp)
                                                  .update({
                                                Dbkeys.privacypolicyTYPE:
                                                    Dbkeys.file,
                                              });
                                              hidekeyboard(context);
                                            });
                                          },
                                    deletefn: AppConstants.isdemomode == true
                                        ? () {
                                            Utils.toast(
                                                'Not Allowed in Demo App');
                                          }
                                        : () async {
                                            await FirebaseUploader()
                                                .deleteFile(
                                              context: context,
                                              scaffoldkey: _scaffoldKey,
                                              mykeyLoader: _keyLoader4,
                                              isDeleteUsingUrl: true,
                                              fileType: 'pdf',
                                              filename:
                                                  this.privacypolicyfilename,
                                              url: this.privacypolicy,
                                            )
                                                .then((isDeleted) {
                                              if (isDeleted == true) {
                                                setState(() {
                                                  privacypolicy = null;
                                                  privacypolicyfilename = null;
                                                  // _tc11CONTENTtitleRG.clear();
                                                });
                                              }
                                            }).then((value) async {
                                              await firestoreupdatedoc(
                                                  context: context,
                                                  scaffoldkey: _scaffoldKey,
                                                  keyloader: _keyLoader5,
                                                  collection:
                                                      Dbkeys.appsettings,
                                                  document: Dbkeys.userapp,
                                                  updatemap: {
                                                    Dbkeys.privacypolicy: null,
                                                  });
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      Dbkeys.appsettings)
                                                  .doc(Dbkeys.userapp)
                                                  .update({
                                                Dbkeys.privacypolicyTYPE:
                                                    Dbkeys.url,
                                              });
                                              setState(() {
                                                privacypolicy = null;
                                                privacypolicyTYPE = Dbkeys.url;
                                              });
                                              hidekeyboard(context);
                                            });
                                          },
                                  )
                                : this.privacypolicyTYPE == Dbkeys.url
                                    ? profileTile(
                                        isthreelines: true,
                                        margin: 5,
                                        iconsize: 30,
                                        trailingicondata: Icons.edit_outlined,
                                        title: 'Privacy Policy URL',
                                        subtitle: this.privacypolicy ??
                                            'Paste your URL here',
                                        leadingicondata:
                                            Icons.settings_applications_rounded,
                                        ontap: () {
                                          _controller.text =
                                              privacypolicy ?? '';
                                          ShowFormDialog().open(
                                              iscapital: false,
                                              controller: _controller,
                                              maxlength: 500,
                                              maxlines: 5,
                                              minlines: 4,
                                              iscentrealign: true,
                                              context: context,
                                              title: 'Privacy Policy URL',
                                              onpressed: AppConstants
                                                          .isdemomode ==
                                                      true
                                                  ? () {
                                                      Utils.toast(
                                                          'Not Allowed in Demo App');
                                                    }
                                                  : () async {
                                                      if (_controller.text
                                                              .trim()
                                                              .length <
                                                          5) {
                                                        ShowSnackbar().open(
                                                            context: context,
                                                            scaffoldKey:
                                                                _scaffoldKey,
                                                            time: 3,
                                                            label:
                                                                'Please enter a valid URL');
                                                        delayedFunction(
                                                            setstatefn: () {
                                                          ShowSnackbar().close(
                                                            context: context,
                                                            scaffoldKey:
                                                                _scaffoldKey,
                                                          );
                                                        });
                                                      } else {
                                                        await fieldupdate(
                                                            context: context,
                                                            map: {
                                                              Dbkeys.privacypolicy:
                                                                  _controller
                                                                      .text
                                                                      .trim(),
                                                              Dbkeys.privacypolicyTYPE:
                                                                  Dbkeys.url
                                                            },
                                                            setstateMap: () {
                                                              privacypolicy =
                                                                  _controller
                                                                      .text
                                                                      .trim();
                                                              privacypolicyTYPE =
                                                                  Dbkeys.url;
                                                            });
                                                      }
                                                    },
                                              buttontext: 'UPDATE',
                                              hinttext: 'Enter URL');
                                        })
                                    : SizedBox(),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(7, 69, 7, 5),
                            //   child: Text(
                            //     'PRIVACY POLICY',
                            //     style: TextStyle(
                            //         fontSize: 12,
                            //         letterSpacing: 0.9,
                            //         color: Mycolors.grey,
                            //         fontWeight: FontWeight.w700),
                            //   ),
                            // ),
                            // InputGroup2large(
                            //   title: 'Content Type',
                            //   val1: Dbkeys.file,
                            //   val2: Dbkeys.url,
                            //   selectedvalue: this.privacypolicyTYPE,
                            //   onChanged: AppConstants.isdemomode == true
                            //       ? (val) {
                            //           Utils.toast('Not Allowed in Demo App');
                            //         }
                            //       : (val) async {
                            //           if (this.privacypolicy != null &&
                            //               this.privacypolicyTYPE ==
                            //                   Dbkeys.file) {
                            //             ShowSnackbar().open(
                            //                 context: context,
                            //                 scaffoldKey: _scaffoldKey,
                            //                 time: 4,
                            //                 label:
                            //                     'Please delete the file to Switch this value.',
                            //                 status: 0);
                            //             this.privacypolicyTYPE = Dbkeys.file;
                            //           } else if (this.privacypolicy != null &&
                            //               this.privacypolicyTYPE ==
                            //                   Dbkeys.url) {
                            //             setState(() {
                            //               this.privacypolicyTYPE = val;
                            //               this.privacypolicy = null;
                            //             });
                            //           } else {
                            //             this.privacypolicyTYPE = val;
                            //             this.privacypolicy = null;
                            //             setState(() {});
                            //           }
                            //         },
                            // ),
                            // this.privacypolicyTYPE == Dbkeys.file
                            //     ? InputPDFFile(
                            //         boxwidth: w,
                            //         iseditvisible: false,
                            //         title: ' File',
                            //         filename: this.privacypolicyfilename,
                            //         fileurl: this.privacypolicy,
                            //         uploadfn: AppConstants.isdemomode == true
                            //             ? (file, filetype, basename) {
                            //                 Utils.toast(
                            //                     'Not Allowed in Demo App');
                            //               }
                            //             : (file, filetype, basename) async {
                            //                 FirebaseUploader()
                            //                     .uploadFile(
                            //                   context: context,
                            //                   scaffoldkey: _scaffoldKey,
                            //                   keyLoader: _keyLoader2,
                            //                   file: file,
                            //                   fileType: 'pdf',
                            //                   filename: file.path
                            //                       .split('/')
                            //                       .last
                            //                       .toString(),
                            //                   folder: Dbkeys.privacypolicy,
                            //                   collection: DbPaths
                            //                       .collectioncompanydetails,
                            //                 )
                            //                     .then((value) {
                            //                   setState(() {
                            //                     privacypolicy = value;
                            //                     tncfilename = file.path
                            //                         .split('/')
                            //                         .last
                            //                         .toString();
                            //                   });
                            //                 }).then((value) async {
                            //                   await firestoreupdatedoc(
                            //                       context: context,
                            //                       scaffoldkey: _scaffoldKey,
                            //                       keyloader: _keyLoader3,
                            //                       collection:
                            //                           Dbkeys.appsettings,
                            //                       document: Dbkeys.userapp,
                            //                       updatemap: {
                            //                         Dbkeys.privacypolicy:
                            //                             privacypolicy,
                            //                       });
                            //                   await FirebaseFirestore.instance
                            //                       .collection(
                            //                           Dbkeys.appsettings)
                            //                       .doc(Dbkeys.userapp)
                            //                       .update({
                            //                     Dbkeys.privacypolicyTYPE:
                            //                         Dbkeys.file,
                            //                   });
                            //                   hidekeyboard(context);
                            //                 });
                            //               },
                            //         deletefn: AppConstants.isdemomode == true
                            //             ? () {
                            //                 Utils.toast(
                            //                     'Not Allowed in Demo App');
                            //               }
                            //             : () async {
                            //                 await FirebaseUploader()
                            //                     .deleteFile(
                            //                   context: context,
                            //                   scaffoldkey: _scaffoldKey,
                            //                   mykeyLoader: _keyLoader4,
                            //                   isDeleteUsingUrl: true,
                            //                   fileType: 'pdf',
                            //                   filename:
                            //                       this.privacypolicyfilename,
                            //                   url: this.privacypolicy,
                            //                 )
                            //                     .then((isDeleted) {
                            //                   if (isDeleted == true) {
                            //                     setState(() {
                            //                       privacypolicy = null;
                            //                       privacypolicyfilename = null;
                            //                       // _tc11CONTENTtitleRG.clear();
                            //                     });
                            //                   }
                            //                 }).then((value) async {
                            //                   await firestoreupdatedoc(
                            //                       context: context,
                            //                       scaffoldkey: _scaffoldKey,
                            //                       keyloader: _keyLoader5,
                            //                       collection:
                            //                           Dbkeys.appsettings,
                            //                       document: Dbkeys.userapp,
                            //                       updatemap: {
                            //                         Dbkeys.privacypolicy: null,
                            //                       });
                            //                   await FirebaseFirestore.instance
                            //                       .collection(
                            //                           Dbkeys.appsettings)
                            //                       .doc(Dbkeys.userapp)
                            //                       .update({
                            //                     Dbkeys.privacypolicyTYPE:
                            //                         Dbkeys.url,
                            //                   });
                            //                   setState(() {
                            //                     privacypolicy = null;
                            //                     privacypolicyTYPE = Dbkeys.url;
                            //                   });
                            //                   hidekeyboard(context);
                            //                 });
                            //               },
                            //       )
                            //     : this.privacypolicyTYPE == Dbkeys.url
                            //         ? profileTile(
                            //             isthreelines: true,
                            //             margin: 5,
                            //             iconsize: 30,
                            //             trailingicondata: Icons.edit_outlined,
                            //             title: 'Privacy Policy URL',
                            //             subtitle: this.privacypolicy ??
                            //                 'Paste your URL here',
                            //             leadingicondata:
                            //                 Icons.settings_applications_rounded,
                            //             ontap: () {
                            //               _controller.text =
                            //                   privacypolicy ?? '';
                            //               ShowFormDialog().open(
                            //                   iscapital: false,
                            //                   controller: _controller,
                            //                   maxlength: 500,
                            //                   maxlines: 5,
                            //                   minlines: 4,
                            //                   iscentrealign: true,
                            //                   context: context,
                            //                   title: 'Privacy Policy URL',
                            //                   onpressed: AppConstants
                            //                               .isdemomode ==
                            //                           true
                            //                       ? () {
                            //                           Utils.toast(
                            //                               'Not Allowed in Demo App');
                            //                         }
                            //                       : () async {
                            //                           if (_controller.text
                            //                                   .trim()
                            //                                   .length <
                            //                               5) {
                            //                             ShowSnackbar().open(
                            //                                 context: context,
                            //                                 scaffoldKey:
                            //                                     _scaffoldKey,
                            //                                 time: 3,
                            //                                 label:
                            //                                     'Please enter a valid URL');
                            //                             delayedFunction(
                            //                                 setstatefn: () {
                            //                               ShowSnackbar().close(
                            //                                 context: context,
                            //                                 scaffoldKey:
                            //                                     _scaffoldKey,
                            //                               );
                            //                             });
                            //                           } else {
                            //                             await fieldupdate(
                            //                                 context: context,
                            //                                 map: {
                            //                                   Dbkeys.privacypolicy:
                            //                                       _controller
                            //                                           .text
                            //                                           .trim()
                            //                                 },
                            //                                 setstateMap: () {
                            //                                   privacypolicy =
                            //                                       _controller
                            //                                           .text
                            //                                           .trim();
                            //                                 });
                            //                           }
                            //                         },
                            //                   buttontext: 'UPDATE',
                            //                   hinttext: 'Enter URL');
                            //             })
                            //         : SizedBox(),
                          ])
                        : []) as Widget?);
  }
}
