import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:tiger_newemployee/Constants/alert_diloge.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';
import 'package:tiger_newemployee/Constants/hide_keyboard.dart';
import 'package:tiger_newemployee/Constants/loading_screen.dart';
import 'package:tiger_newemployee/Models/image_saved.dart';
import 'package:tiger_newemployee/Models/newform_model.dart';
import 'package:tiger_newemployee/Screens/NewForm/payment_page.dart';
import 'package:tiger_newemployee/Screens/NewForm/terms_page.dart';
import 'package:tiger_newemployee/Screens/SplashSceen/uri_data.dart';
import 'package:tiger_newemployee/Widgets/titel_widget.dart';
import 'filled_data.dart';
import 'package:dio/dio.dart';
import 'package:velocity_x/velocity_x.dart';

class NewFormPage extends StatefulWidget {
  const NewFormPage({
    Key? key,
  }) : super(key: key);

  @override
  _NewFormPageState createState() => _NewFormPageState();
}

final List<String> _genders = ['Select Gender', 'Male', 'Female', 'Other'];
final List<String> _paidfor = [
  'Registration Fee',
  'Registration & Training Fee'
];
final List<String> _post = [
  'Select Post',
  'Branch Manager',
  'HR Manager',
  'Marketing Manager',
  'Assistant Manager',
  'Supervisor',
  'Field Officer',
  'Security Guard',
  'Bouncer',
  'Other'
];

String gender = 'Select Gender';
String post = 'Select Post';
String paidfor = 'Registration Fee';
int paidamt = 500;
String imageof = '';
String? profilepicname;
String? signpicname;
String? addpicname;
String? qualipicname;
bool termacceped = false;

String url = "https://tigersecurity.in/hrdivisionapp/newformpics/uploadpic.php";

TextEditingController namecontoll = TextEditingController();
TextEditingController fathercontoll = TextEditingController();
TextEditingController mobilecontoll = TextEditingController();
TextEditingController altmobilecontoll = TextEditingController();
TextEditingController emailcontoll = TextEditingController();
TextEditingController expicontoll = TextEditingController();
TextEditingController qualicontoll = TextEditingController();
TextEditingController citycontoll = TextEditingController();
TextEditingController addcontoll = TextEditingController();
TextEditingController reffercontroll = TextEditingController();

class _NewFormPageState extends State<NewFormPage> {
  @override
  void initState() {
    super.initState();
    reffercontroll.text = '${refferdetals.candName}(${refferdetals.candId})';
    initialcheck();
  }

  initialcheck() {
    if (frompage == 'Terms') {
      clearrecord();
      appicationdata.termacceped = true;
      appicationdata.refferid = refferdetals.candId;
    }
  }

  clearrecord() {
    appicationdata = ApplicationModel();
    idpicstatus = ImageSave();
    signpicstatus = ImageSave();
    profilepicstatus = ImageSave();
    markspicstatus = ImageSave();
    paymentpicstatus = ImageSave();
    namecontoll.text = '';
    fathercontoll.text = '';
    termacceped = false;
    mobilecontoll.text = '';
    altmobilecontoll.text = '';
    emailcontoll.text = '';
    expicontoll.text = '';
    qualicontoll.text = '';
    citycontoll.text = '';
    addcontoll.text = '';
    gender = 'Select Gender';
    post = 'Select Post';
    paidfor = 'Registration Fee';
    paidamt = 500;
    imageof = '';
    profilepicname = null;
    signpicname = null;
    addpicname = null;
    qualipicname = null;
  }

