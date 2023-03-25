import 'dart:core';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Services/providers/Observer.dart';
import 'package:thinkcreative_technologies/Widgets/Buttons.dart';
import 'package:thinkcreative_technologies/Widgets/CustomCard.dart';
import 'package:thinkcreative_technologies/Widgets/InputBox.dart';
import 'package:thinkcreative_technologies/Widgets/InputFields.dart';
import 'package:thinkcreative_technologies/Widgets/MediaQuery/mediaquerytools.dart';
import 'package:thinkcreative_technologies/Widgets/MyScaffold.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/loadingDialog.dart';
import 'package:thinkcreative_technologies/Widgets/hideKeyboard.dart';

class SearchUser extends StatefulWidget {
  final String searchtype;
  SearchUser({required this.searchtype});
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  bool isloading = false;
  String? message;
  dynamic userDoc;
  String? phonenumber;
  String? phonecode;
  String? uid;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  searchUser({DocumentReference? docRef, Query? queryRef}) async {
    final observer = Provider.of<Observer>(context, listen: false);
    setState(() {
      isloading = true;
    });
    if (docRef == null) {
      await queryRef!.get().then((query) async {
        if (query.docs.length > 0) {
          message = null;
          userDoc = query.docs[0].data();
          isloading = false;
          setState(() {});
        } else {
          message = 'User not found.';

          isloading = false;
          setState(() {});
        }
      }).catchError((err) {
        message = observer.isshowerrorlog == false
            ? 'Error Occured while Searching User. Please try again !'
            : 'Error Occured while Searching User. ERROR: $err';
        userDoc = null;
        isloading = false;
        setState(() {});
      });
    } else {
      await docRef.get().then((doc) async {
        if (doc.exists) {
          message = null;
          userDoc = doc.data();
          isloading = false;
          setState(() {});
        } else {
          message = 'User not found.';

          isloading = false;
          setState(() {});
        }
      }).catchError((err) {
        message = observer.isshowerrorlog == false
            ? 'Error Occured while Searching User. Please try again !'
            : 'Error Occured while Searching User. ERROR: $err';
        userDoc = null;
        isloading = false;
        setState(() {});
      });
    }
  }

  Widget userwidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MtCustomfontBold(
          textalign: TextAlign.left,
          text: '  Search Result :',
          fontsize: 17,
        ),
        Divider(),
        UserCard(
          isProfileFetchedFromProvider: false,
          margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
          docMap: userDoc,
          isswitchshow: false,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: widget.searchtype == 'byphone'
          ? 'Search User using Phone'
          : widget.searchtype == 'byuid'
              ? 'Search User using UID'
              : 'Search by Name',
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Form(
              key: _formKey,
              child: widget.searchtype == 'byphone'
                  ? MobileInputWithOutline(
                      buttonhintTextColor: Mycolors.grey,
                      borderColor: Mycolors.grey.withOpacity(0.2),
                      // controller: _phoneNo,
                      initialCountryCode: AppConstants.defaultcountrycodeISO,
                      onSaved: (phone) {
                        setState(() {
                          phonecode = phone?.countryCode;
                          phonenumber = phone?.number;

                          // istyping = true;
                        });
                      },
                    )
                  : widget.searchtype == 'byuid'
                      ? InpuTextBox(
                          hinttext: 'Enter Firebase User UID',
                          autovalidate: true,
                          keyboardtype: TextInputType.name,
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(
                                Numberlimits.maxuiddigits),
                          ],
                          onSaved: (val) {
                            uid = val;
                          },
                          isboldinput: true,
                          validator: (val) {
                            if (val!.trim().length < 1) {
                              return 'Enter User UID generated by Firebase Authentication';
                            } else if (val.trim().length >
                                Numberlimits.maxuiddigits) {
                              return 'Max. ${Numberlimits.maxuiddigits} characters allowed';
                            } else {
                              return null;
                            }
                          },
                        )
                      : InpuTextBox(
                          hinttext: 'Type user name.....',
                          autovalidate: false,
                          keyboardtype: TextInputType.name,
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(
                                Numberlimits.maxnamedigits),
                          ],
                          onSaved: (val) {
                            uid = val;
                          },
                          isboldinput: true,
                        )),
          SizedBox(
            height: 20,
          ),
          MySimpleButton(
            buttoncolor: Mycolors.greenbuttoncolor,
            buttontext: 'SEARCH',
            onpressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print('$uid');
                hidekeyboard(context);
                searchUser(
                    docRef: widget.searchtype == 'byphone'
                        ? FirebaseFirestore.instance
                            .collection(DbPaths.collectionusers)
                            .doc('$phonecode$phonenumber')
                        : null,
                    queryRef: widget.searchtype == 'byphone'
                        ? null
                        : FirebaseFirestore.instance
                            .collection(DbPaths.collectionusers)
                            .where('id', isEqualTo: uid));
              }
            },
          ),
          Center(
            child: isloading == true
                ? Padding(
                    padding: EdgeInsets.only(top: height(context) / 4.4),
                    child: circularProgress())
                : message != null
                    ? Padding(
                        padding: EdgeInsets.only(top: height(context) / 4.4),
                        child: MtCustomfontRegular(text: message),
                      )
                    : userDoc != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: userwidget(context))
                        : SizedBox(),
          )
        ],
      ),
    );
  }
}
