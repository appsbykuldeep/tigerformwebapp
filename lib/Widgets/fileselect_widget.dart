// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';
import 'package:velocity_x/velocity_x.dart';

Widget buildimageupload({
  required String status,
  required String lable,
  required void Function() selectimage,
  required size,
}) {
  double fontsz = size > 800
      ? 16
      : size > 420
          ? 14
          : 12;
  return Container(
    margin: const EdgeInsets.all(5.0),
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
    decoration: BoxDecoration(
        border: Border.all(color: primarycolor),
        borderRadius: BorderRadius.circular(5.0)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size > 800 ? 150 : 120,
          child: Text(
            lable,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: fontsz,
                fontWeight: FontWeight.bold,
                color: blackcolor),
          ),
        ),
        SizedBox(
          width: size > 800
              ? 20
              : size > 400
                  ? 10
                  : 5,
          child: Text(
            ":",
            style: TextStyle(
                fontSize: fontsz,
                fontWeight: FontWeight.bold,
                color: blackcolor),
          ),
        ),
        status.text
            .size(fontsz)
            .color(blackcolor)
            .bold
            .overflow(TextOverflow.ellipsis)
            .make(),
        SizedBox(width: size > 800 ? 10 : 5),
        ElevatedButton(
            onPressed: selectimage,
            child: size < 400
                ? const Icon(
                    Icons.attachment_rounded,
                    color: whitecolor,
                  )
                : const Text("Select Image"))
      ],
    ),
  );
}
