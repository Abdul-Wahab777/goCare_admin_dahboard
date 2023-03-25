import 'package:flutter/material.dart';

BoxDecoration boxDecoration(
    {double? radius,
    Color? color,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow == true
          ? [
              BoxShadow(
                  color: Color(0xfff1f4fb).withOpacity(0.4),
                  blurRadius: 0.5,
                  spreadRadius: 1)
            ]
          : [BoxShadow(color: bgColor)],
      border: showShadow == true
          ? Border.all(
              color: Color(0xfff1f4fb).withOpacity(0.99),
              style: BorderStyle.solid,
              width: 0)
          : Border.all(
              color: color ?? Color(0xfff1f4fb).withOpacity(0.9),
              style: BorderStyle.solid,
              width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 5)));
}
