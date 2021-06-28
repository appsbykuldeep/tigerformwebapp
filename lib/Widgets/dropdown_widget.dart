import 'package:flutter/material.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';

Widget buidldropdown(
    {required List<String> itemslist,
    required initvalue,
    required String hinttext,
    required ValueChanged<String> onchange}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: blackcolor.withOpacity(.3)),
        borderRadius: BorderRadius.circular(5.0)),
    child: DropdownButtonFormField<String>(
      isExpanded: true,
      value: initvalue,
      decoration: const InputDecoration(
        enabledBorder: InputBorder.none,
      ),
      items: itemslist
          .map((e) => DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              ))
          .toList(),
      hint: Text(hinttext),
      onChanged: (value) => onchange(value!),
    ),
  );
}
