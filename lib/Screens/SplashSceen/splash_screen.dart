import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';
import 'package:tiger_newemployee/Models/reffer_model.dart';
import 'package:tiger_newemployee/Screens/Login/login_page.dart';
import 'package:tiger_newemployee/Screens/NewForm/filled_data.dart';
import 'package:tiger_newemployee/Screens/NewForm/form_page.dart';
import 'package:tiger_newemployee/Screens/SplashSceen/uri_data.dart';
import 'package:http/http.dart' as http;

class SplashSceen extends StatefulWidget {
  final String? refferr;
  final String? action;
  const SplashSceen({Key? key, this.refferr, this.action}) : super(key: key);

  @override
  _SplashSceenState createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen> {
  refferdetail() async {
    String url =
        "https://appbykuldeep.store/hrdivapp/Other/refferrdetail.php?id=${widget.refferr}";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final _body = refferModelFromJson(response.body);
      refferdetals = _body;
    } else {
      refferdetals.candId = 'TSMA111';
      refferdetals.candName = 'TIGER GROUP';
    }
    action = widget.action!;
  }

  @override
  void initState() {
    super.initState();
    refferdetail();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    Future.delayed(const Duration(seconds: 3), () {
      if (widget.action == 'application') {
        frompage = 'Terms';
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NewFormPage()),
            (route) => false);
      }
      if (widget.action == '') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              //"https://assets2.lottiefiles.com/private_files/lf30_1TcivY.json",
              SizedBox(
                height: _width > 1200
                    ? 400
                    : _width > 800
                        ? 300
                        : _width > 400
                            ? 250
                            : 180,
                child: Lottie.asset("assets/lottie/welcome_lottie.json",
                    fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 0,
                child: Center(
                  child: Text(
                    "Welcome To Tiger Group",
                    style: TextStyle(
                        fontSize: _width > 1200
                            ? 35
                            : _width > 800
                                ? 30
                                : _width > 400
                                    ? 22
                                    : 18,
                        fontWeight: FontWeight.w900,
                        color: darkprimarycolor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
