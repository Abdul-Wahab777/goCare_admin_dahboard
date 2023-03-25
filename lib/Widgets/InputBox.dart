import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:thinkcreative_technologies/Configs/NumberLimits.dart';
import 'package:thinkcreative_technologies/Widgets/dialogs/CustomDialog.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Widgets/PlaceholderGenerate.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';
import 'package:thinkcreative_technologies/Widgets/myVerticaldivider.dart';
import 'package:path/path.dart' as p;

class InpuTextBox extends StatefulWidget {
  final Color? boxbcgcolor;
  final Color? boxbordercolor;
  final double? boxcornerradius;
  final double? fontsize;
  final double? boxwidth;
  final double? boxborderwidth;
  final double? boxheight;
  final EdgeInsets? forcedmargin;
  final EdgeInsets? contentpadding;
  final double? letterspacing;
  final double? leftrightmargin;
  final TextEditingController? controller;
  final String? Function(String? val)? validator;
  final Function(String? val)? onSaved;
  final Function(String val)? onchanged;
  final TextInputType? keyboardtype;
  final TextCapitalization? textCapitalization;

  final String? title;
  final String? subtitle;
  final String? hinttext;
  final String? placeholder;
  final int? maxLines;
  final int? minLines;
  final int? maxcharacters;
  final bool? isboldinput;
  final bool? obscuretext;
  final bool? autovalidate;
  final bool? disabled;
  final bool? showIconboundary;
  final Widget? sufficIconbutton;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefixIconbutton;
final Color? titleColor;
  InpuTextBox(
      {
        this.titleColor,
        this.controller,
      this.boxbordercolor,
      this.boxheight,
      this.fontsize,
      this.leftrightmargin,
      this.letterspacing,
      this.forcedmargin,
      this.boxwidth,
      this.boxcornerradius,
      this.boxbcgcolor,
      this.hinttext,
      this.boxborderwidth,
      this.onSaved,
      this.textCapitalization,
      this.onchanged,
      this.contentpadding,
      this.placeholder,
      this.showIconboundary,
      this.subtitle,
      this.disabled,
      this.keyboardtype,
      this.inputFormatter,
      this.validator,
      this.title,
      this.maxLines,
      this.autovalidate,
      this.prefixIconbutton,
      this.maxcharacters,
      this.isboldinput,
      this.obscuretext,
      this.sufficIconbutton,
      this.minLines});
  @override
  _InpuTextBoxState createState() => _InpuTextBoxState();
}

