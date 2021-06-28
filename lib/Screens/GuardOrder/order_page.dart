import 'package:flutter/material.dart';
import 'package:tiger_newemployee/Widgets/dropdown_widget.dart';
import 'package:tiger_newemployee/Widgets/responsive_ui.dart';
import 'package:tiger_newemployee/Widgets/textform_widget.dart';
import 'package:tiger_newemployee/Widgets/titel_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class GuardOrder extends StatefulWidget {
  const GuardOrder({Key? key}) : super(key: key);

  @override
  _GuardOrderState createState() => _GuardOrderState();
}

TextEditingController reffercontroll = TextEditingController();
List<String> dutytype = ['Select Duty Type', 'Monthly Duty', 'Temporary Duty'];
List<String> dutyhrs = ['Select Duty Hours', '8 Hours', '12 Hours', '24 Hours'];
String selecteddutytype = dutytype[0];
String selecteddutyhrs = dutyhrs[0];

class _GuardOrderState extends State<GuardOrder> {
  @override
  void initState() {
    super.initState();
    reffercontroll.text = 'Tiger Group(TSMA111)';
    selecteddutytype = dutytype[0];
    selecteddutyhrs = dutyhrs[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            spacewidget(h: 25.0),
            titelwidget(),
            subtitelwidget(subtitel: 'New Order'),
            spacewidget(h: 10.0),
            Buildtextform(
              lable: 'Referrer',
              hint: 'Enter Referrer Details',
              controller: reffercontroll,
            ),
            const Buildtextform(
              lable: 'Site Name',
              hint: 'Enter Your Site Name/Billing Name',
            ),
            const Buildtextform(
              lable: 'Manager/Owner Name',
              hint: 'Enter Your Manager/Owner Name',
            ),
            const Buildtextform(
              lable: 'Site Address',
              hint: 'Enter Your Site Address',
            ),
            const Buildtextform(
              lable: 'Mobile',
              hint: 'Enter Manager/Owner Mobile Number',
            ),
            const Buildtextform(
              lable: 'Email ID',
              hint: 'Enter Manager/Owner Email ID',
            ),
            ResponsiveUi(
              mobile: buildmobiledrop1(),
              web: buildwebdrop1(),
            ),
            dutytype[2] == selecteddutytype
                ? ResponsiveUi(
                    mobile: Column(
                      children: [
                        buildfromdate(),
                        buildtodate(),
                      ],
                    ),
                    web: Row(
                      children: [
                        buildfromdate(),
                        buildtodate(),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      )),
    );
  }

  buildmobiledrop1() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          buidldropdown(
              hinttext: dutytype[0],
              initvalue: selecteddutytype,
              itemslist: dutytype,
              onchange: (value) {
                setState(() {
                  selecteddutytype = value;
                });
              }),
          buidldropdown(
              hinttext: dutyhrs[0],
              initvalue: selecteddutyhrs,
              itemslist: dutyhrs,
              onchange: (value) {
                setState(() {
                  selecteddutyhrs = value;
                });
              }),
        ],
      ),
    );
  }

  buildwebdrop1() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: buidldropdown(
                hinttext: dutytype[0],
                initvalue: selecteddutytype,
                itemslist: dutytype,
                onchange: (value) {
                  setState(() {
                    selecteddutytype = value;
                  });
                }),
          ),
          Flexible(
            child: buidldropdown(
                hinttext: dutyhrs[0],
                initvalue: selecteddutyhrs,
                itemslist: dutyhrs,
                onchange: (value) {
                  setState(() {
                    selecteddutyhrs = value;
                  });
                }),
          ),
        ],
      ),
    );
  }

  buildfromdate() {
    return const Flexible(
      child: Buildtextform(
        lable: "From Date",
        hint: "Enter From Date",
      ),
    );
  }

  buildtodate() {
    return const Flexible(
      child: Buildtextform(
        lable: "From To",
        hint: "Enter To Date",
      ),
    );
  }
}
