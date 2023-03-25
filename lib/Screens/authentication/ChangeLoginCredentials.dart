import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Screens/authentication/Setupdata.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:flutter/services.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseUploader.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Widgets/InputBox.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/loadingDialog.dart';
import 'package:thinkcreative_technologies/Widgets/doubleTapBack/doubleTapBack.dart';
import 'package:thinkcreative_technologies/Widgets/hideKeyboard.dart';

class ChangeLoginCredentials extends StatefulWidget {
  final Function? callbackOnUpdate;
  final bool isFirstTime;
  ChangeLoginCredentials({this.callbackOnUpdate, required this.isFirstTime});
  @override
  _ChangeLoginCredentialsState createState() => _ChangeLoginCredentialsState();
}

class _ChangeLoginCredentialsState extends State<ChangeLoginCredentials> {
  String? password;
  String? fullname;
  String? username;
  String? pin;
  String? mobile;
  String? email;
  String? photourl;
  String? phonecode;
  String? phonenumber;
  String? country;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController tcmessage = new TextEditingController();
  TextEditingController tcfullname = new TextEditingController();
  TextEditingController tcpin = new TextEditingController();
  TextEditingController tcusername = new TextEditingController();
  TextEditingController tcpassword = new TextEditingController();

  GlobalKey<State> _keyLoader = new GlobalKey<State>(debugLabel: '733ss883833');

  GlobalKey<State> _keyLoader5 =
      new GlobalKey<State>(debugLabel: 'nffjfjjfjssjgg');
  GlobalKey<State> _keyLoader6 =
      new GlobalKey<State>(debugLabel: 'ffjfjfjfssjfnn');
  GlobalKey<State> _keyLoader7 =
      new GlobalKey<State>(debugLabel: 'jud8dissrrr');
  GlobalKey<State> _keyLoader8 =
      new GlobalKey<State>(debugLabel: 'jjjdjjssdjjd8d');

  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_hhh');

