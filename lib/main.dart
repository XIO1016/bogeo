import 'dart:io';

import 'package:capstone/src/binding/init_bindings.dart';
import 'package:capstone/src/pages/add/addpill.dart';
import 'package:capstone/src/pages/add/addpilltodata.dart';
import 'package:capstone/src/pages/eatpill.dart';
import 'package:capstone/src/pages/login.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'src/app.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '복어',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff0057A8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle:
              TextStyle(color: Color(0xff505050), fontFamily: 'Sans'),
        ),
      ),
      initialBinding: InitBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Login()),
        GetPage(name: '/App', page: () => const App()),
        GetPage(
          name: '/Home',
          page: () => MainHome(),
        ),
        GetPage(
          name: '/Eatpill',
          page: () => EatPillPage(),
        ),
        GetPage(
          name: '/AddPill',
          page: () => addpillPage(),
        ),
        GetPage(
          name: '/AddPilltoData',
          page: () => AddPillToData(),
        ),
      ],
    );
  }
}
