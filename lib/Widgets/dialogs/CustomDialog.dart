import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Widgets/InputBox.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';

class ShowCustomAlertDialog {
  open({
    String? title,
    required BuildContext context,
    GlobalKey? scaffoldkey,
    String? description,
    String? leftbuttontext,
    Function? leftbuttononpress,
    Function? rightbuttononpress,
    Color? leftbuttoncolor,
    Color? rightbuttoncolor,
    String? rightbuttontext,
    String? dialogtype,
    String? errorlog,
    bool? isshowerrorlog,
  }) {
    showDialog(
        barrierLabel: 'Close',
        barrierDismissible: true,
        context: context,
        builder: (v) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Consts.padding),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: Consts.avatarRadius + Consts.padding,
                      bottom: Consts.padding,
                      left: Consts.padding,
                      right: Consts.padding,
                    ),
                    margin: EdgeInsets.only(top: Consts.avatarRadius),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(Consts.padding),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // To make the card compact
                      children: <Widget>[
                        Text(
                          title ?? 'Failed !',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          description ?? 'Some error occured !',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            isshowerrorlog == true
                                ? Align(
                                    alignment: Alignment.bottomLeft,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: new Text("ERROR LOG"),
                                                content: new Text(
                                                    errorlog.toString()),
                                              );
                                            });
                                      },
                                      child: Text(
                                        'SHOW ERROR LOG',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 70,
                                  ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                ),
                                onPressed: rightbuttononpress == null
                                    ? () {
                                        Navigator.pop(context);
                                      }
                                    : () {
                                        rightbuttononpress();
                                      },
                                child: Text(rightbuttontext ?? 'OK'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  Positioned(
                    left: Consts.padding,
                    right: Consts.padding,
                    child: CircleAvatar(
                      backgroundColor: dialogtype == 'alert'
                          ? Mycolors.orange
                          : dialogtype == 'error'
                              ? Mycolors.red
                              : dialogtype == 'success'
                                  ? Mycolors.greenbuttoncolor
                                  : dialogtype == 'notification'
                                      ? Mycolors.greenbuttoncolor
                                      : Mycolors.primary,
                      radius: Consts.avatarRadius,
                      child: Icon(
                        dialogtype == 'alert'
                            ? Icons.info_rounded
                            : dialogtype == 'error'
                                ? Icons.error_rounded
                                : dialogtype == 'success'
                                    ? Icons.check_circle
                                    : dialogtype == 'notification'
                                        ? Icons.notifications
                                        : Icons.info,
                        color: Colors.white,
                        size: 70.0,
                      ),
                    ),
                  ),
                  //...top circlular image part,
                ],
              ));
        });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return
  // }
}

class Consts {
  Consts._();
  static const double padding = 16.0;
  static const double avatarRadius = 56.0;
}

class ShowConfirmDialog {
  open(
      {required BuildContext context,
      String? title,
      String? subtitle,
      String? rightbtntext,
      String? leftbtntext,
      Function? leftbtnonpress,
      Function? rightbtnonpress}) {
    showGeneralDialog(
        barrierLabel: 'Close',
        barrierDismissible: true,
        context: context,
        barrierColor: Colors.black54, // space around dialog
        transitionDuration: Duration(milliseconds: 300),
        transitionBuilder: (context, a1, a2, child) {
          return ScaleTransition(
              scale: CurvedAnimation(
                  parent: a1,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.easeOutBack),
              child: AlertDialog(
                actions: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        leftbtntext ?? 'NO',
                        style: TextStyle(
                            color:
                                rightbtntext != null && rightbtntext == 'REMOVE'
                                    ? Mycolors.black
                                    : null),
                      ),
                      onPressed: leftbtnonpress == null
                          ? () {
                              Navigator.pop(context);
                            }
                          : () {
                              Navigator.pop(context);
                            }),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      rightbtntext ?? 'YES',
                      style: TextStyle(
                          color:
                              rightbtntext != null && rightbtntext == 'REMOVE'
                                  ? Mycolors.red
                                  : null),
                    ),
                    onPressed: rightbtnonpress == null
                        ? () {
                            Navigator.pop(context);
                          }
                        : () {
                            rightbtnonpress();
                          },
                  )
                ],
                title: MtCustomfontBold(
                  text: title ?? "Want to go Back?",
                  fontsize: 17,
                  color: Mycolors.black,
                ),
                content: MtCustomfontMedium(
                    fontsize: 14,
                    text: subtitle ?? "Are you sure you want to go back"),
              ));
        },
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return SizedBox();
        });
  }
}

