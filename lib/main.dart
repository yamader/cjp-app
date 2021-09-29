import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cjp/GeneratorPage.dart';
import 'package:cjp/InfoPage.dart';
import 'package:cjp/cjp.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      title: "怪レい日本语",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      routes: {
        "/": (context) => GeneratorPage(),
        "/info": (context) => InfoPage(),
      },
      initialRoute: '/',
    );
  }
}