import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

bool _isReady=false;
dynamic _dictCommon,
        _dictPNoun,
        _dictKana,
        _dictKanji,
        _dictEmoji;

Future<String> genCorrectJP({String text=""}) async {
  if(!_isReady) {
    _dictCommon=jsonDecode(await rootBundle.loadString(
        "assets/cjp.js/dict/common.json"));
    _dictPNoun=jsonDecode(await rootBundle.loadString(
        "assets/cjp.js/dict/propernoun.json"));
    _dictKana=jsonDecode(await rootBundle.loadString(
        "assets/cjp.js/dict/kana.json"));
    _dictKanji=jsonDecode(await rootBundle.loadString(
        "assets/cjp.js/dict/kanji.json"));
    _dictEmoji=jsonDecode(await rootBundle.loadString(
        "assets/cjp.js/dict/emoji.json"));
    _isReady=true;
  }
  var data=_StrData(text: text,replaced: []);
  data=_replace(data,_dictEmoji);
  data=_replace(data,_dictPNoun);
  data=_replace(data,_dictCommon);
  data=_replace(data,_dictKana);
  data=_replace(data,_dictKanji);
  return data.text;
}

class _StrData {
  _StrData({this.text="",this.replaced=const[]});
  String text;
  var replaced;
}

class _Replaced {
  _Replaced({required this.begin,required this.end});
  int begin,end;
}

_StrData _replace(_StrData data,dict){
  if(data.text.length==0)return data;
  for(final orig in dict){
    final translateStr=[];
    final re=RegExp(orig);
    final splited=data.text.split(re);
    var changed=false;

    for(var i=0;i<splited.length-1;i++){
      final origStr=data.text.match(re)[i];
      final correctStr=dict[orig];

      translateStr.add(splited[i]);

      final begin=translateStr.join().length;
      final origEnd=begin+origStr.length-1;

      if(data.replaced.some((d)=>(d.begin<=begin&&begin<=d.end)
                               ||(d.begin<=origEnd&&origEnd<=d.end))){
        translateStr.add(origStr);
        continue;
      } else {
        translateStr.add(correctStr);
        changed=true;
        if(origStr.length==correctStr.length){
          data.replaced.add({ begin: begin, end: origEnd });
        } else {
          final diffLen=correctStr.length-origStr.length;
          data.replaced.add({ begin: begin, end: origEnd+diffLen });
          data.replaced=data.replaced.map((d)=>begin<d.begin
              ? { begin: d.begin+diffLen, end: d.end+diffLen }
              : d);
        }
      }
    }
    if(changed){
      translateStr.add(splited.slice(-1)[0]);
      data.text=translateStr.join();
    }
  }
  return data;
}