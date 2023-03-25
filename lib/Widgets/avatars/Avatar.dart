import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/App_constants.dart';

Widget avatar(
    {String? imageUrl, double radius = 22.5, String? backgroundColor}) {
  if (imageUrl == null) {
    return CircleAvatar(
      backgroundImage:
          Image.network(AppConstants.defaultprofilepicfromnetworklink).image,
      radius: radius,
    );
  }
  return CircleAvatar(
      backgroundImage: Image.network(imageUrl).image, radius: radius);
}
