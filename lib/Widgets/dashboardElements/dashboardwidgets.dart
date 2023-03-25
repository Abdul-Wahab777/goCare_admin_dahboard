import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';

Widget dashboardCard(
    {double? width,
    double? height,
    String? label,
    String? value,
    IconData? iconData,
    Color? cardColor}) {
  return Container(
      width: width ?? 150,
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: boxDecoration(
          showShadow: false,
          radius: 10,
          bgColor: cardColor ?? Color(0xfff29b38),
          color: cardColor ?? Colors.black12),
      padding: const EdgeInsets.fromLTRB(6, 7, 6, 5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MtCustomfontBold(
                text: label ?? 'Users',
                fontsize: 12,
                color: Mycolors.whitedim,
              ),
              Icon(
                iconData ?? Icons.person,
                size: 19,
                color: Mycolors.whitedim,
              )
            ],
          ),
          SizedBox(height: height ?? 17),
          MtPoppinsBold(
              text: value ?? '00', color: Mycolors.whitedim, fontsize: 23),
        ],
      ));
}
