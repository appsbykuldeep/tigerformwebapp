import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiger_newemployee/Constants/const_color.dart';

successAlert(
    {required BuildContext context,
    required String messege,
    String titel = "Success",
    double width = 250,
    bool autodismiss = true}) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.success,
    text: messege,
    title: titel,
    confirmBtnText: 'Done',
    autoCloseDuration: const Duration(seconds: 3),
    flareAnimationName: 'play',
    width: width,
  );
}

faildAlert(
    {required BuildContext context,
    required String messege,
    String titel = "Failed",
    double width = 250,
    bool autodismiss = true}) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.error,
    text: messege,
    title: titel,
    confirmBtnText: 'OK',
    autoCloseDuration: const Duration(seconds: 3),
    flareAnimationName: 'play',
    width: width,
  );
}

warnigAlert(
    {required BuildContext context,
    required String messege,
    String titel = "Warning",
    double width = 250,
    bool autodismiss = true}) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    text: messege,
    title: titel,
    confirmBtnText: 'OK',
    onConfirmBtnTap: () {
      Navigator.pop(context);
    },
    flareAnimationName: 'play',
    width: width,
  );
}

loadingAlert(
    {required BuildContext context,
    String titel = "Please Wait",
    double width = 250,
    bool autodismiss = true}) {
  CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      width: width,
      barrierDismissible: false,
      backgroundColor: primarycolor);
}