  validations() {
    // name
    if (namecontoll.text.replaceAll(' ', '').length < 3) {
      warnigAlert(context: context, messege: 'Please Enter Your Full Name !!!');
      return false;
    }
    appicationdata.name = namecontoll.text;
    //Father
    if (fathercontoll.text.replaceAll(' ', '').length < 3) {
      warnigAlert(context: context, messege: 'Please Enter Father Name !!!');
      return false;
    }
    appicationdata.father = fathercontoll.text;

    //mobile
    if (mobilecontoll.text.replaceAll(' ', '').length != 10 ||
        !RegExp(r"^[0-9]").hasMatch(mobilecontoll.text)) {
      warnigAlert(
          context: context, messege: 'Please Enter 10 Digit Mobile Number !!!');
      return false;
    }
    appicationdata.mobile = mobilecontoll.text;

    appicationdata.email = emailcontoll.text;
    //Qualification
    if (qualicontoll.text.isEmpty) {
      warnigAlert(
          context: context, messege: 'Please Enter Your Max Qualification !!!');
      return false;
    }
    appicationdata.qualification = qualicontoll.text;

    ///City
    if (citycontoll.text.replaceAll(' ', '').length < 3 ||
        RegExp(r"^[0-9]").hasMatch(citycontoll.text)) {
      warnigAlert(context: context, messege: 'Please Enter Your City Name !!!');
      return false;
    }
    appicationdata.city = citycontoll.text;

    //Gender
    if (gender == _genders[0]) {
      warnigAlert(context: context, messege: 'Please Select Your Gender !!!');
      return false;
    }
    appicationdata.gender = gender;
    if (post == _post[0]) {
      warnigAlert(context: context, messege: 'Please Select Applied Post !!!');
      return false;
    }
    appicationdata.post = post;
    if (addcontoll.text.length < 10) {
      warnigAlert(
          context: context, messege: 'Please Enter Your Full Address !!!');
      return false;
    }
    if (profilepicname == null) {
      warnigAlert(context: context, messege: 'Please Upload Your Image');
      return false;
    }
    if (signpicname == null) {
      warnigAlert(
          context: context, messege: 'Please Upload Your Signature Image');
      return false;
    }
    if (addpicname == null) {
      warnigAlert(context: context, messege: 'Please Upload ID/Address Proff');
      return false;
    }
    if (!termacceped) {
      warnigAlert(
          context: context,
          messege: 'Pleae read & accept our terms conditions !!!');
      return false;
    }
    appicationdata.address = addcontoll.text;
    appicationdata.altMobile = altmobilecontoll.text;
    appicationdata.expirence = expicontoll.text;
    appicationdata.appliedfor = paidfor;
    appicationdata.payableamt = paidamt.toString();
    return true;
  }

