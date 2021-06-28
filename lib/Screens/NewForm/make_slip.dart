import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:lottie/lottie.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';
import 'package:intl/intl.dart';
import 'package:tiger_newemployee/Controllers/WebRoute/page_routes.dart';
import 'package:tiger_newemployee/Screens/SplashSceen/splash_screen.dart';
import 'filled_data.dart';
import 'package:velocity_x/velocity_x.dart';

class PDFSave extends StatefulWidget {
  const PDFSave({Key? key}) : super(key: key);
  @override
  _PDFSaveState createState() => _PDFSaveState();
}

pw.TextStyle style = const pw.TextStyle(fontSize: 14);
String proilepic = 'Not Submitted';
String signpic = 'Not Submitted';
String addresspic = 'Not Submitted';
String markspic = 'Not Submitted';

class _PDFSaveState extends State<PDFSave> {
  final pdf = pw.Document();
  var anchor;

  savePDF() async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'Application Receipt.pdf';
    html.document.body!.children.add(anchor);
  }

  _buildonerow({
    required String lable,
    required String detail,
  }) {
    return pw.Column(children: [
      pw.Row(children: [
        pw.SizedBox(
          width: 120.0,
          child: pw.Text(lable, softWrap: true, style: style),
        ),
        pw.SizedBox(
          width: 20.0,
          child: pw.Text(":", style: style),
        ),
        pw.SizedBox(
          width: 300.0,
          child: pw.Text(
            detail,
            style: style,
            overflow: pw.TextOverflow.visible,
            softWrap: true,
          ),
        )
      ]),
      pw.SizedBox(height: 10.0),
    ]);
  }

  createPDF() async {
    pdf.addPage(
      pw.Page(
          build: (pw.Context context) => pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColor.fromHex('#d12519'),
                    ),
                    borderRadius: pw.BorderRadius.circular(15.0)),
                child: pw.Column(
                  children: [
                    pw.Text('Tiger Group Of Companies',
                        style: pw.TextStyle(
                            fontSize: 30, color: PdfColor.fromHex('#700808'))),
                    pw.Text('Application Receipt',
                        style: pw.TextStyle(
                            fontSize: 24, color: PdfColor.fromHex('#1ababa'))),
                    pw.SizedBox(height: 15.0),
                    _buildonerow(
                        lable: "Applied Date",
                        detail: DateFormat('yMd')
                            .format(DateTime.now())
                            .toString()),
                    _buildonerow(
                        lable: "Name", detail: appicationdata.name.toString()),
                    _buildonerow(
                        lable: "Father Name",
                        detail: appicationdata.father.toString()),
                    _buildonerow(
                        lable: "Mobile",
                        detail: appicationdata.mobile.toString()),
                    _buildonerow(
                        lable: "Email id",
                        detail: appicationdata.email.toString()),
                    _buildonerow(
                        lable: "Applied For",
                        detail: appicationdata.post.toString()),
                    _buildonerow(lable: "Profile Picture", detail: proilepic),
                    _buildonerow(lable: "Signature", detail: signpic),
                    _buildonerow(lable: "Address Proff", detail: addresspic),
                    _buildonerow(lable: "Quali. Proff", detail: markspic),
                    _buildonerow(lable: "Payment Receipt", detail: 'Submitted'),
                    _buildonerow(
                        lable: "Address",
                        detail: appicationdata.address.toString()),
                    _buildonerow(
                        lable: "City", detail: appicationdata.city.toString()),
                    _buildonerow(
                        lable: "Status", detail: "Verification Pending"),
                  ],
                ),
              )),
    );
    savePDF();
  }

  @override
  void initState() {
    super.initState();

    if (profilepicstatus.id! > 0) {
      proilepic = 'Submitted';
    }
    if (signpicstatus.id! > 0) {
      signpic = 'Submitted';
    }
    if (idpicstatus.id! > 0) {
      addresspic = 'Submitted';
    }
    if (markspicstatus.id! > 0) {
      markspic = 'Submitted';
    }
    createPDF();
  }

  String data =
      "Dear ${appicationdata.name} ! \n You Are Successfully Submitted Your Application Form !!!\nYou Can Download Your Application Receipt.";
  @override
  Widget build(BuildContext context) {
    //  var _reff = appicationdata.refferid;
    Future.delayed(const Duration(seconds: 30), () {
      frompage = 'Terms';
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SplashSceen()),
          (route) => false);
    });
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        return Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              //https://assets5.lottiefiles.com/packages/lf20_94HTw9.json
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Lottie.asset(
                  "assets/lottie/form_submit.json",
                  height: width < 350
                      ? width * .7
                      : width < 800
                          ? width * .5
                          : 300,
                  width: width < 350
                      ? width * .7
                      : width < 800
                          ? width * .5
                          : 300,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                data,
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: constraints.maxWidth > 800 ? 18.0 : 16,
                    fontWeight: FontWeight.w500,
                    color: darkprimarycolor),
              ),
              const SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                child: const Text('Download'),
                onPressed: () {
                  anchor.click();
                  //  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    ));
  }
}
