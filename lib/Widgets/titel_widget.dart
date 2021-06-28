import 'package:flutter/material.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';

Widget titelwidget({String titel = 'Tiger Group Of Companies', context}) {
  return Center(
    child: Text(
      titel,
      textAlign: TextAlign.center,
      softWrap: true,
      style: const TextStyle(
          color: darkprimarycolor, fontSize: 30, fontWeight: FontWeight.w700),
    ),
  );
}

Widget subtitelwidget({String subtitel = '', context}) {
  return Center(
    child: Text(
      subtitel,
      textAlign: TextAlign.center,
      softWrap: true,
      style: const TextStyle(
          color: accentcolor, fontSize: 26, fontWeight: FontWeight.w600),
    ),
  );
}

Widget spacewidget({double h = 0.0, double w = 0.0}) {
  return SizedBox(
    height: h,
    width: w,
  );
}
