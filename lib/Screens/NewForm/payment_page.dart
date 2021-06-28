import 'package:flutter/material.dart';
import 'package:tiger_newemployee/Constants/alert_diloge.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';
import 'package:tiger_newemployee/Constants/loading_screen.dart';
import 'package:tiger_newemployee/Models/formsave_model.dart';
import 'package:tiger_newemployee/Models/image_saved.dart';
import 'package:tiger_newemployee/Screens/NewForm/filled_data.dart';
import 'package:dio/dio.dart';
import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tiger_newemployee/Screens/NewForm/form_page.dart';

import 'make_slip.dart';

String? paymentpicname;
String url = "https://tigersecurity.in/hrdivisionapp/newformpics/uploadpic.php";

class PaymentdetailPage extends StatefulWidget {
  const PaymentdetailPage({Key? key}) : super(key: key);

  @override
  _PaymentdetailPageState createState() => _PaymentdetailPageState();
}

bool imageuploded = false;

class _PaymentdetailPageState extends State<PaymentdetailPage> {
  _setImage() async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null) {
        final file = files[0];
        final reader = FileReader();
        reader.onLoadEnd.listen((e) {
          var _bytesData = const Base64Decoder()
              .convert(reader.result.toString().split(",").last);
          _uploadFile(files[0], _bytesData);
        });
        reader.readAsDataUrl(file);
      } else {
        debugPrint("No Files");
      }
    });

    uploadInput.remove();
  }

  _uploadFile(File file, List<int> bytedata) async {
    showloading(context: context, titel: "Please Wait !!!");
    FormData data = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        bytedata,
        filename: file.name,
      ),
      'category': 'Payment Slip'
    });
    Dio dio = Dio();
    dio.post(url, data: data, onSendProgress: (count, total) {}).then((value) {
      if (value.statusCode == 200) {
        var _body = value.data;

        paymentpicname = file.name.toString();
        paymentpicstatus = ImageSave.fromJson(_body);
        imageuploded = true;
        setState(() {});
      }
    });
    Navigator.pop(context);
  }

  final String _url =
      'https://tigersecurity.in/hrdivisionapp/applicationform/applicationsubmit.php';
  submitform() async {
    showloading(context: context, titel: 'Please Wait !!!');
    http.Response response =
        await http.post(Uri.parse(_url), body: jsonEncode(fullapplicationdata));
    if (response.statusCode == 200) {
      endloading(context: context);
      FormStatus status = formStatusFromJson(response.body);
      if (status.status) {
        paymentpicname = null;
        imageuploded = false;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PDFSave()),
            (route) => false);
      } else {
        faildAlert(context: context, messege: status.message);
      }
    } else {
      endloading(context: context);
      faildAlert(context: context, messege: 'Please Try Again Later...');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _media = MediaQuery.of(context).size;
    return Scaffold(body: SingleChildScrollView(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: constrains.maxWidth > 800
                    ? 20
                    : constrains.maxWidth > 400
                        ? 10
                        : 2,
                vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "Tiger Group Of Companies",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        color: darkprimarycolor,
                        fontSize: constrains.maxWidth > 800 ? 35 : 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Center(
                  child: Text(
                    "Payment Details",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        color: accentcolor,
                        fontSize: constrains.maxWidth > 800 ? 28 : 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Dear ${appicationdata.name} \n Please Pay ${appicationdata.payableamt} Rs./- by Online or Offline Method in below mention details !!!",
                  style: TextStyle(
                    fontSize: constrains.maxWidth > 800 ? 20 : 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: darkprimarycolor,
                  ),
                  textAlign: TextAlign.center,
                ),
                buildupidetils(size: constrains.maxWidth),
                buildaccountdetils(size: constrains.maxWidth),
                buildimageupload(size: constrains.maxWidth),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildprocessbtn(
                          name: "Previous",
                          onpress: () {
                            frompage = '';
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NewFormPage()),
                                (route) => false);
                          },
                          size: _media.width),
                      imageuploded
                          ? buildprocessbtn(
                              name: "Submit",
                              onpress: submitform,
                              size: _media.width)
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }

  Widget buildbarcode({required var size}) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Image.asset(
        'assets/images/barcode.jpeg',
        height: size > 800.0 ? 250.0 : 200.0,
        fit: BoxFit.fill,
      ),
    );
  }

  buildaccountdetils({required var size}) {
    TextStyle achead = TextStyle(
        fontSize: size > 800.0 ? 30.0 : 15.0,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
        color: primarycolor);
    TextStyle acdetail = TextStyle(
        fontSize: size > 800.0 ? 24.0 : 12.0,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
        color: accentcolor);
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          SelectableText(
            "Company's Account Details",
            style: achead,
          ),
          SelectableText(
            "Bank Name  :  Kotak Mahendra Bank",
            style: acdetail,
          ),
          SelectableText(
            "A/c Number  :  0612544800",
            style: acdetail,
          ),
          SelectableText(
            "IFSC Code  :  KKBK0005190",
            style: acdetail,
          ),
        ],
      ),
    );
  }

  buildupidetils({required var size}) {
    TextStyle achead = TextStyle(
        fontSize: size > 800.0 ? 30.0 : 15.0,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
        color: whitecolor);
    TextStyle acdetail = TextStyle(
        fontSize: size > 800.0 ? 24.0 : 12.0,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
        color: accentcolor);

    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          // Text(
          //   "UPI Account Details",
          //   style:
          //       achead.copyWith(foreground: Paint()..shader = linearGradient),
          // ),
          ShaderMask(
            shaderCallback: (boundes) {
              return const RadialGradient(
                colors: [
                  Color(0xfff47a1f),
                  Color(0xff009c47),
                ],
                center: Alignment.centerLeft,
                radius: 10.0,
                tileMode: TileMode.mirror,
              ).createShader(boundes);
            },
            child: Text(
              "UPI Account Details",
              style: achead,
            ),
          ),
          buildbarcode(size: size),
          SelectableText(
            "UPI ID  :  tigersecurity@paytm",
            style: acdetail,
          ),
          SelectableText(
            "Accept Upi payments from paytm, Gpay, Phonepe etc..",
            style: TextStyle(
                fontSize: size > 800.0 ? 18.0 : 12.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  buildimageupload({
    required double size,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            color:
                paymentpicname != null ? Colors.greenAccent[400] : whitecolor,
            border: Border.all(color: primarycolor),
            borderRadius: BorderRadius.circular(15.0)),
        height: 40,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Text(
              paymentpicname == null
                  ? "Upload Payment Slip"
                  : "Img_payment.jpg",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: imageuploded ? Colors.blue[700] : blackcolor),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
                onPressed: _setImage,
                child: size < 400
                    ? const Icon(
                        Icons.attachment_rounded,
                        color: whitecolor,
                      )
                    : const Text("Select Image"))
          ],
        ),
      ),
    );
  }

  buildprocessbtn(
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
          width: 100,
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
