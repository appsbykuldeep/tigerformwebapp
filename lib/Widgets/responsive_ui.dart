import 'package:flutter/material.dart';

class ResponsiveUi extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? web;
  final double? mobilePoint;
  final double? tabPoint;
  final double? webPoint;

  const ResponsiveUi(
      {Key? key,
      this.mobile,
      this.tablet,
      this.web,
      this.mobilePoint = 750,
      this.tabPoint = 1100,
      this.webPoint = 2500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double _width = constrains.maxWidth;
      if (_width < mobilePoint!) {
        if (mobile != null) {
          return mobile!;
        } else if (tablet != null) {
          return tablet!;
        } else {
          return web!;
        }
      } else if (_width < tabPoint!) {
        if (tablet != null) {
          return tablet!;
        } else if (web != null) {
          return web!;
        } else {
          return mobile!;
        }
      } else {
        if (web != null) {
          return web!;
        } else if (mobile != null) {
          return mobile!;
        } else {
          return tablet!;
        }
      }
    });
  }
}
