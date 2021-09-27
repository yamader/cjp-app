import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("このアプリについて"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("あ"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 15,),
              child: Text(
                "© 2021 YamaD",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class InfoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}