import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("このアプリについて"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Text("ああああああああああああああああああああああ")
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text("(c) 2021 YamaD"),
            ),
          ],
        ),
      )
    );
  }
}