  late BuildContext context;
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    if (widget.isFirstTime == true) {
      setState(() {
        isloading = false;
      });
    } else {
      fetchfromdatabase();
    }
  }

  fetchfromdatabase() async {
    await FirebaseFirestore.instance
        .collection(Dbkeys.admincredentials)
        .doc(Dbkeys.admincredentials)
        .get()
        .then((doc) {
      fullname = doc[Dbkeys.adminfullname];
      pin = doc[Dbkeys.adminpin];
      username = doc[Dbkeys.adminusername];
      password = doc[Dbkeys.adminpassword];
      photourl = doc[Dbkeys.adminphotourl];
      tcfullname.text = doc[Dbkeys.adminfullname];
      tcpin.text = doc[Dbkeys.adminpin];
      tcusername.text = doc[Dbkeys.adminusername];
      tcpassword.text = doc[Dbkeys.adminpassword];

      setState(() {
        isloading = false;
      });
    });
  }

  save(BuildContext context) {
    final session = Provider.of<CommonSession>(context, listen: false);
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      if (pin == initialadminloginpin) {
        ShowSnackbar().open(
            context: context,
            scaffoldKey: _scaffoldKey,
            label: 'Please use a different PIN',
            status: 0,
            time: 2);
      } else {
        ShowLoading().open(context: context, key: _keyLoader);

        FirebaseFirestore.instance
            .collection(Dbkeys.admincredentials)
            .doc(Dbkeys.admincredentials)
            .update({
          Dbkeys.adminpin: pin,
          Dbkeys.adminfullname: fullname,
          Dbkeys.adminusername: username,
          Dbkeys.adminpassword: password,
          Dbkeys.adminloginhistory: FieldValue.arrayUnion([
            {
              Dbkeys.adminlogineventsTIME: DateTime.now(),
              Dbkeys.adminlogineventsTITLE:
                  Dbkeys.adminlogineventsTITLEcredchange,
              Dbkeys.adminlogineventsDESC:
                  'Admin login credentials changed by admin',
            }
          ]),
        }).then((value) async {
          ShowLoading().close(context: context, key: _keyLoader);
          session.setData(
            newfullname: fullname,
            newphotourl: photourl,
          );
          if (widget.callbackOnUpdate == null) {
            Navigator.of(context).pop();
          } else if (widget.callbackOnUpdate != null) {
            widget.callbackOnUpdate!();
          }
        }).catchError((err) async {
          final session = Provider.of<CommonSession>(context, listen: false);
          final observer = Provider.of<Observer>(context, listen: false);
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
              alerttitle: 'Admin credentials Change failed',
              alertdesc:
                  'Admin Login credentials cannot be changed. Check the admin credentials and help verify securily.\n[CAPTURED ERROR:$err]');
        });
      }
    } else {
      ShowSnackbar().open(
          context: context,
          scaffoldKey: _scaffoldKey,
          label: 'Please fill the required Credentials.',
          status: 0,
          time: 2);
    }
  }

  Future<bool> back() {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return WillPopScope(
        // ignore: missing_return
        onWillPop: widget.isFirstTime == true ? doubleTapTrigger : back,
        child: MyScaffold(
          isforcehideback: true,
          scaffoldkey: _scaffoldKey,
          title: 'Change Login Credentials',
          icon1press: isloading == true
              ? null
              : () {
                  save(context);
                },
          icondata1: Icons.done,
          body: isloading == true
              ? circularProgress()
              : ListView(children: [
                  Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          widget.isFirstTime == true
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 0, 12, 0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InputSquarePicture(
                                          iscontain: true,
                                          placeholder: '200x200',
                                          boxwidth: w / 2,
                                          title: 'Admin profile Photo',
                                          photourl: photourl,
                                          uploadfn:
                                              (file, filetype, basename) async {
                                            FirebaseUploader()
                                                .uploadFile(
                                                    context: context,
                                                    scaffoldkey: _scaffoldKey,
                                                    keyLoader: _keyLoader5,
                                                    file: file,
                                                    fileType: 'image',
                                                    filename:
                                                        'admin_cover' + '.png',
                                                    folder: DbStoragePaths
                                                        .adminFolder,
                                                    collection: DbStoragePaths
                                                        .adminCollection)
                                                .then((value) {
                                              setState(() {
                                                photourl = value;
                                              });
                                            }).then((value) async {
                                              await firestoreupdatedoc(
                                                  context: context,
                                                  scaffoldkey: _scaffoldKey,
                                                  keyloader: _keyLoader6,
                                                  collection:
                                                      Dbkeys.admincredentials,
                                                  document:
                                                      Dbkeys.admincredentials,
                                                  updatemap: {
                                                    Dbkeys.adminphotourl:
                                                        photourl,
                                                  });
                                              hidekeyboard(context);
                                            });
                                          },
                                          deletefn: () {
                                            FirebaseUploader()
                                                .deleteFile(
                                                    context: context,
                                                    scaffoldkey: _scaffoldKey,
                                                    isDeleteUsingUrl: true,
                                                    mykeyLoader: _keyLoader7,
                                                    fileType: 'image',
                                                    filename:
                                                        'admin_cover' + '.png',
                                                    folder: DbStoragePaths
                                                        .adminFolder,
                                                    collection: DbStoragePaths
                                                        .adminCollection)
                                                .then((isDeleted) {
                                              if (isDeleted == true) {
                                                setState(() {
                                                  photourl = null;
                                                });
                                              }
                                            }).then((value) async {
                                              await firestoreupdatedoc(
                                                  context: context,
                                                  scaffoldkey: _scaffoldKey,
                                                  keyloader: _keyLoader8,
                                                  collection:
                                                      Dbkeys.admincredentials,
                                                  document:
                                                      Dbkeys.admincredentials,
                                                  updatemap: {
                                                    Dbkeys.adminphotourl: null,
                                                  });
                                              hidekeyboard(context);
                                            });
                                          },
                                        ),
                                      ]),
                                ),
                          InpuTextBox(
                            title: 'Admin Fullname',
                            hinttext: 'Enter your Fullname',
                            autovalidate: true,
                            controller: tcfullname,
                            keyboardtype: TextInputType.name,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Numberlimits.adminfullname),
                            ],
                            onSaved: (val) {
                              fullname = val;
                            },
                            isboldinput: true,
                            validator: (val) {
                              if (val!.trim().length < 1) {
                                return 'Enter your fullname';
                              } else if (val.trim().length >
                                  Numberlimits.adminfullname) {
                                return 'Max. ${Numberlimits.adminfullname} characters allowed';
                              } else {
                                return null;
                              }
                            },
                          ),
                          
                          
                          InpuTextBox(
                            title: 'Admin Username',
                            hinttext: 'Enter a username',
                            autovalidate: true,
                            controller: tcusername,
                            keyboardtype: TextInputType.name,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Numberlimits.adminusername),
                            ],
                            onSaved: (val) {
                              username = val;
                            },
                            isboldinput: true,
                            validator: (val) {
                              if (val!.trim().length < 1) {
                                return 'Keep your desired username';
                              } else if (val.trim().length >
                                  Numberlimits.adminusername) {
                                return 'Max. ${Numberlimits.adminusername} characters allowed';
                              } else {
                                return null;
                              }
                            },
                          ),
                          InpuTextBox(
                            title: 'Admin Password',
                            hinttext: 'Enter a Password',
                            autovalidate: true,
                            obscuretext: true,
                            controller: tcpassword,
                            keyboardtype: TextInputType.name,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Numberlimits.adminpassword),
                              FilteringTextInputFormatter.deny(''),
                            ],
                            onSaved: (val) {
                              password = val;
                            },
                            isboldinput: true,
                            validator: (val) {
                              if (val!.trim().length < 1) {
                                return 'Keep a strong password';
                              } else if (val.trim().length >
                                  Numberlimits.adminpassword) {
                                return 'Max. ${Numberlimits.adminpassword} characters allowed';
                              } else {
                                return null;
                              }
                            },
                          ),
                          InpuTextBox(
                            obscuretext: true,
                            title: 'Security PIN',
                            hinttext: 'Enter 6-Digit PIN',
                            autovalidate: true,
                            keyboardtype: TextInputType.number,
                            controller: tcpin,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Numberlimits.adminpin),
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"),
                              ),
                            ],
                            onSaved: (val) {
                              pin = val;
                            },
                            isboldinput: true,
                            validator: (val) {
                              if (val!.trim().length < 1) {
                                return 'Keep a secret 6-Digit PIN  from 0 to 9';
                              } else if (val.trim().length >
                                  Numberlimits.adminpin) {
                                return 'Max. ${Numberlimits.adminpin} characters allowed';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      )),
                ]),
        ));
  }
}
