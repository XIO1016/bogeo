import 'package:capstone/src/binding/init_bindings.dart';
import 'package:capstone/src/pages/eatpill.dart';
import 'package:capstone/src/pages/login.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'src/app.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '복어',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      initialBinding: InitBinding(),
      initialRoute: '/App',
      getPages: [
        GetPage(name: '/', page: () => Login()),
        GetPage(name: '/App', page: () => const App()),
        GetPage(
          name: '/Home',
          page: () => const MainHome(),
        ),
        GetPage(
          name: '/Eatpill',
          page: () => const EatPillPage(),
        )
      ],
    );
  }
}
