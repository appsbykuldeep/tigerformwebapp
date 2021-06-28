// import 'package:fluro/fluro.dart';
// import 'package:flutter/material.dart';
// import 'package:tiger_newemployee/Screens/NewForm/SplashSceen/splash_screen.dart';
// import 'package:tiger_newemployee/Screens/NewForm/terms_page.dart';

// class Fluroroutes {
//   static final FluroRouter router = FluroRouter();

//   static final Handler _inittial = Handler(
//       handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
//           const SplashSceen());

//   static final Handler _inittial2 = Handler(
//       handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
//           SplashSceen(name: params['name'][0]));

//   static final Handler _termpage = Handler(
//       handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
//           TermsConditionPage(name: params['name'][0]));

//   static void setupRouter() {
//     router.define(
//       '/',
//       handler: _inittial,
//     );
//     router.define(
//       '/:name',
//       handler: _inittial2,
//     );
//     router.define(
//       '/newapplication/:name',
//       handler: _termpage,
//       transitionType: TransitionType.fadeIn,
//     );
//     router.define(
//       '/newapplication/:name/:extra1',
//       handler: _inittial,
//       transitionType: TransitionType.fadeIn,
//     );
//     router.define(
//       '/newapplication/:name/:extra2',
//       handler: _inittial,
//       transitionType: TransitionType.fadeIn,
//     );
//   }
// }
