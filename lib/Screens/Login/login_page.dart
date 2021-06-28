import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (BuildContext context, constrains) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 3, child: "Tiger Group".text.xl6.makeCentered()),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                        child: buildlogin(),
                      ))
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  Widget buildlogin() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 30.0),
      decoration: BoxDecoration(
          border: Border.all(color: darkprimarycolor),
          borderRadius: BorderRadius.circular(20.0),
          color: whitecolor,
          boxShadow: [BoxShadow(color: primarycolor.withOpacity(.6))]),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          "Tiger Group".text.xl5.bold.color(accentcolor).makeCentered(),
          const SizedBox(
            height: 10.0,
          ),
          buildtextfiled(
            hint: "Your ID",
            preicon: Icons.security,
          ),
          buildtextfiled(
            hint: "Your Password",
            preicon: Icons.vpn_key,
            ispassword: true,
          ),
          const SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            onPressed: () {},
            color: darkprimarycolor,
            child: SizedBox(
              width: 100.0,
              height: 35.0,
              child: "Login".text.xl.bold.color(whitecolor).makeCentered(),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }

  TextStyle hinttextsty = TextStyle(
      color: primarycolor.withOpacity(.6),
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5);

  buildtextfiled({
    TextEditingController? controller,
    bool ispassword = false,
    required String hint,
    required IconData preicon,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
      child: TextField(
        controller: controller,
        obscureText: ispassword,
        style: hinttextsty.copyWith(color: darkprimarycolor),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: hinttextsty,
            prefixIcon: Icon(
              preicon,
            )),
      ),
    );
  }
}
