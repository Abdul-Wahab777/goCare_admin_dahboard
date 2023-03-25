import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';

import 'boxdecoration.dart';

Widget eachhorizontaltile(
    {String? title,
    String? subtitle,
    Icon? icon,
    double? fontsize,
    int? maxlines,
    bool? isbold,
    double? tileheight,
    double? tilewidth,
    Color? color}) {
  double secondwidth = tilewidth == null ? 230 : tilewidth - 36;
  return Container(
    width: tilewidth ?? 290,
    // height: tileheight ?? 40,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon ??
            Icon(
              Icons.circle,
              size: 6,
              color: color ?? Mycolors.greytext,
            ),
        SizedBox(width: 7),
        Container(
          width: secondwidth,
          child: isbold == false
              ? MtCustomfontRegular(
                  lineheight: 1.3,
                  color: color,
                  text: title ?? 'Type',
                  fontsize: 12,
                  maxlines: maxlines ?? 3,
                )
              : MtCustomfontBold(
                  lineheight: 1.3,
                  color: color,
                  text: title ?? 'Type',
                  fontsize: 12,
                  maxlines: maxlines ?? 3,
                ),
        ),
      ],
    ),
  );
}

Widget eachtile(
    {String? title,
    String? subtitle,
    Icon? icon,
    double? fontsize,
    int? maxlines,
    double? tileheight,
    double? tilewidth}) {
  return Container(
    width: tilewidth ?? 100,
    // height: tileheight ?? 40,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        icon ??
            Icon(
              Icons.circle,
              size: 7,
              color: Mycolors.greytext,
            ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MtCustomfontLight(
              text: title ?? 'Type',
              fontsize: 12,
            ),
            // Text(
            //   title ?? 'Type',
            //   style:
            //       TextStyle(height: 1.0, fontSize: 11, color: Mycolors.grey),
            // ),
            SizedBox(height: 5),
            SizedBox(
              width: 82,
              child: Text(
                subtitle ?? 'FLAT',
                maxLines: maxlines ?? 3,
                style: TextStyle(
                    fontSize: fontsize ?? 13,
                    height: 1.2,
                    color: Mycolors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget eachcount(
    {String? count,
    String? text,
    double? width,
    double? height,
    double? fontsize,
    Color? countcolor,
    Color? labelcolor}) {
  return Container(
    // color: Colors.red,
    alignment: Alignment.center,
    height: height ?? 50,
    width: width ?? 80,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MtCustomfontBoldExtra(
          color: countcolor ?? Mycolors.black.withOpacity(0.8),
          text: count ?? '20',
          fontsize: fontsize ?? 24,
        ),
        MtCustomfontRegular(
          color: labelcolor ?? Mycolors.grey,
          fontsize: 13.5,
          text: text ?? 'Sales',
        )
      ],
    ),
  );
}

Widget profileTile(
    {String? title,
    double? margin,
    double? iconsize,
    String? subtitle,
    IconData? leadingicondata,
    IconData? trailingicondata,
    Color? leadingiconcolor,
    Function? ontap,
    Widget? trailingWidget,
    Widget? leadingWidget,
    bool? isthreelines}) {
  return Container(
      margin: margin == null
          ? EdgeInsets.all(5)
          : EdgeInsets.fromLTRB(
              margin,
              (margin / 2),
              margin,
              margin / 2,
            ),
      decoration: boxDecoration(showShadow: true),
      child: ListTile(
        isThreeLine: isthreelines ?? false,
        contentPadding: EdgeInsets.fromLTRB(12, 4, 12, 2),
        title: MtCustomfontMedium(
          fontsize: 16,
          color: Mycolors.black,
          text: title ?? 'Title',
        ),
        subtitle: MtCustomfontRegular(
          text: subtitle ?? 'This is sub title',
          fontsize: 13,
          lineheight: 1.2,
        ),
        trailing: trailingWidget ??
            Icon(trailingicondata ?? Icons.keyboard_arrow_right),
        leading: leadingWidget ??
            Icon(
              leadingicondata ?? Icons.location_on_outlined,
              color: leadingiconcolor ?? Mycolors.primary,
              size: iconsize ?? 27,
            ),
        // isThreeLine: true,
        onTap: ontap as void Function()? ??
            () {
              print("On Tap is fired");
            },
      ));
}