class _InpuTextBoxState extends State<InpuTextBox> {
  bool isobscuretext = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isobscuretext = widget.obscuretext ?? false;
    });
  }

  changeobscure() {
    setState(() {
      isobscuretext = !isobscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Align(
      child: Container(
        margin: EdgeInsets.fromLTRB(
            widget.leftrightmargin ?? 8, 10, widget.leftrightmargin ?? 8, 10),
        width: widget.boxwidth ?? w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title == null
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 7, 4),
                    child: MtPoppinsSemiBold(
                      color:widget.titleColor?? Mycolors.grey,
                      fontsize: 13,
                      text: widget.title ?? 'Group',
                    ),
                  ),
            widget.subtitle != null ? SizedBox(height: 4) : SizedBox(height: 0),
            Container(
              // color: Colors.white,
              // height: widget.boxheight ?? 50,
              // decoration: BoxDecoration(
              //     color: widget.boxbcgcolor ?? Colors.white,
              //     border: Border.all(
              //         color:
              //             widget.boxbordercolor ?? Mycolors.grey.withOpacity(0.2),
              //         style: BorderStyle.solid,
              //         width: 1.8),
              //     borderRadius: BorderRadius.all(
              //         Radius.circular(widget.boxcornerradius ?? 5))),
              child: TextFormField(
                minLines: widget.minLines ?? null,
                maxLines: widget.maxLines ?? 1,
                controller: widget.controller ?? null,
                obscureText: isobscuretext,
                onSaved: widget.onSaved ?? (val) {},
                readOnly: widget.disabled ?? false,
                onChanged: widget.onchanged ?? (val) {},
                maxLength: widget.maxcharacters ?? null,
                validator: widget.validator ?? null,
                keyboardType: widget.keyboardtype ?? null,
                autovalidateMode: widget.autovalidate == true
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                inputFormatters: widget.inputFormatter ?? [],
                textCapitalization:
                    widget.textCapitalization ?? TextCapitalization.sentences,
                style: TextStyle(
                  letterSpacing: widget.letterspacing ?? null,
                  fontSize: widget.fontsize ?? 15,
                  fontWeight: widget.isboldinput == true
                      ? FontWeight.w600
                      : FontWeight.w400,
                  height: 1.3,
                  // fontFamily:
                  //     widget.isboldinput == true ? 'NotoBold' : 'NotoRegular',
                  color: Mycolors.black,
                ),
                decoration: InputDecoration(
                    prefixIcon: widget.prefixIconbutton != null
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    width: widget.boxborderwidth ?? 1.5,
                                    color: widget.showIconboundary == true ||
                                            widget.showIconboundary == null
                                        ? Mycolors.greylightcolor
                                        : Colors.transparent),
                              ),
                              // color: Colors.white,
                            ),
                            margin: EdgeInsets.only(
                                left: 2, right: 5, top: 2, bottom: 2),
                            // height: 45,
                            alignment: Alignment.center,
                            width: 50,
                            child: widget.prefixIconbutton != null
                                ? widget.prefixIconbutton
                                : null)
                        : null,
                    suffixIcon: widget.sufficIconbutton != null ||
                            widget.obscuretext == true
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    width: widget.boxborderwidth ?? 1.5,
                                    color: widget.showIconboundary == true ||
                                            widget.showIconboundary == null
                                        ? Mycolors.greylightcolor
                                        : Colors.transparent),
                              ),
                              // color: Colors.white,
                            ),
                            margin: EdgeInsets.only(
                                left: 2, right: 5, top: 2, bottom: 2),
                            // height: 45,
                            alignment: Alignment.center,
                            width: 50,
                            child: widget.sufficIconbutton != null
                                ? widget.sufficIconbutton
                                : widget.obscuretext == true
                                    ? IconButton(
                                        icon: Icon(
                                            isobscuretext == true
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Mycolors.greytext),
                                        onPressed: () {
                                          changeobscure();
                                        })
                                    : null)
                        : null,
                    filled: true,
                    fillColor: widget.boxbcgcolor ?? Colors.white,
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius:
                          BorderRadius.circular(widget.boxcornerradius ?? 1),
                      borderSide: BorderSide(
                          color:
                              widget.boxbordercolor ?? Mycolors.greylightcolor,
                          width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius:
                          BorderRadius.circular(widget.boxcornerradius ?? 1),
                      borderSide:
                          BorderSide(color: Mycolors.primary, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.boxcornerradius ?? 1),
                        borderSide: BorderSide(color: Mycolors.grey)),
                    contentPadding: widget.contentpadding ??
                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // labelText: 'Password',
                    hintText: widget.hinttext ?? '',
                    // fillColor: widget.boxbcgcolor ?? Colors.white,

                    hintStyle: TextStyle(
                        letterSpacing: widget.letterspacing ?? 1.5,
                        color: Mycolors.greytext,
                        fontSize: 14,
                        fontWeight: FontWeight.w300)),
              ),
            ),
            widget.subtitle == null
                ? SizedBox(height: 0)
                : Padding(
                    padding: const EdgeInsets.fromLTRB(4, 6, 7, 2),
                    child: MtCustomfontRegular(
                      fontsize: 12,
                      lineheight: 1.2,
                      color: Mycolors.greytext,
                      text: widget.subtitle ?? 'Sub - Title',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class InputSwitch extends StatefulWidget {
  final Color? boxbcgcolor;
  final Color? boxbordercolor;
  final double? boxborderwidth;
  final double? boxcornerradius;
  final double? fontsize;
  final double? boxwidth;
  final double? boxheight;
  final String? title;
  final String? onString;
  final String? offString;
  final String? subtitle;
  final Function(bool val)? onChanged;
  final bool? initialbool;
  InputSwitch({
    this.boxcornerradius,
    this.boxborderwidth,
    this.fontsize,
    this.boxbcgcolor,
    this.onChanged,
    this.onString,
    this.offString,
    this.boxbordercolor,
    this.title,
    this.initialbool,
    this.subtitle,
    this.boxwidth,
    this.boxheight,
  });
  @override
  _InputSwitchState createState() => _InputSwitchState();
}

class _InputSwitchState extends State<InputSwitch> {
  bool myinitialbool = false;
  // TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    myinitialbool = widget.initialbool ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Align(
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
        width: widget.boxwidth ?? w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 7, 5),
              child: MtPoppinsSemiBold(
                color: Mycolors.grey,
                fontsize: 13,
                text: widget.title ?? '',
              ),
            ),
            widget.subtitle != null ? SizedBox(height: 4) : SizedBox(height: 0),
            Container(
              // color: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
              height: widget.boxheight ?? 50,
              decoration: BoxDecoration(
                  color: widget.boxbcgcolor ?? Colors.white,
                  border: Border.all(
                      color: widget.boxbordercolor ?? Mycolors.greylightcolor,
                      style: BorderStyle.solid,
                      width: widget.boxborderwidth ?? 1.5),
                  borderRadius: BorderRadius.all(
                      Radius.circular(widget.boxcornerradius ?? 0))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: MtCustomfontRegular(
                        text: myinitialbool == true
                            ? widget.onString ?? 'True'
                            : widget.offString ?? 'False',
                        color: Mycolors.grey,
                        fontsize: 14,
                      )),
                  Container(
                    margin: EdgeInsets.only(right: 3),
                    width: 50.0,
                    child: FlutterSwitch(
                        activeText: '',
                        inactiveText: '',
                        width: 46.0,
                        activeColor: Mycolors.green.withOpacity(0.8),
                        inactiveColor: Mycolors.red,
                        height: 19.0,
                        valueFontSize: 12.0,
                        toggleSize: 18.0,
                        value: widget.initialbool!,
                        // isshowblockedonly == true
                        //     ? false
                        //     : isshowapprovedonly == true
                        //         ? true
                        //         : oldlist[i]['status'] == 1
                        //             ? true
                        //             : oldlist[i]['status'] == 2
                        //                 ? false
                        //                 : false,
                        borderRadius: 25.0,
                        padding: 3.0,
                        showOnOff: true,
                        onToggle: (val) {
                          widget.onChanged!(val);
                        }),
                  ),
                ],
              ),
            ),
            widget.subtitle == null
                ? SizedBox(height: 4)
                : Padding(
                    padding: const EdgeInsets.fromLTRB(4, 6, 7, 2),
                    child: MtCustomfontRegular(
                      fontsize: 12,
                      lineheight: 1.2,
                      color: Mycolors.greytext,
                      text: widget.subtitle ?? 'Sub - Title',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class InputGroup2large extends StatefulWidget {
  final Color? boxbcgcolor;
  final Color? boxbordercolor;
  final double? boxborderwidth;
  final double? boxcornerradius;
  final double? fontsize;
  final double? boxwidth;
  final double? boxheight;
  final String? title;
  final String? val1;
  final String? val2;
  final String? subtitle;
  final String? selectedvalue;
  final Function(String? val)? onChanged;

  InputGroup2large({
    this.boxcornerradius,
    this.boxborderwidth,
    this.fontsize,
    this.boxbcgcolor,
    this.boxbordercolor,
    this.val1,
    this.val2,
    this.title,
    this.subtitle,
    this.selectedvalue,
    this.onChanged,
    this.boxwidth,
    this.boxheight,
  });
  @override
  _InputGroup2largeState createState() => _InputGroup2largeState();
}

class _InputGroup2largeState extends State<InputGroup2large> {
  // String myvalue;
  @override
  void initState() {
    super.initState();
    //  widget.selectedvalue ;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Align(
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
        width: widget.boxwidth ?? w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 7, 5),
              child: MtPoppinsSemiBold(
                color: Mycolors.grey,
                fontsize: 13,
                text: widget.title ?? 'Group',
              ),
            ),
            widget.subtitle != null ? SizedBox(height: 4) : SizedBox(height: 0),
            Container(
              // color: Colors.white,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              height: widget.boxheight ?? 50,
              decoration: BoxDecoration(
                  color: widget.boxbcgcolor ?? Colors.white,
                  border: Border.all(
                      color: widget.boxbordercolor ?? Mycolors.greylightcolor,
                      style: BorderStyle.solid,
                      width: widget.boxborderwidth ?? 1.5),
                  borderRadius: BorderRadius.all(
                      Radius.circular(widget.boxcornerradius ?? 0))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                      flex: 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 35,
                              child: new Radio(
                                focusColor: Mycolors.greytext,
                                hoverColor: Mycolors.greytext,
                                activeColor: Mycolors.primary,
                                value: widget.val1,
                                groupValue: widget.selectedvalue,
                                onChanged: (dynamic val) {
                                  // setState(() {
                                  //   myvalue = val;
                                  // });
                                  widget.onChanged!(val);
                                },
                              ),
                            ),
                            Container(
                              width: w / 3,
                              child: MtCustomfontRegular(
                                lineheight: 1.12,
                                fontsize: 14,
                                text: widget.val1,
                              ),
                            )
                          ])),
                  myverticaldivider(
                      height: 55,
                      thickness: widget.boxborderwidth ?? 1.5,
                      marginwidth: 0),
                  new Expanded(
                      flex: 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 35,
                              child: new Radio(
                                focusColor: Mycolors.greytext,
                                hoverColor: Mycolors.greytext,
                                activeColor: Mycolors.primary,
                                value: widget.val2,
                                groupValue: widget.selectedvalue,
                                onChanged: (dynamic val) {
                                  // setState(() {
                                  //   myvalue = val;
                                  // });
                                  widget.onChanged!(val);
                                },
                              ),
                            ),
                            Container(
                              width: w / 3,
                              child: MtCustomfontRegular(
                                lineheight: 1.12,
                                fontsize: 14,
                                text: widget.val2,
                              ),
                            )
                          ])),
                ],
              ),
            ),
            widget.subtitle == null
                ? SizedBox(height: 4)
                : Padding(
                    padding: const EdgeInsets.fromLTRB(4, 6, 7, 2),
                    child: MtCustomfontRegular(
                      fontsize: 12,
                      lineheight: 1.2,
                      color: Mycolors.greytext,
                      text: widget.subtitle ?? 'Sub - Title',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class InputBanner extends StatefulWidget {
  final Color? boxbcgcolor;
  final Color? boxbordercolor;
  final double? boxborderwidth;
  final double? boxcornerradius;
  final double? fontsize;
  final EdgeInsets? margin;
  final double? boxwidth;
  final double? boxheight;
  final int? maxsize;
  final bool? iseditvisible;
  final String? title;
  final String? placeholder;
  final bool? iscontain;
  final String? subtitle;
  final String? photourl;
  final Function(String val)? fetchurl;
  final Function(File file, String fietype, String basename)? uploadfn;
  final Function()? deletefn;

  InputBanner({
    this.boxcornerradius,
    this.boxborderwidth,
    this.fontsize,
    this.margin,
    this.photourl,
    this.maxsize,
    this.boxbcgcolor,
    this.uploadfn,
    this.iscontain,
    this.deletefn,
    this.boxbordercolor,
    this.placeholder,
    this.title,
    this.fetchurl,
    this.subtitle,
    this.boxwidth,
    this.iseditvisible,
    this.boxheight,
  });
  @override
  _InputBannerState createState() => _InputBannerState();
}

class _InputBannerState extends State<InputBanner> {
  File? file;
  Future filePicker(BuildContext context, String fileType, int maxSize) async {
    if (await Permission.storage.request().isGranted) {
      try {
        if (fileType == 'image') {
          await FilePicker.platform
              .pickFiles(type: FileType.image)
              .then((value) async {
            if (value == null) {
            } else {
              var file = File(value.files[0].path!);

              if (file.lengthSync() / 1000000 > maxSize) {
                ShowCustomAlertDialog().open(
                    context: context,
                    isshowerrorlog: false,
                    title: 'Upload Failed.',
                    description: Numberlimits.maxFileSizeExceededError1 +
                        '$maxSize MB. \n' +
                        Numberlimits.maxFileSizeExceededError2);
              } else {
                if (file.uri
                            .toString()
                            .substring(file.uri.toString().lastIndexOf(".")) !=
                        '.png' &&
                    file.uri
                            .toString()
                            .substring(file.uri.toString().lastIndexOf(".")) !=
                        '.jpeg' &&
                    file.uri
                            .toString()
                            .substring(file.uri.toString().lastIndexOf(".")) !=
                        '.jpg') {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                              )
                            ],
                            title: Text("File type Not Supported"),
                            content: Text(
                                "Sorry ! You can not upload this file. You can only Upload Image files (like - .png, .jpeg). Please try again and select a Image file."),
                          ));
                } else {
                  String basenameold = '';
                  basenameold = p.basename(file.path);
                  setState(() {
                    basenameold = p.basename(file.path);
                  });
                  await widget.uploadfn!(
                    file,
                    fileType,
                    basenameold,
                  );
                }
              }
            }
          });
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sorry...'),
                content: Text('Unsupported exception: $e'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  )
                ],
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: <Widget>[
                  TextButton(
                      child: Text('OPEN APP SETTINGS'),
                      onPressed: () {
                        Navigator.pop(context);
                        openAppSettings();
                      })
                ],
                title: Text(
                  "Permission Not Granted !",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                content: Text(
                    "Please Allow ${AppConstants.appname} app to read & write Storage to pick particular file which you select.\n\n1.  Tap on OPEN APP SETTINGS  \n\n2.  Go to PERMISSIONS          \n\n3.  Allow / Turn On the Storage Switch."),
              ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Align(
      child: Container(
          margin: widget.margin ?? EdgeInsets.fromLTRB(8, 10, 8, 10),
          width: widget.boxwidth ?? w,
          height: widget.boxheight ?? null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title == null
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 7, 5),
                      child: MtPoppinsSemiBold(
                        color: Mycolors.grey,
                        fontsize: 13,
                        text: widget.title ?? 'Title',
                      ),
                    ),
              widget.subtitle != null
                  ? SizedBox(height: 4)
                  : SizedBox(height: 0),
              Container(
                // color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: widget.boxwidth! * 0.5,
                width: widget.boxwidth ?? w,
                decoration: BoxDecoration(
                    color: widget.boxbcgcolor ?? Colors.white,
                    border: Border.all(
                        color: widget.boxbordercolor ?? Mycolors.greylightcolor,
                        style: BorderStyle.solid,
                        width: widget.boxborderwidth ?? 1.5),
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.boxcornerradius ?? 0))),
                child: widget.photourl == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widget.boxwidth! < 235
                              ? SizedBox(height: 0, width: 0)
                              : Center(
                                  child: Icon(
                                  Icons.photo,
                                  color: Mycolors.greylightcolor,
                                  size: 53,
                                )),
                          widget.boxwidth! < 105
                              ? SizedBox(height: 0, width: 0)
                              : Text(
                                  widget.placeholder == null
                                      ? '1024x465 px (Max. ${widget.maxsize ?? Numberlimits.maxImageFileUpload} MB)'
                                      : '${widget.placeholder} px (Max. ${widget.maxsize ?? Numberlimits.maxImageFileUpload} MB)',
                                  style: TextStyle(
                                      color: Mycolors.greylightcolor,
                                      fontSize: 12),
                                ),
                          widget.boxwidth! < 185
                              ? SizedBox(height: 8, width: 0)
                              : SizedBox(height: 15),
                          GestureDetector(
                            onTap: () async {
                              await filePicker(
                                  context,
                                  'image',
                                  widget.maxsize ??
                                      Numberlimits.maxImageFileUpload);
                            },
                            child: Center(
                                child: Container(
                                    height: 35,
                                    width: 110,
                                    decoration: boxDecoration(radius: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.upload_rounded,
                                          size: 20,
                                          color: Mycolors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        MtPoppinsBold(
                                          color: Mycolors.grey,
                                          text: 'UPLOAD',
                                        )
                                      ],
                                    ))),
                          ),
                        ],
                      )
                    : Stack(children: [
                        PinchZoom(
                          child: CachedNetworkImage(
                            width: widget.boxwidth ?? w,
                            height: widget.boxwidth! * 0.5,
                            fit: widget.iscontain == false ||
                                    widget.iscontain == null
                                ? BoxFit.cover
                                : BoxFit.contain,
                            imageUrl: widget.photourl ??
                                PlaceholderGenerate()
                                    .make(widget.placeholder ?? '1024x465'),
                            progressIndicatorBuilder: (context, url,
                                    downloadProgress) =>
                                ShowWidgetLoading()
                                    .open(context, downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          resetDuration: const Duration(milliseconds: 100),
                          maxScale: 2.5,
                          onZoomStart: () {
                            print('Start zooming');
                          },
                          onZoomEnd: () {
                            print('Stop zooming');
                          },
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            width: 29.0,
                            height: 29,
                            child: RawMaterialButton(
                              onPressed: () async {
                                await widget.deletefn!();
                              },
                              child: new Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 19.0,
                              ),
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(5.0),
                            ),
                          ),
                        ),
                        widget.iseditvisible == true ||
                                widget.iseditvisible == null
                            ? Positioned(
                                right: 58,
                                bottom: 10,
                                child: Container(
                                  width: 29.0,
                                  height: 29,
                                  child: RawMaterialButton(
                                    onPressed: () async {
                                      await filePicker(
                                          context,
                                          'image',
                                          widget.maxsize ??
                                              Numberlimits.maxImageFileUpload);
                                    },
                                    child: new Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blue,
                                      size: 19.0,
                                    ),
                                    shape: new CircleBorder(),
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    padding: const EdgeInsets.all(5.0),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
              ),
              widget.subtitle == null
                  ? SizedBox(height: 4)
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(4, 6, 7, 2),
                      child: MtCustomfontRegular(
                        fontsize: 12,
                        lineheight: 1.2,
                        color: Mycolors.greytext,
                        text: widget.subtitle ?? 'Sub - Title',
                      ),
                    ),
            ],
          )),
    );
  }
}

