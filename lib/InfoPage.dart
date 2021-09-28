import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

// PackageInfo pkgInfo=await PackageInfo.fromPlatform();
// pkgInfo.version;

class InfoPage extends StatelessWidget {
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