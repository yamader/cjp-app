import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";
// import "package:package_info_plus/package_info_plus.dart";
import "package:fluttertoast/fluttertoast.dart";

// PackageInfo pkgInfo=await PackageInfo.fromPlatform();
// pkgInfo.version;

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("このアプリについて"),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      _InfoContainer([
                        _InfoRowSideBySide.textBoth("ほげ", "ふが"),
                      ]),
                      _InfoContainer([
                        _InfoRowSideBySide.textBoth("ほげ", "ふが"),
                        _InfoRowSideBySide.textBoth("ほげ", "ふが"),
                      ]),
                      _InfoContainer([
                        _InfoRowSideBySide.textTitle(
                            "ソースコード",
                            const _TextLink("github.com",
                                "https://github.com/yamader/cjp-app")),
                      ]),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 35,
                ),
                child: const _TextLink(
                  "© 2021 YamaD",
                  "https://yamad.me",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _InfoContainer extends StatelessWidget {
  const _InfoContainer(this._children);
  final List<Widget> _children;

  @override
  Widget build(BuildContext context) => _children.isEmpty
      ? const SizedBox.shrink()
      : Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(children: _children),
        );
}

class _InfoRowSideBySide extends StatelessWidget {
  const _InfoRowSideBySide(this._left, this._right);
  final Widget _left, _right;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_left, _right],
      );

  static textTitle(String title, Widget right) =>
      _InfoRowSideBySide(Text(title), right);
  static textBoth(String title, String desc) => textTitle(title, Text(desc));
}

class _TextLink extends Text {
  const _TextLink(text, this._url, {TextStyle? style})
      : super(text, style: style);
  final String _url;
  @override
  Widget build(BuildContext context) => InkWell(
        child: super.build(context),
        onTap: () => _launchUrl(_url),
      );
}

Future<void> _launchUrl(String urlString) async {
  final url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    Fluttertoast.showToast(msg: "リンクを開けません?!");
  }
}
