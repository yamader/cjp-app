import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:share_plus/share_plus.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:cjp/cjp.dart";

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final _inputTextController = TextEditingController();
  final _resTextController = TextEditingController();

  void _changeText(String val) {
    setState(() {
      _resTextController.text = CJP.generate(val);
    });
  }

  void _clipCopy() async {
    if (_resTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Empty");
      return;
    }
    final data = ClipboardData(text: _resTextController.text);
    await Clipboard.setData(data);
    Fluttertoast.showToast(msg: "Copied");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("怪レい日本语"),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, "/about"),
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: CJP.loadDict(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasError) {
                // 明らかなエラー
                Fluttertoast.showToast(msg: "辞書を読み込めません?!");
                return const Text(
                  "(՞ةڼ◔)",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 100,
                    fontWeight: FontWeight.w900,
                  ),
                );
              }
              if (!snapshot.hasData) {
                // ローディング
                return const SizedBox.shrink();
              } else {
                if (!snapshot.data!) {
                  // そんなことはないと思うけど
                  Fluttertoast.showToast(msg: "辞書が読み込まれていません?!");
                  return const Text(
                    "(՞ةڼ◔)",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 100,
                      fontWeight: FontWeight.w900,
                    ),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          top: 20,
                          right: 15,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffeeeeee),
                              spreadRadius: 10,
                              blurRadius: 25,
                            ),
                          ],
                        ),
                        child: Scrollbar(
                          child: TextField(
                            controller: _inputTextController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "変換する文章を入力...",
                            ),
                            onChanged: _changeText,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          top: 20,
                          right: 15,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffeeeeee),
                              spreadRadius: 10,
                              blurRadius: 25,
                            ),
                          ],
                        ),
                        child: Scrollbar(
                          child: TextField(
                            controller: _resTextController,
                            maxLines: null,
                            expands: true,
                            readOnly: true,
                            onTap: _clipCopy,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "正レい日本语が出力されゑ!",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 65,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffeeeeee),
                            spreadRadius: 0,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Positioned(
                            height: 120,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final data = await Clipboard.getData(
                                        Clipboard.kTextPlain);
                                    if (data?.text == null) {
                                      Fluttertoast.showToast(
                                          msg: "Couldn't paste");
                                      return;
                                    } else if (data?.text == "") {
                                      Fluttertoast.showToast(
                                          msg: "Clipboard empty");
                                      return;
                                    } else {
                                      _inputTextController.text =
                                          data?.text ?? ""; // どうして……
                                      Fluttertoast.showToast(msg: "Pasted");
                                      _changeText(_inputTextController.text);
                                    }
                                  },
                                  icon: const Icon(Icons.paste),
                                  color: Colors.white,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_resTextController.text.isEmpty) {
                                      Share.share("贵樣!");
                                      return;
                                    }
                                    Share.share(_resTextController.text);
                                  },
                                  icon: const Icon(Icons.share),
                                ),
                                IconButton(
                                  onPressed: _clipCopy,
                                  icon: const Icon(Icons.copy),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      );
}
