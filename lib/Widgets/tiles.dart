import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Fonts/MyText.dart';
import 'package:thinkcreative_technologies/Models/CountrydataList.dart';
import 'package:thinkcreative_technologies/Widgets/boxdecoration.dart';

Widget eachGridTile(
    {required double width, String? label, bool? isallowed, Widget? icon}) {
  return Container(
    // height: 120,
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    width: width / 3.2,
    // margin: EdgeInsets.only(left: 2),
    decoration: boxDecoration(
        radius: 2,
        showShadow: true,
        bgColor: Colors.white,
        color: Colors.white),
    child: Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        icon ??
            Icon(
                isallowed == true
                    ? Icons.check_circle_outline_rounded
                    : Icons.cancel_outlined,
                color: isallowed == true ? Colors.green : Colors.red,
                size: 25),
        MtCustomfontRegular(
          lineheight: 1.3,
          textalign: TextAlign.center,
          
          text: label ?? '',
          fontsize: 13,
        )
      ],
    )),
  );
}

Widget eachCountryTile({
  required double width,
  String? countrycode,
  int? count,
}) {
  int i = countryData
              .indexWhere((element) => element.split('---')[0] == countrycode) >
          0
      ? countryData
          .indexWhere((element) => element.split('---')[0] == countrycode)
      : 0;
  return Container(
    // height: 120,
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    width: width / 3.2,
    decoration: boxDecoration(
        radius: 2,
        showShadow: true,
        bgColor: Colors.white,
        color: Colors.white),
    child: Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MtCustomfontRegular(
          lineheight: 1.3,
          textalign: TextAlign.center,
          text: countryData[i].split('---')[1],
          fontsize: 13,
        ),
        SizedBox(
          height: 4,
        ),
        MtCustomfontBold(
          lineheight: 1.3,
          textalign: TextAlign.center,
          text: '$count',
          fontsize: 20,
        ),
        SizedBox(
          height: 4,
        ),
        MtCustomfontRegular(
          overflow: TextOverflow.ellipsis,
          maxlines: 2,
          lineheight: 1.0,
          textalign: TextAlign.center,
          text: countryData[i].split('---')[3],
          fontsize: 13,
        )
      ],
    )),
  );
}
