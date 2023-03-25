import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseApi.dart';
import 'package:thinkcreative_technologies/Services/firebaseServices/FirebaseUploader.dart';
import 'package:thinkcreative_technologies/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/Utils/Utils.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Widgets/DelayedFunction.dart';
import 'package:thinkcreative_technologies/Widgets/InputBox.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Widgets/hideKeyboard.dart';

class SendNotification extends StatefulWidget {
  final String? userphone;
  final bool issendtosingleuser;
  final String collection;
  final DocumentReference? refdata;
  final String notificationid;
  final Function? optionalOnUpdateCallback;

  SendNotification(
      {required this.issendtosingleuser,
      required this.collection,
      required this.refdata,
      this.optionalOnUpdateCallback,
      required this.notificationid,
      this.userphone});
  @override
  _SendNotificationState createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  // DateTime todayDate;
  // TimeOfDay todayTime;
  // DateTime todaydatetimeoverall;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController tcmessage = new TextEditingController();
  GlobalKey<State> _keyLoader1 =
      new GlobalKey<State>(debugLabel: '48757577575');
  GlobalKey<State> _keyLoader2 =
      new GlobalKey<State>(debugLabel: '7474748488484');
  GlobalKey<State> _keyLoader3 =
      new GlobalKey<State>(debugLabel: '848848484884');
  GlobalKey<State> _keyLoader4 = new GlobalKey<State>(debugLabel: 'rjrjrjrrr');
  GlobalKey<State> _keyLoader5 =
      new GlobalKey<State>(debugLabel: 'nffjfjjfjjgg');

  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_hhh');
  bool isautovalidatemode = false;

// 22 page variables-------
  String? notificationtitle;
  String? notificationdesc;
  String? notificationbnrurl;
  @override
  void initState() {
    super.initState();
    widget.refdata!.update({
      Dbkeys.nOTIFICATIONxxaction: Dbkeys.nOTIFICATIONactionNOPUSH,
      Dbkeys.nOTIFICATIONxxdesc: notificationdesc,
      Dbkeys.nOTIFICATIONxxtitle: notificationtitle,
      Dbkeys.nOTIFICATIONxxpageID: Dbkeys.pageIDAllNotifications,
      Dbkeys.nOTIFICATIONxxlastupdate: DateTime.now(),
      'list': FieldValue.arrayUnion([
        {
          Dbkeys.docid: widget.notificationid,
        }
      ])
    });
  }

  // ignore: missing_return
  Future<bool> _willPopCallback(BuildContext context) async {
    ShowConfirmDialog().open(
        context: context,
        rightbtnonpress: () async {
          Navigator.of(context).pop();
          await deleteIfPresent(context, widget.notificationid);
        });
    return false;
  }

  deleteIfPresent(BuildContext context, String docid) async {
    if (this.notificationbnrurl != null) {
      await FirebaseUploader()
          .deleteFile(
        context: context,
        scaffoldkey: _scaffoldKey,
        mykeyLoader: _keyLoader1,
        isDeleteUsingUrl: true,
        fileType: 'image',
        filename: widget.notificationid + '.png',
        url: notificationbnrurl,
        folder: widget.issendtosingleuser == true
            ? widget.userphone
            : widget.notificationid,
        collection: widget.issendtosingleuser == true
            ? DbStoragePaths.individualnotification
            : DbStoragePaths.allnotifications,
      )
          .then((isDeleted) {
        if (isDeleted == true) {
          setState(() {
            notificationbnrurl = null;
          });
        }
      });
    }

    await delayedFunction(
        setstatefn: () async {
          await FirebaseApi().runDELETEtransaction(
              isshowmsg: false,
              keyloader: _keyLoader5,
              scaffoldkey: _scaffoldKey,
              context: context,
              refdata: widget.refdata,
              compareKey: Dbkeys.docid,
              isusesecondfn: true,
              compareVal: widget.notificationid,
              secondfn: () {
                Navigator.of(context).pop();
              });
        },
        durationmilliseconds: 100);
  }

