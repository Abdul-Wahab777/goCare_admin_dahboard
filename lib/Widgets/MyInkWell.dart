import 'package:flutter/material.dart';

InkWell myinkwell({Widget? child, Function? onTap, Function? onLongPress}) {
  return InkWell(
    onLongPress: onLongPress as void Function()? ?? null,
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: child,
    onTap: onTap as void Function()? ?? null,
  );
}