class ShowConfirmWithInputTextDialog {
  open({
    required BuildContext context,
    String? title,
    String? hinttext,
    String? subtitle,
    String? rightbtntext,
    String? leftbtntext,
    Function? leftbtnonpress,
    bool? isshowform,
    TextEditingController? controller,
    Function? rightbtnonpress,
  }) {
    showGeneralDialog(
      barrierLabel: 'Close',
      barrierDismissible: true,
      context: context,
      barrierColor: Colors.black54, // space around dialog
      transitionDuration: Duration(milliseconds: 300),
      transitionBuilder: (context, a1, a2, child) {
        return ScaleTransition(
            scale: CurvedAnimation(
                parent: a1,
                curve: Curves.fastLinearToSlowEaseIn,
                reverseCurve: Curves.easeOutBack),
            child: AlertDialog(
              actions: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.black,
                    ),
                    child: Text(leftbtntext ?? 'NO'),
                    onPressed: leftbtnonpress == null
                        ? () {
                            Navigator.pop(context);
                          }
                        : () {
                            Navigator.pop(context);
                          }),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.black,
                  ),
                  child: Text(rightbtntext ?? 'YES'),
                  onPressed: rightbtnonpress == null
                      ? () {
                          Navigator.pop(context);
                        }
                      : () {
                          rightbtnonpress();
                        },
                )
              ],
              title: MtPoppinsSemiBold(
                text: title ?? "Want to go Back?",
                fontsize: 18,
                color: Mycolors.black,
              ),
              content: isshowform == false
                  ? Text(subtitle ?? "Are you sure you want to go back")
                  : Container(
                      height: MediaQuery.of(context).size.height / 2.7,
                      child: Column(
                        children: [
                          Text(subtitle ?? "Are you sure you want to go back"),
                          SizedBox(
                            height: 10,
                          ),
                          InpuTextBox(
                            controller: controller,
                            subtitle: hinttext ??
                                'This Block Reason will be shown to user.',
                            hinttext: hinttext == null
                                ? 'Reason to Block.'
                                : "Reason",
                            maxLines: 5,
                            minLines: 2,
                            autovalidate: true,
                            maxcharacters: 100,
                            validator: (val) {
                              if (val!.trim().length < 1) {
                                return 'Please mention a reason.';
                              } else {
                                return null;
                              }
                            },
                          )
                        ],
                      )),
            ));
      },
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return SizedBox();
      },
    );
  }
}

class ShowSnackbar {
  open({
    BuildContext? context,
    required GlobalKey<ScaffoldState> scaffoldKey,
    String? label,
    int? status,
    int? time,
  }) {
    // scaffoldKey.currentState!.removeCurrentSnackBar();
    // // ignore: deprecated_member_use
    // scaffoldKey.currentState!.showSnackBar(
    //   SnackBar(
    //     backgroundColor: status == 0
    //         ? Colors.black
    //         : status == 2
    //             ? Mycolors.green
    //             : Mycolors.red,
    //     duration: Duration(seconds: time ?? 1),
    //     content: Text(label ?? 'Failed. Some Error occured !'),
    //   ),
    // );
    if (label != null && label != "") {
      Fluttertoast.showToast(msg: label);
    }
  }

  close({
    BuildContext? context,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    // ignore: deprecated_member_use
    // scaffoldKey.currentState!.removeCurrentSnackBar();
  }
}

class ShowLoading {
  open({
    required BuildContext context,
    GlobalKey? key,
  }) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
    return showDialog<void>(
        context: context,
        barrierLabel: 'Close',
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: AnimatedPadding(
                key: key,
                padding: MediaQuery.of(context).viewInsets +
                    const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 44.0),
                duration: insetAnimationDuration,
                curve: insetAnimationCurve,
                child: MediaQuery.removeViewInsets(
                  removeLeft: true,
                  removeTop: true,
                  removeRight: true,
                  removeBottom: true,
                  context: context,
                  child: Center(
                    child: SizedBox(
                      width: 55,
                      height: 55,
                      child: Material(
                        elevation: 24.0,
                        color: Theme.of(context).dialogBackgroundColor,
                        type: MaterialType.card,
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new CircularProgressIndicator(
                              strokeWidth: 3.5,
                              valueColor:
                                  AlwaysStoppedAnimation(Mycolors.secondary),
                            ),
                          ],
                        ),
                        shape: _defaultDialogShape,
                      ),
                    ),
                  ),
                ),
              ));
        });
  }

  close({
    BuildContext? context,
    required GlobalKey key,
  }) {
    Navigator.of(key.currentContext!, rootNavigator: true).pop(); //
  }
}

class ShowLoadingPlsWait {
  open(
      {required BuildContext context,
      GlobalKey? key,
      String? title,
      String? subtitle}) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    // RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(32.0)));
    return showDialog<void>(
        context: context,
        barrierLabel: 'Close',
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: AnimatedPadding(
                  key: key,
                  // padding: MediaQuery.of(context).viewInsets +
                  //     const EdgeInsets.symmetric(
                  //         horizontal: 60.0, vertical: 44.0),
                  padding: EdgeInsets.all(0),
                  duration: insetAnimationDuration,
                  curve: insetAnimationCurve,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    content: Container(
                        width: 180.0,
                        height: 50.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.only(left: 19.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title ?? "",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    subtitle ?? "Please wait...",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  )));
        });
  }

  close({
    BuildContext? context,
    required GlobalKey key,
  }) {
    Navigator.of(key.currentContext!, rootNavigator: true).pop(); //
  }
}

class ShowWidgetLoading {
  open(BuildContext context, double? valueProgress) {
    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Center(
        child: SizedBox(
          width: 55,
          height: 55,
          child: new CircularProgressIndicator(
            value: valueProgress,
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(Mycolors.secondary),
          ),
        ),
      ),
    );
  }
}
