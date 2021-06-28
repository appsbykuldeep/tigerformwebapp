import 'package:flutter/material.dart';

// buildtextformrow(
//     {required String hint,
//     required String lable,
//     TextInputType keyboard = TextInputType.text,
//     int maxline = 1,
//     bool ispassword = false,
//     bool enable = true,
//     TextEditingController? controller}) {
//   return Container(
//     margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
//     child: Row(
//       children: [
//         Expanded(
//           child: TextFormField(
//             obscureText: ispassword,
//             maxLines: maxline,
//             enabled: enable,
//             keyboardType: keyboard,
//             controller: controller,
//             decoration: InputDecoration(
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//               border: const OutlineInputBorder(),
//               hintText: hint,
//               labelText: lable,
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

class Buildtextform extends StatelessWidget {
  final String hint;
  final String lable;
  final TextInputType keyboard;
  final int maxline;
  final bool ispassword;
  final bool enable;
  final TextEditingController? controller;

  const Buildtextform(
      {Key? key,
      required this.hint,
      required this.lable,
      this.keyboard = TextInputType.text,
      this.maxline = 1,
      this.enable = true,
      this.controller,
      this.ispassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextFormField(
        obscureText: ispassword,
        maxLines: maxline,
        enabled: enable,
        keyboardType: keyboard,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          border: const OutlineInputBorder(),
          hintText: hint,
          labelText: lable,
        ),
      ),
    );
  }
}