class InputSquarePicture extends StatefulWidget {
  final Color? boxbcgcolor;
  final Color? boxbordercolor;
  final double? boxborderwidth;
  final double? boxcornerradius;
  final double? fontsize;
  final double? boxwidth;
  final int? maxsize;
  final double? boxheight;
  final bool? iseditvisible;
  final String? title;
  final String? placeholder;
  final bool? iscontain;
  final bool? isavataredit;
  final String? subtitle;
  final String? photourl;
  final Function(String val)? fetchurl;
  final Function(File file, String fietype, String basename)? uploadfn;
  final Function()? deletefn;

  InputSquarePicture({
    this.boxcornerradius,
    this.boxborderwidth,
    this.fontsize,
    this.boxheight,
    this.photourl,
    this.boxbcgcolor,
    this.uploadfn,
    this.isavataredit,
    this.maxsize,
    this.iscontain,
    this.deletefn,
    this.boxbordercolor,
    this.placeholder,
    this.title,
    this.fetchurl,
    this.subtitle,
    this.boxwidth,
    this.iseditvisible,
  });
  @override
  _InputSquarePictureState createState() => _InputSquarePictureState();
}

class _InputSquarePictureState extends State<InputSquarePicture> {
  File? file;
  Future filePicker(BuildContext context, String fileType, int maxSize) async {
    if (await Permission.storage.request().isGranted) {
      try {
        if (fileType == 'image') {
          await FilePicker.platform
              .pickFiles(type: FileType.image)
              .then((value) async {
            if (value == null) {
              print('object;');
            } else {
              var file = File(value.files[0].path!);

              if (file.lengthSync() / 1000000 > maxSize) {
                ShowCustomAlertDialog().open(
                    context: context,
                    isshowerrorlog: false,
                    title: 'Upload Failed.',
                    description: Numberlimits.maxFileSizeExceededError1 +
                        '$maxSize MB. \n' +
                        Numberlimits.maxFileSizeExceededError2);
              } else {
                if (file.uri
                            .toString()
                            .substring(file.uri.toString().lastIndexOf(".")) !=
                        '.png' &&
                    file.uri
                            .toString()
                            .substring(file.uri.toString().lastIndexOf(".")) !=
                        '.jpeg' &&
                    file.uri
                            .toString()
                            .substring(file.uri.toString().lastIndexOf(".")) !=
                        '.jpg') {
                  //  print(file.uri.toString().substring(file.uri.toString().lastIndexOf(".")));
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                              )
                            ],
                            title: Text("File type Not Supported"),
                            content: Text(
                                "Sorry ! You can not upload this file. You can only Upload Image files (like - .png, .jpeg). Please try again and select a Image file."),
                          ));
                } else {
                  String basenameold = '';
                  basenameold = p.basename(file.path);
                  setState(() {
                    basenameold = p.basename(file.path);
                  });
                  await widget.uploadfn!(
                    file,
                    fileType,
                    basenameold,
                  );
                }
              }
            }
          });
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sorry...'),
                content: Text('Unsupported exception: $e'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  )
                ],
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: <Widget>[
                  TextButton(
                      child: Text('OPEN APP SETTINGS'),
                      onPressed: () {
                        Navigator.pop(context);
                        openAppSettings();
                      })
                ],
                title: Text(
                  "Permission Not Granted !",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                content: Text(
                    "Please Allow ${AppConstants.appname} app to read & write Storage to pick particular file which you select.\n\n1.  Tap on OPEN APP SETTINGS  \n\n2.  Go to PERMISSIONS          \n\n3.  Allow / Turn On the Storage Switch.\n\nYou can TurnOff this settings anytime"),
              ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
          margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
          width: widget.boxwidth,
          height: widget.isavataredit == true && widget.isavataredit != null
              ? widget.boxwidth
              : widget.boxheight ?? widget.boxwidth! + 50,
          child: widget.isavataredit == true && widget.isavataredit != null
              ? Container(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        (widget.photourl != ''
                            ? Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                      child: Padding(
                                          padding: EdgeInsets.all(50.0),
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Mycolors.loadingindicator),
                                          )),
                                      width: 150.0,
                                      height: 150.0),
                                  imageUrl: widget.photourl!,
                                  width: 150.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(75.0)),
                                clipBehavior: Clip.hardEdge,
                              )
                            : Icon(
                                Icons.account_circle,
                                size: 150.0,
                                color: Colors.grey,
                              )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: FloatingActionButton(
                                backgroundColor: Mycolors.secondary,
                                child:
                                    Icon(Icons.camera_alt, color: Colors.white),
                                onPressed: () async {
                                  await filePicker(
                                      context,
                                      'image',
                                      widget.maxsize ??
                                          Numberlimits.maxImageFileUpload);
                                })),
                      ],
                    ),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.all(20.0),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.title == null
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 7, 5),
                            child: MtPoppinsSemiBold(
                              color: Mycolors.grey,
                              fontsize: 13,
                              text: widget.title ?? 'Group',
                            ),
                          ),
                    widget.subtitle != null
                        ? SizedBox(height: 4)
                        : SizedBox(height: 0),
                    Container(
                      // color: Colors.white,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      height: widget.boxwidth,
                      width: widget.boxwidth,
                      decoration: BoxDecoration(
                          color: widget.boxbcgcolor ?? Colors.white,
                          border: Border.all(
                              color: widget.boxbordercolor ??
                                  Mycolors.greylightcolor,
                              style: BorderStyle.solid,
                              width: widget.boxborderwidth ?? 1.5),
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.boxcornerradius ?? 0))),
                      child: widget.photourl == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                widget.boxwidth! < 103
                                    ? SizedBox()
                                    : Center(
                                        child: Icon(
                                        Icons.photo,
                                        color: Mycolors.greylightcolor,
                                        size: widget.boxwidth! < 103
                                            ? 25
                                            : widget.boxwidth! < 155
                                                ? 43
                                                : 53,
                                      )),
                                widget.boxwidth! < 55
                                    ? SizedBox(height: 0, width: 0)
                                    : Text(
                                        widget.placeholder == null
                                            ? '1024x465 px'
                                            : '${widget.placeholder} px',
                                        style: TextStyle(
                                            color: Mycolors.greylightcolor,
                                            fontSize: widget.boxwidth! < 103
                                                ? 12
                                                : 14),
                                      ),
                                widget.boxwidth! < 95
                                    ? SizedBox(height: 0, width: 0)
                                    : SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () async {
                                    await filePicker(
                                        context,
                                        'image',
                                        widget.maxsize ??
                                            Numberlimits.maxImageFileUpload);
                                  },
                                  child: Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 35,
                                          width:
                                              widget.boxwidth! < 103 ? 35 : 110,
                                          decoration: boxDecoration(radius: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.upload_rounded,
                                                size: 20,
                                                color: Mycolors.grey,
                                              ),
                                              widget.boxwidth! < 103
                                                  ? SizedBox()
                                                  : SizedBox(width: 10),
                                              widget.boxwidth! < 103
                                                  ? SizedBox()
                                                  : MtPoppinsBold(
                                                      color: Mycolors.grey,
                                                      text: 'UPLOAD',
                                                    )
                                            ],
                                          ))),
                                ),
                              ],
                            )
                          : Stack(children: [
                              PinchZoom(
                                onZoomStart: () {
                                  print('Zoom started');
                                },
                                onZoomEnd: () {
                                  print('Zoom finished');
                                },
                                child: CachedNetworkImage(
                                  width: widget.boxwidth,
                                  height: widget.boxwidth,
                                  fit: BoxFit.cover,
                                  imageUrl: widget.photourl ??
                                      PlaceholderGenerate().make(
                                          widget.placeholder ?? '1024x465'),
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      ShowWidgetLoading().open(
                                          context, downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              widget.iseditvisible == true ||
                                      widget.iseditvisible == null
                                  ? Positioned(
                                      right: 10,
                                      bottom: 10,
                                      child: Container(
                                        width: 29.0,
                                        height: 29,
                                        child: RawMaterialButton(
                                          onPressed: () async {
                                            await filePicker(
                                                context,
                                                'image',
                                                widget.maxsize ??
                                                    Numberlimits
                                                        .maxImageFileUpload);
                                          },
                                          child: new Icon(
                                            Icons.edit_outlined,
                                            color: Colors.blue,
                                            size: 19.0,
                                          ),
                                          shape: new CircleBorder(),
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          padding: const EdgeInsets.all(5.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                            ]),
                    ),
                    widget.subtitle == null
                        ? SizedBox(height: 4)
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(4, 6, 7, 2),
                            child: MtCustomfontRegular(
                              fontsize: 12,
                              lineheight: 1.2,
                              color: Mycolors.greytext,
                              text: widget.subtitle ?? 'Sub - Title',
                            ),
                          ),
                  ],
                )),
    );
  }
}

