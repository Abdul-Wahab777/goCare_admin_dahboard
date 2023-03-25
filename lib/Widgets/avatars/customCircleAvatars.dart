import 'package:flutter/material.dart';

Widget customCircleAvatar({String? url, double? radius}) {
  print('$url');
  if (url == null || url == '') {
    return CircleAvatar(
      backgroundColor: Color(0xffE6E6E6),
      radius: radius ?? 30,
      child: Icon(
        Icons.person,
        size: radius != null ? radius * 1.5 : 27,
        color: Colors.white,
      ),
    );
  } else {
    return CircleAvatar(
      backgroundColor: Color(0xffE6E6E6),
      radius: radius ?? 30,
      backgroundImage: NetworkImage('$url'),
    );
  }
}
