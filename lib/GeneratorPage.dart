import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cjp/cjp.dart';

class GeneratorPage extends StatefulWidget {
  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final _inputTextController=TextEditingController();
  final _resTextController=TextEditingController();

  void _changeText(String val){
    setState((){
      _resTextController.text=CJP.generate(val);
    });
  }

  void _clipCopy() async {
    if(_resTextController.text.length==0){
      Fluttertoast.showToast(msg: "Empty");
      return;
    }
    final data=ClipboardData(text: _resTextController.text);
    await Clipboard.setData(data);
    Fluttertoast.showToast(msg: "Copied");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("怪レい日本语 (軽い方)"),
          actions: [
            IconButton(
              onPressed: ()=>Navigator.pushNamed(context,"/info"),
              icon: Icon(Icons.info_outline),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 15,top: 20,right: 15,),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
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
                  margin: EdgeInsets.only(left: 15,top: 20,right: 15,),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "正レい日本语が出力されゑ!(予定)",
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 60,
                decoration: BoxDecoration(
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
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                    Positioned(
                      height: 110,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final data=await Clipboard.getData(Clipboard.kTextPlain);
                              if(data?.text==null){
                                Fluttertoast.showToast(msg: "Couldn't paste");
                                return;
                              } else if(data?.text==""){
                                Fluttertoast.showToast(msg: "Clipboard empty");
                                return;
                              } else {
                                _inputTextController.text=data?.text??""; // どうして……
                                Fluttertoast.showToast(msg: "Pasted");
                                _changeText(_inputTextController.text);
                              }
                            },
                            icon: Icon(Icons.paste),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: (){
                              if(_resTextController.text.length==0){
                                Share.share("贵樣!");
                                return;
                              }
                              Share.share(_resTextController.text);
                            },
                            icon: Icon(Icons.share),
                          ),
                          IconButton(
                            onPressed: _clipCopy,
                            icon: Icon(Icons.copy),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