  _setImage() async {
    hidekeyboard(context: context);
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
      'category': imageof
    });
    Dio dio = Dio();
    dio.post(url, data: data, onSendProgress: (count, total) {}).then((value) {
      if (value.statusCode == 200) {
        var _body = value.data;

        if (imageof == 'Profile') {
          profilepicname = file.name.toString();
          profilepicstatus = ImageSave.fromJson(_body);
          setState(() {});
        }
        if (imageof == 'Signature') {
          signpicname = file.name;
          signpicstatus = ImageSave.fromJson(_body);
          setState(() {});
        }
        if (imageof == 'Address') {
          addpicname = file.name;
          idpicstatus = ImageSave.fromJson(_body);
          setState(() {});
        }
        if (imageof == 'Qualification') {
          qualipicname = file.name;
          markspicstatus = ImageSave.fromJson(_body);
          setState(() {});
        }
      }
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constrains) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: constrains.maxWidth > 800
                    ? 20
                    : constrains.maxWidth > 400
                        ? 10
                        : 2,
                vertical: constrains.maxWidth > 800
                    ? 30
                    : constrains.maxWidth > 400
                        ? 16
                        : 10),
            child: Column(
              children: [
                titelwidget(),
                subtitelwidget(subtitel: 'Application Form'),
                const SizedBox(
                  height: 30.0,
                ),
                buildformrow(
                  hint: "Reffer Details",
                  lable: "Reffer*",
                  controller: reffercontroll,
                  enable: false,
                  keyboard: TextInputType.name,
                ),
                buildformrow(
                  hint: "Enter Your Full Name",
                  lable: "Your Name*",
                  controller: namecontoll,
                  keyboard: TextInputType.name,
                ),
                buildformrow(
                  hint: "Enter Your Father Name",
                  lable: "Father Name*",
                  controller: fathercontoll,
                  keyboard: TextInputType.name,
                ),

                ///Mobile & Altername Mobile
                constrains.maxWidth > 800
                    ? Row(
                        children: [
                          Expanded(
                              child: buildformrow(
                            hint: "Enter Your Mobile Number",
                            lable: "Mobile Number*",
                            controller: mobilecontoll,
                            keyboard: TextInputType.number,
                          )),
                          Expanded(
                              child: buildformrow(
                            hint: "Alternate Mobile Number",
                            lable: "Alternate Mobile",
                            controller: altmobilecontoll,
                            keyboard: TextInputType.number,
                          )),
                        ],
                      )
                    : Column(
                        children: [
                          buildformrow(
                            hint: "Enter Your Mobile Number",
                            lable: "Mobile Number*",
                            controller: mobilecontoll,
                            keyboard: TextInputType.number,
                          ),
                          buildformrow(
                            hint: "Alternate Mobile Number",
                            lable: "Alternate Mobile",
                            controller: altmobilecontoll,
                            keyboard: TextInputType.number,
                          ),
                        ],
                      ),

                ///EMail & Experience
                constrains.maxWidth > 800
                    ? Row(
                        children: [
                          Expanded(
                              child: buildformrow(
                            hint: "Enter Your Email Id",
                            lable: "Email Id",
                            controller: emailcontoll,
                            keyboard: TextInputType.emailAddress,
                          )),
                          Expanded(
                              child: buildformrow(
                            hint: "Your Experience",
                            lable: "Experience",
                            controller: expicontoll,
                            keyboard: TextInputType.text,
                          )),
                        ],
                      )
                    : Column(
                        children: [
                          buildformrow(
                            hint: "Enter Your Email Id",
                            lable: "Email Id",
                            controller: emailcontoll,
                            keyboard: TextInputType.emailAddress,
                          ),
                          buildformrow(
                            hint: "Your Experience",
                            lable: "Experience",
                            controller: expicontoll,
                            keyboard: TextInputType.text,
                          ),
                        ],
                      ),
                //Qualification & City
                constrains.maxWidth > 800
                    ? Row(
                        children: [
                          Expanded(
                              child: buildformrow(
                            hint: "Maximum Qualificaion",
                            lable: "Qualificaion*",
                            controller: qualicontoll,
                            keyboard: TextInputType.text,
                          )),
                          Expanded(
                              child: buildformrow(
                            hint: "City Name",
                            lable: "City*",
                            controller: citycontoll,
                            keyboard: TextInputType.name,
                          )),
                        ],
                      )
                    : Column(
                        children: [
                          buildformrow(
                            hint: "Maximum Qualificaion",
                            lable: "Qualificaion*",
                            controller: qualicontoll,
                            keyboard: TextInputType.text,
                          ),
                          buildformrow(
                            hint: "City Name",
                            lable: "City*",
                            controller: citycontoll,
                            keyboard: TextInputType.name,
                          ),
                        ],
                      ),

                //Drop Down Button
                constrains.maxWidth > 800
                    ? Row(
                        children: [
                          Expanded(
                              child: buidldropdown(
                                  initvalue: gender,
                                  itemslist: _genders,
                                  hinttext: "Select Gender",
                                  onchange: (value) {
                                    hidekeyboard(context: context);
                                    setState(() {
                                      gender = value;
                                    });
                                  })),
                          Expanded(
                              child: buidldropdown(
                                  initvalue: post,
                                  itemslist: _post,
                                  hinttext: "Applied For",
                                  onchange: (value) {
                                    hidekeyboard(context: context);
                                    setState(() {
                                      post = value;
                                    });
                                  })),
                        ],
                      )
                    : Column(
                        children: [
                          buidldropdown(
                              initvalue: gender,
                              hinttext: "Select Gender",
                              itemslist: _genders,
                              onchange: (value) {
                                hidekeyboard(context: context);
                                setState(() {
                                  gender = value;
                                });
                              }),
                          buidldropdown(
                              initvalue: post,
                              hinttext: "Applied For",
                              itemslist: _post,
                              onchange: (value) {
                                hidekeyboard(context: context);
                                setState(() {
                                  post = value;
                                });
                              }),
                        ],
                      ),
                //Payment for fields
                constrains.maxWidth > 800
                    ? Row(
                        children: [
                          Expanded(
                              child: buidldropdown(
                                  initvalue: paidfor,
                                  hinttext: 'Paid For',
                                  itemslist: _paidfor,
                                  onchange: (String value) {
                                    hidekeyboard(context: context);
                                    paidfor = value;
                                    if (value == _paidfor[0]) {
                                      paidamt = 500;
                                    } else {
                                      paidamt = 5500;
                                    }
                                    setState(() {});
                                  })),
                          Expanded(
                            child: buildpaymenttext(payment: paidamt),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          buidldropdown(
                              initvalue: paidfor,
                              itemslist: _paidfor,
                              hinttext: 'Paid For',
                              onchange: (value) {
                                setState(() {
                                  setState(() {
                                    paidfor = value;
                                    if (value == _paidfor[0]) {
                                      paidamt = 500;
                                    } else {
                                      paidamt = 5000;
                                    }
                                  });
                                });
                              }),
                          buildpaymenttext(payment: paidamt),
                        ],
                      ),
                buildformrow(
                  hint: "Enter Your Address",
                  lable: "Address*",
                  controller: addcontoll,
                  keyboard: TextInputType.text,
                ),

                ///Upload Profile & Sign
                constrains.maxWidth > 1000
                    ? Row(
                        children: [
                          Expanded(
                            child: buildimageupload(
                                lable: "Profile Image",
                                status: profilepicname == null
                                    ? "Upload image"
                                    : "Img_profile.jpg",
                                size: constrains.maxWidth,
                                selectimage: () {
                                  imageof = 'Profile';
                                  _setImage();
                                }),
                          ),
                          Expanded(
                            child: buildimageupload(
                                lable: "Your Signature",
                                status: signpicname == null
                                    ? "Upload image"
                                    : "Img_sign.jpg",
                                size: constrains.maxWidth,
                                selectimage: () {
                                  imageof = 'Signature';
                                  _setImage();
                                }),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          buildimageupload(
                              lable: "Profile Image",
                              status: profilepicname == null
                                  ? "Upload image"
                                  : "Img_profile.jpg",
                              size: constrains.maxWidth,
                              selectimage: () {
                                imageof = 'Profile';
                                _setImage();
                              }),
                          buildimageupload(
                              lable: "Your Signature",
                              status: signpicname == null
                                  ? "Upload image"
                                  : "Img_sign.jpg",
                              size: constrains.maxWidth,
                              selectimage: () {
                                imageof = 'Signature';
                                _setImage();
                              })
                        ],
                      ),

                ///Upload Image ID & Qualification
                constrains.maxWidth > 1000
                    ? Row(
                        children: [
                          Expanded(
                            child: buildimageupload(
                                lable: "ID & Address Proff",
                                status: addpicname == null
                                    ? "Upload image"
                                    : "Img_address.jpg",
                                size: constrains.maxWidth,
                                selectimage: () {
                                  imageof = 'Address';
                                  _setImage();
                                }),
                          ),
                          Expanded(
                            child: buildimageupload(
                                lable: "Your Qualification",
                                status: qualipicname == null
                                    ? "Upload image"
                                    : "Img_qualification.jpg",
                                size: constrains.maxWidth,
                                selectimage: () {
                                  imageof = 'Qualification';
                                  _setImage();
                                }),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          buildimageupload(
                              lable: "ID & Address Proff",
                              status: addpicname == null
                                  ? "Upload image"
                                  : "Img_address.jpg",
                              size: constrains.maxWidth,
                              selectimage: () {
                                imageof = 'Address';
                                _setImage();
                              }),
                          buildimageupload(
                              lable: "Your Qualification",
                              status: qualipicname == null
                                  ? "Upload image"
                                  : "Img_qualification.jpg",
                              size: constrains.maxWidth,
                              selectimage: () {
                                imageof = 'Qualification';
                                _setImage();
                              })
                        ],
                      ),
                buildcheckbox(size: constrains.maxWidth),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // buildprocessbtn(
                    //     name: "Previous",
                    //     onpress: () {
                    //       // context.vxNav.push(
                    //       //   Uri(
                    //       //       path: MyRoutes.termRoute,
                    //       //       queryParameters: {"reff": reffid}),
                    //       // );
                    //       Navigator.pushAndRemoveUntil(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const TermsConditionPage(),
                    //           ),
                    //           (route) => false);
                    //     },
                    //     size: constrains.maxWidth),
                    const SizedBox(
                      width: 5.0,
                    ),
                    buildprocessbtn(
                        name: "Next",
                        onpress: () {
                          if (validations()) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentdetailPage()),
                                (route) => false);
                          }
                        },
                        size: constrains.maxWidth),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  buildformrow(
      {required String hint,
      required String lable,
      TextInputType keyboard = TextInputType.text,
      int maxline = 1,
      bool ispassword = false,
      bool enable = true,
      TextEditingController? controller}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: Row(
        children: [
          Expanded(
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
          )
        ],
      ),
    );
  }

  buidldropdown(
      {required List<String> itemslist,
      required initvalue,
      required String hinttext,
      required ValueChanged<String> onchange}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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

  buildpaymenttext({required int payment}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Payable Fees : $payment Rs./-",
        style: const TextStyle(
            fontSize: 24, color: darkprimarycolor, letterSpacing: 1.2),
      ),
    );
  }

  buildimageupload({
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

  buildcheckbox({required double size}) {
    return Row(
      children: [
        Checkbox(
            value: termacceped,
            onChanged: (value) {
              setState(() {
                termacceped = value!;
              });
            }),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsConditionPage()));
            },
            child: "I accept all terms and conditions"
                .text
                .size(size > 800 ? 18 : 12)
                .overflow(TextOverflow.ellipsis)
                .make())
      ],
    );
  }

  buildprocessbtn(
      {required String name, required void Function() onpress, required size}) {
    TextStyle styl = TextStyle(
        fontSize: size > 800
            ? 18.0
            : size > 400
                ? 16
                : 12.0,
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
          width: size > 800
              ? 100
              : size > 400
                  ? 80
                  : 65,
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