class InputPDFFile extends StatefulWidget {
  final Color? boxbcgcolor;
  final Color? boxbordercolor;
  final double? boxborderwidth;
  final double? boxcornerradius;
  final double? fontsize;
  final EdgeInsets? margin;
  final double? boxwidth;
  final double? boxheight;
  final int? maxsize;
  final bool? iseditvisible;
  final String? title;
  final String? placeholder;
  final bool? iscontain;
  final String? subtitle;
  final String? fileurl;
  final String? filename;
  final Function(String val)? fetchurl;
  final Function(File file, String fietype, String basename)? uploadfn;
  final Function()? deletefn;

  InputPDFFile({
    this.boxcornerradius,
    this.boxborderwidth,
    this.fontsize,
    this.margin,
    this.fileurl,
    this.maxsize,
    this.boxbcgcolor,
    this.uploadfn,
    this.filename,
    this.iscontain,
    this.deletefn,
    this.boxbordercolor,
    this.placeholder,
    this.title,
    this.fetchurl,
    this.subtitle,
    this.boxwidth,
    this.iseditvisible,
    this.boxheight,
  });
  @override
  _InputPDFFileState createState() => _InputPDFFileState();
}

class _InputPDFFileState extends State<InputPDFFile> {
  File? file;
  Future filePicker(BuildContext context, String fileType, int maxSize) async {
    if (await Permission.storage.request().isGranted) {
      try {
        if (fileType == 'pdf') {
          await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf']).then((value) async {
            if (value == null) {
              print('object;');
            } else {
              var file = File(value.files[0].path!);

              if (file.lengthSync() / 1000000 > maxSize) {
                ShowCustomAlertDialog().open(
                    context: context,
                    isshowerrorlog: false,
                    title: 'Upload Failed.',
                    description: Numberlimits.maxFileSizeExceededError1 +
                        '$maxSize MB. \n' +
                        Numberlimits.maxFileSizeExceededError2);
              } else {
                if (file.uri
                        .toString()
                        .substring(file.uri.toString().lastIndexOf(".")) !=
                    '.pdf') {
                  //  print(file.uri.toString().substring(file.uri.toString().lastIndexOf(".")));
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                              )
                            ],
                            title: Text("File type Not Supported"),
                            content: Text(
                                "Sorry ! You can not upload this file. You can only Upload ZIP files (like - .zip). Please try again and select a ZIP file."),
                          ));
                } else {
                  String basenameold = '';
                  basenameold = p.basename(file.path);
                  setState(() {
                    basenameold = p.basename(file.path);
                  });
                  await widget.uploadfn!(
                    file,
                    fileType,
                    basenameold,
                  );
                }
              }
            }
          });
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sorry...'),
                content: Text('Unsupported exception: $e'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  )
                ],
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: <Widget>[
                  TextButton(
                      child: Text('OPEN APP SETTINGS'),
                      onPressed: () {
                        Navigator.pop(context);
                        openAppSettings();
                      })
                ],
                title: Text(
                  "Permission Not Granted !",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                content: Text(
                    "Please Allow ${AppConstants.appname} app to read & write Storage to pick particular file which you select.\n\n1.  Tap on OPEN APP SETTINGS  \n\n2.  Go to PERMISSIONS          \n\n3.  Allow / Turn On the Storage Switch."),
              ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Align(
      child: Container(
          margin: widget.margin ?? EdgeInsets.fromLTRB(8, 10, 8, 10),
          width: widget.boxwidth ?? w,
          height: widget.boxheight ?? null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title == null
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 7, 5),
                      child: MtPoppinsSemiBold(
                        color: Mycolors.grey,
                        fontsize: 13,
                        text: widget.title ?? 'Title',
                      ),
                    ),
              widget.subtitle != null
                  ? SizedBox(height: 4)
                  : SizedBox(height: 0),
              Container(
                // color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: widget.boxwidth! * 0.45,
                width: widget.boxwidth ?? w,
                decoration: BoxDecoration(
                    color: widget.boxbcgcolor ?? Colors.white,
                    border: Border.all(
                        color: widget.boxbordercolor ?? Mycolors.greylightcolor,
                        style: BorderStyle.solid,
                        width: widget.boxborderwidth ?? 1.5),
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.boxcornerradius ?? 0))),
                child: widget.fileurl == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widget.boxwidth! < 235
                              ? SizedBox(height: 0, width: 0)
                              : Center(
                                  child: Icon(
                                  EvaIcons.fileAdd,
                                  color: Mycolors.greylightcolor,
                                  size: 53,
                                )),
                          widget.boxwidth! < 105
                              ? SizedBox(height: 0, width: 0)
                              : Text(
                                  widget.placeholder == null
                                      ? '.PDF (Max. ${widget.maxsize ?? Numberlimits.maxZIPFileUpload} MB)'
                                      : '${widget.placeholder} px (Max. ${widget.maxsize ?? Numberlimits.maxZIPFileUpload} MB)',
                                  style: TextStyle(
                                      color: Mycolors.greylightcolor,
                                      fontSize: 12),
                                ),
                          widget.boxwidth! < 185
                              ? SizedBox(height: 8, width: 0)
                              : SizedBox(height: 15),
                          GestureDetector(
                            onTap: () async {
                              await filePicker(
                                  context,
                                  'pdf',
                                  widget.maxsize ??
                                      Numberlimits.maxZIPFileUpload);
                            },
                            child: Center(
                                child: Container(
                                    height: 35,
                                    width: 110,
                                    decoration: boxDecoration(radius: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.upload_rounded,
                                          size: 20,
                                          color: Mycolors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        MtPoppinsBold(
                                          color: Mycolors.grey,
                                          text: 'UPLOAD',
                                        )
                                      ],
                                    ))),
                          ),
                        ],
                      )
                    : Stack(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            widget.boxwidth! < 235
                                ? SizedBox(height: 0, width: 0)
                                : Center(
                                    child: Icon(
                                    FontAwesomeIcons.filePdf,
                                    color: Mycolors.red,
                                    size: 53,
                                  )),
                            SizedBox(
                              height: 10,
                            ),
                            widget.boxwidth! < 105
                                ? SizedBox(height: 0, width: 0)
                                : Text(
                                    'File uploaded succesfully !',
                                    style: TextStyle(
                                        color: Mycolors.grey, fontSize: 12),
                                  ),
                            widget.boxwidth! < 185
                                ? SizedBox(height: 8, width: 0)
                                : SizedBox(height: 15),
                            widget.boxwidth! < 105
                                ? SizedBox(height: 0, width: 0)
                                : Text(
                                    widget.filename ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Mycolors.black,
                                        fontSize: 14),
                                  ),
                          ],
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            width: 29.0,
                            height: 29,
                            child: RawMaterialButton(
                              onPressed: () async {
                                await widget.deletefn!();
                              },
                              child: new Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 19.0,
                              ),
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(5.0),
                            ),
                          ),
                        ),
                        widget.iseditvisible == true ||
                                widget.iseditvisible == null
                            ? Positioned(
                                right: 58,
                                bottom: 10,
                                child: Container(
                                  width: 29.0,
                                  height: 29,
                                  child: RawMaterialButton(
                                    onPressed: () async {
                                      await filePicker(
                                          context,
                                          'pdf',
                                          widget.maxsize ??
                                              Numberlimits.maxZIPFileUpload);
                                    },
                                    child: new Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blue,
                                      size: 19.0,
                                    ),
                                    shape: new CircleBorder(),
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    padding: const EdgeInsets.all(5.0),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
              ),
              widget.subtitle == null
                  ? SizedBox(height: 4)
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(4, 6, 7, 2),
                      child: MtCustomfontRegular(
                        fontsize: 12,
                        lineheight: 1.2,
                        color: Mycolors.greytext,
                        text: widget.subtitle ?? 'Sub - Title',
                      ),
                    ),
            ],
          )),
    );
  }
}
