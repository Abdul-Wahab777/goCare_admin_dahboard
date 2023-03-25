import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';

Widget noDataWidget({
  BuildContext? context,
  EdgeInsets? padding,
  String? title,
  String? subtitle,
  IconData? iconData,
  Color? iconColor,
}) {
  return Padding(
    padding: padding ??
        EdgeInsets.fromLTRB(
            40, MediaQuery.of(context!).size.height / 12, 40, 20),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              height: 100,
              width: 100,
              child: Icon(iconData ?? Icons.person,
                  size: 44, color: iconColor ?? Mycolors.primary)),
          SizedBox(
            height: 30,
          ),
          Text(
            title ?? 'No Data',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Mycolors.black.withOpacity(0.8),
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            subtitle ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Mycolors.black.withOpacity(0.6),
                fontSize: 12.5,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ),
  );
}
