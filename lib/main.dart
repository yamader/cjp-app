import 'package:flutter/material.dart';
import 'package:cjp/GeneratorPage.dart';
import 'package:cjp/InfoPage.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "怪レい日本语",
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }
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