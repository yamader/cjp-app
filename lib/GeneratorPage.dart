import 'package:flutter/material.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("怪しい日本語(軽い方)"),
          centerTitle: true,
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
                        color: Color(0xffdddddd),
                        spreadRadius: 10,
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Scrollbar(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "変換する文章を入力...",
                      ),
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
                        color: Color(0xffdddddd),
                        spreadRadius: 10,
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Scrollbar(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "怪レい日本语が出力されゑ",
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 20,),
                decoration: BoxDecoration(
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 4,
                      blurRadius: 6,
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