  save(
    BuildContext context,
  ) {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      AppConstants.isdemomode == true
          ? Utils.toast('Not Allowed in Demo App')
          : createInDatabase(context);
    } else {
      setState(() {
        isautovalidatemode = true;
      });
      ShowSnackbar().open(
        label: 'Please fill all the required fields.',
        context: context,
        scaffoldKey: _scaffoldKey,
      );
    }
  }

  createInDatabase(context) async {
    final session = Provider.of<CommonSession>(context, listen: false);
    hidekeyboard(context);
    await FirebaseApi().runDELETEtransaction(
      isshowmsg: false,
      keyloader: _keyLoader5,
      scaffoldkey: _scaffoldKey,
      context: context,
      refdata: widget.refdata,
      compareKey: Dbkeys.docid,
      isusesecondfn: false,
      compareVal: widget.notificationid,
    );
    Utils.toast('Sending.... Please wait!');
    await FirebaseApi().runUPDATEtransactionNotification(
        refdata: widget.refdata ??
            FirebaseFirestore.instance
                .collection(widget.collection)
                .doc(widget.userphone)
                .collection(DbPaths.collectionnotifications)
                .doc(widget.issendtosingleuser == true
                    ? DbPaths.collectionnotifications
                    : DbPaths.usersnotifications),
        isshowmsg: false,
        context: context,
        scaffoldkey: _scaffoldKey,
        isusesecondfn: true,
        isshowloader: false,
        totaldeleterange: 50,
        totallimitfordelete: 100,
        newmapnotificationcontent: {
          Dbkeys.docid: widget.notificationid,
          Dbkeys.nOTIFICATIONxxdesc: notificationdesc,
          Dbkeys.nOTIFICATIONxxtitle: notificationtitle,
          Dbkeys.nOTIFICATIONxximageurl: notificationbnrurl,
          Dbkeys.nOTIFICATIONxxlastupdate: DateTime.now(),
          Dbkeys.nOTIFICATIONxxauthor:
              session.uid + 'XXX' + AppConstants.apptype,
        },
        newmapnotification: {
          Dbkeys.nOTIFICATIONxxaction: Dbkeys.nOTIFICATIONactionPUSH,
          Dbkeys.nOTIFICATIONxxdesc: notificationdesc,
          Dbkeys.nOTIFICATIONxxtitle: notificationtitle,
          Dbkeys.nOTIFICATIONxxpageID: Dbkeys.pageIDAllNotifications,
          Dbkeys.nOTIFICATIONxxlastupdate: DateTime.now(),
          Dbkeys.nOTIFICATIONxxparentid: widget.userphone,
          Dbkeys.nOTIFICATIONxximageurl: notificationbnrurl,
          Dbkeys.nOTIFICATIONxxpagecompareval: widget.userphone,
          Dbkeys.nOTIFICATIONxxauthor:
              session.uid + 'XXX' + AppConstants.apptype,
        },
        secondfn: () {
          Navigator.of(context).pop();
          widget.optionalOnUpdateCallback!();
        });
  }

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () => _willPopCallback(context),
        child: MyScaffold(
          scaffoldkey: _scaffoldKey,
          title: 'Send New Notification',
          subtitle: 'ID: ' + widget.notificationid,
          leadingIconData: Icons.chevron_left,
          leadingIconPress: () {
            _willPopCallback(context);
          },
          icon1press: () {
            save(context);
          },
          icondata1: Icons.done,
          icondata2: Icons.close,
          icon2press: () {
            _willPopCallback(context);
          },
          body: ListView(children: [
            Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: InputBanner(
                        // iseditvisible: false,
                        boxwidth: w - 20,
                        placeholder: '900x465',
                        title: 'Notification Banner',
                        photourl: notificationbnrurl,
                        uploadfn: AppConstants.isdemomode == true
                            ? (file, filetype, basename) {
                                Utils.toast('Not Allowed in Demo App');
                              }
                            : (file, filetype, basename) async {
                                FirebaseUploader()
                                    .uploadFile(
                                  context: context,
                                  scaffoldkey: _scaffoldKey,
                                  keyLoader: _keyLoader1,
                                  file: file,
                                  fileType: 'image',
                                  filename: widget.notificationid + '.png',
                                  folder: widget.issendtosingleuser == true
                                      ? widget.userphone
                                      : widget.notificationid,
                                  collection: widget.issendtosingleuser == true
                                      ? DbStoragePaths.individualnotification
                                      : DbStoragePaths.allnotifications,
                                )
                                    .then((value) {
                                  setState(() {
                                    notificationbnrurl = value;
                                  });
                                  hidekeyboard(context);
                                }).then((value) async {
                                  await FirebaseApi().runUPDATEtransaction(
                                      keyloader: _keyLoader2,
                                      scaffoldkey: _scaffoldKey,
                                      context: context,
                                      refdata: widget.refdata,
                                      isusesecondfn: false,
                                      compareKey: Dbkeys.docid,
                                      compareVal: widget.notificationid,
                                      updatemap: {
                                        Dbkeys.nOTIFICATIONxximageurl:
                                            notificationbnrurl
                                      });
                                });

                                //  upload(context,);
                              },
                        deletefn: () async {
                          await FirebaseUploader()
                              .deleteFile(
                                  context: context,
                                  scaffoldkey: _scaffoldKey,
                                  mykeyLoader: _keyLoader3,
                                  isDeleteUsingUrl: true,
                                  fileType: 'image',
                                  filename: widget.notificationid + '.png',
                                  url: notificationbnrurl,
                                  folder: widget.issendtosingleuser == true
                                      ? widget.userphone
                                      : widget.notificationid,
                                  collection: widget.issendtosingleuser == true
                                      ? DbStoragePaths.individualnotification
                                      : DbStoragePaths.allnotifications)
                              .then((isDeleted) {
                            if (isDeleted == true) {
                              setState(() {
                                notificationbnrurl = null;
                              });
                            }
                            hidekeyboard(context);
                          }).then((value) async {
                            await FirebaseApi().runUPDATEtransaction(
                                keyloader: _keyLoader4,
                                scaffoldkey: _scaffoldKey,
                                context: context,
                                refdata: widget.refdata,
                                isusesecondfn: false,
                                compareKey: Dbkeys.docid,
                                compareVal: widget.notificationid,
                                updatemap: {
                                  Dbkeys.nOTIFICATIONxximageurl: null,
                                });
                          });
                        },
                      ),
                    ),
                    InpuTextBox(
                      title: 'Notification Title',
                      hinttext:
                          'Max ${Numberlimits.maxtitledigits} characters...',
                      minLines: 3,
                      maxLines: 4,
                      autovalidate: isautovalidatemode,
                      keyboardtype: TextInputType.name,
                      inputFormatter: [],
                      onSaved: (val) {
                        notificationtitle = val;
                      },
                      isboldinput: true,
                      validator: (val) {
                        if (val!.trim().length < 1) {
                          return 'Enter a Notification Title';
                        } else if (val.trim().length >
                            Numberlimits.maxtitledigits) {
                          return 'Max. ${Numberlimits.maxtitledigits} characters allowed';
                        } else {
                          return null;
                        }
                      },
                    ),
                    InpuTextBox(
                      title: 'Notification Description',
                      hinttext: 'Max. ${Numberlimits.maxdescdigits} characters',
                      minLines: 13,
                      maxLines: 22,
                      autovalidate: isautovalidatemode,
                      keyboardtype: TextInputType.name,
                      inputFormatter: [],
                      onSaved: (val) {
                        notificationdesc = val;
                      },
                      isboldinput: true,
                      validator: (val) {
                        if (val!.trim().length < 1) {
                          return 'Enter Notification Description';
                        } else if (val.trim().length >
                            Numberlimits.maxdescdigits) {
                          return 'Max. ${Numberlimits.maxdescdigits} characters allowed';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                )),
          ]),
        ));
  }
}
