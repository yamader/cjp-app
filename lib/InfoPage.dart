import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                  _InfoContainer([
                    _InfoRowSideBySide.textBoth("ほげ","ふが"),
                  ]),
                  _InfoContainer([
                    _InfoRowSideBySide.textTitle(
                      "ソースコード",
                      _TextLink("github.com","https://github.com/yamader/cjp")),
                  ])
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 15,),
              child: _TextLink(
                "© 2021 YamaD",
                "https://www.dyama.net",
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

class _InfoContainer extends StatelessWidget {
  const _InfoContainer(this._children);
  final List<Widget> _children;

  @override
  Widget build(BuildContext context)=>_children.length==0?SizedBox.shrink():
    Container(
      child: Column(children: _children),
      decoration: BoxDecoration(
      ),
    );
}
class _InfoRowSideBySide extends StatelessWidget {
  const _InfoRowSideBySide(this._left,this._right);
  final Widget _left,_right;
  @override
  Widget build(BuildContext context)=>
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_left,_right],
      ),
    );

  static textTitle(String _title,Widget _right)=>
    _InfoRowSideBySide(
      Text(_title),
      _right);
  static textBoth(String _title,String _desc)=>
    textTitle(_title,
      Text(_desc));
}

class _TextLink extends Text {
  const _TextLink(_text,this._url,{TextStyle? style})
    : super(_text,style:style);
  final String _url;
  @override
  Widget build(BuildContext context)=>
    InkWell(
      child: super.build(context),
      onTap: ()=>_launchUrl(_url),
    );
}

Future<void> _launchUrl(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    Fluttertoast.showToast(msg: "リンクを開けません?!");
}