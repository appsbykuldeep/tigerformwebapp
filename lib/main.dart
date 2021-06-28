import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Screens/GuardOrder/order_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Fluroroutes.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   title: 'Tiger Group',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.brown,
    //   ),
    //   routeInformationParser: VxInformationParser(),
    //   routerDelegate: VxNavigator(
    //     notFoundPage: (uri, params) {
    //       return const MaterialPage(child: SplashSceen());
    //     },
    //     routes: {
    //       "/": (uri, data) {
    //         final reffer = uri.queryParameters['reff'];
    //         final action = uri.queryParameters['action'];

    //         return MaterialPage(
    //             child: SplashSceen(
    //           refferr: reffer ?? '',
    //           action: action ?? '',
    //         ));
    //       },
    //       MyRoutes.formRoute: (uri, data) {
    //         return const MaterialPage(child: NewFormPage());
    //       }
    //     },
    //   ),
    // );
    // frompage = 'Terms';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const GuardOrder());
  }
}
