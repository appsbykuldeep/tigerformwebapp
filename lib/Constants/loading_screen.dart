import 'package:flutter/material.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';

Future showloading({required context, required titel}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "$titel",
            style: const TextStyle(
                color: primarycolor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0),
          ),
          content: SizedBox(
            width: 50,
            height: 50,
            child: Center(
                child: CircularProgressIndicator(
              color: primarycolor.withOpacity(.6),
            )),
          ),
        );
      });
}

endloading({required context}) {
  Navigator.pop(context);
}
