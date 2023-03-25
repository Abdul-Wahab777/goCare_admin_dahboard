import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/FormDialog.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/loadingDialog.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Widgets/DelayedFunction.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Widgets/eachtile.dart';

class AdminAppSettings extends StatefulWidget {
  final String? pagetype;
  AdminAppSettings({this.pagetype});
  @override
  _AdminAppSettingsState createState() => _AdminAppSettingsState();
}

class _AdminAppSettingsState extends State<AdminAppSettings> {
//----- App basic Settings fields ----
  bool? ismaintainncemodeandroid = false;
  bool? ismaintainncemodeios = false;
  bool? isblocknewlogins = false;
  bool? isshowerrorlog = false;
  String? maintainancemessage;
  String? latestappversionandroid;
  String? appupdatelinkandroid;
  String? latestappversionios;
  String? appupdatelinkios;
  bool? isemulatorallowed = false;

  bool isloading = true;

  TextEditingController _controller = new TextEditingController();
  final GlobalKey<State> _keyLoader =
      new GlobalKey<State>(debugLabel: '272hu1');

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  fetchdata() async {
    await FirebaseFirestore.instance
        .collection(Dbkeys.appsettings)
        .doc(widget.pagetype)
        .get()
        .then((dc) async {
      if (widget.pagetype == Dbkeys.adminapp) {
        setState(() {
          isemulatorallowed = dc[Dbkeys.isemulatorallowed];
          ismaintainncemodeandroid = dc[Dbkeys.isappunderconstructionandroid];
          ismaintainncemodeios = dc[Dbkeys.isappunderconstructionios];
          isblocknewlogins = dc[Dbkeys.isblocknewlogins];
          isshowerrorlog = dc[Dbkeys.isshowerrorlog];
          maintainancemessage = dc[Dbkeys.maintainancemessage];
          latestappversionandroid = dc[Dbkeys.latestappversionandroid];
          appupdatelinkandroid = dc[Dbkeys.newapplinkandroid];
          latestappversionios = dc[Dbkeys.latestappversionios];
          appupdatelinkios = dc[Dbkeys.newapplinkios];
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
              .doc(widget.pagetype)
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
        .doc(widget.pagetype)
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
    return MyScaffold(
        scaffoldkey: _scaffoldKey,
        titlespacing: 18,
        title: 'Admin App Settings',
        body: isloading == true
            ? circularProgress()
            : (widget.pagetype == Dbkeys.adminapp
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
                : [SizedBox(height: 7)]) as Widget?);
  }
}
