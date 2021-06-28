import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';
import 'package:tiger_newemployee/Models/term_conditon.dart';
import 'package:http/http.dart' as http;

class TermsConditionPage extends StatefulWidget {
  final String? name;
  const TermsConditionPage({Key? key, this.name}) : super(key: key);

  @override
  _TermsConditionPageState createState() => _TermsConditionPageState();
}

List<TermModel> termslist = [];
bool accepted = false;

class _TermsConditionPageState extends State<TermsConditionPage> {
  @override
  void initState() {
    super.initState();
    gettemslist();

    // if (widget.name == null || widget.name!.length < 3) {
    //   // Navigator.popAndPushNamed(context, '/');
    //   context.nextReplacementPage(const SplashSceen());
    // }
  }

  gettemslist() async {
    String _url =
        "https://tigersecurity.in/hrdivisionapp/termscondition/term.php";

    try {
      http.Response response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        List<TermModel> _result = termModelFromJson(response.body);

        setState(() {
          termslist = _result;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Tiger Group Of Companies",
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
              color: darkprimarycolor,
              fontSize: 30,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
        excludeHeaderSemantics: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: blackcolor,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: Column(
          children: [
            // const Center(
            //   child: Text(
            //     "Tiger Security Guard Services",
            //     textAlign: TextAlign.center,
            //     softWrap: true,
            //     style: TextStyle(
            //         color: darkprimarycolor,
            //         fontSize: 30,
            //         fontWeight: FontWeight.w700),
            //   ),
            // ),
            const Center(
              child: Text(
                "Terms & Conditions",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    color: accentcolor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Column(
              children: termslist.map((e) {
                return buildtermtitel(data: e);
              }).toList(),
            ),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            //   child: [
            //     Checkbox(
            //       value: accepted,
            //       onChanged: (value) {
            //         setState(() {
            //           accepted = value!;
            //         });
            //       },
            //     ),
            //     Text(
            //       "I agree & accept all terms and condition.",
            //       textAlign: TextAlign.center,
            //       softWrap: true,
            //       style: TextStyle(
            //           overflow: TextOverflow.ellipsis,
            //           fontSize: _media.width > 400 ? 14 : 10,
            //           fontWeight: FontWeight.bold),
            //     ),
            //   ].hStack(),
            // ),
            // accepted
            //     ? Container(
            //         child: buildprocessbtn(
            //             size: _media.width,
            //             name: "Fill Form",
            //             onpress: () {
            //               appicationdata.termacceped = accepted;
            //               frompage = 'Terms';
            //               reffid = widget.name!;
            //               // context.vxNav.push(
            //               //   Uri(
            //               //     path: MyRoutes.formRoute,
            //               //     queryParameters: {
            //               //       "reff": widget.name,
            //               //     },
            //               //   ),
            //               // );
            //               Navigator.pushAndRemoveUntil(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => NewFormPage(),
            //                   ),
            //                   (route) => false);
            //             }),
            //       )
            //     : const SizedBox()
          ],
        ),
      )),
    );
  }

  Widget buildtermtitel({required TermModel data}) {
    TextStyle _titel = const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        height: 3,
        color: accentcolor);
    TextStyle _detail = const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: blackcolor);
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            data.titel.toString(),
            textAlign: TextAlign.justify,
            style: _titel,
          ),
          SelectableText(
            data.detail.toString(),
            textAlign: TextAlign.left,
            style: _detail,
          ),
        ],
      ),
    );
  }

  Widget buildprocessbtn(
      {required String name, required void Function() onpress, required size}) {
    TextStyle styl = TextStyle(
        fontSize: size > 800 ? 18.0 : 16.0,
        fontWeight: FontWeight.w900,
        color: whitecolor,
        letterSpacing: 1.5);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        color: accentcolor,
        onPressed: onpress,
        child: Container(
          height: 35,
          width: 200,
          alignment: Alignment.center,
          child: Text(
            name,
            style: styl,
          ),
        ),
      ),
    );
  }
}
