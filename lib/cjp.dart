import 'dart:convert';
import 'package:tuple/tuple.dart';
import 'package:flutter/services.dart';

typedef StrDict=Map<String,dynamic>; // ほんとは<String,String>にしたいんだけど……
typedef IntPair=Tuple2<int,int>;

var _isDictReady=false;
StrDict? _dictCommon,
         _dictPNoun,
         _dictKana,
         _dictKanji,
         _dictEmoji;

class CJP {
  static Future<void> loadDict() async {
    if(!_isDictReady) {
      await Future.wait([
        rootBundle.loadString("assets/cjp.js/dict/common.json")
          .then((d){_dictCommon=jsonDecode(d);}),
        rootBundle.loadString("assets/cjp.js/dict/propernoun.json")
          .then((d){_dictPNoun=jsonDecode(d);}),
        rootBundle.loadString("assets/cjp.js/dict/kana.json")
          .then((d){_dictKana=jsonDecode(d);}),
        rootBundle.loadString("assets/cjp.js/dict/kanji.json")
          .then((d){_dictKanji=jsonDecode(d);}),
        rootBundle.loadString("assets/cjp.js/dict/emoji.json")
          .then((d){_dictEmoji=jsonDecode(d);}),
      ]);
      _isDictReady=true;
    }
  }
  static String generate(String text) {
    if(!_isDictReady){ // このコードをコピペする人用
      loadDict();
      return text;
    }
    if(text=="")return text;
    var data=_StrData(text,[]);
    data=_procStrDataWithDict(data,_dictEmoji!);
    data=_procStrDataWithDict(data,_dictPNoun!);
    data=_procStrDataWithDict(data,_dictCommon!);
    data=_procStrDataWithDict(data,_dictKana!);
    data=_procStrDataWithDict(data,_dictKanji!);
    return data.text;
  }
}

class _StrData {
  _StrData(this.text,this.processedIdx);
  String text;
  List<IntPair> processedIdx;
}

_StrData _procStrDataWithDict(_StrData data,StrDict dict){
  if(data.text.length==0)return data;
  for(final reStr in dict.keys){
    final RegExp re=RegExp(reStr);
    final String correctStr=dict[reStr]!;
    final List<String>
      matched=re.allMatches(data.text).map((d)=>d[0]!).toList(),
      unmatched=data.text.split(re);

    List<String> result=[];
    bool changed=false;
    int cursor=0;

    for(var i=0;i<matched.length;i++){
      result.add(unmatched[i]);
      cursor+=unmatched[i].length;

      final String incorrectStr=matched[i];
      final correctEnd=cursor+correctStr.length-1;

      if(data.processedIdx.any((d)=>
            (d.item1<=cursor&&cursor<=d.item2)
          ||(d.item1<=correctEnd&&correctEnd<=d.item2))){
        // 以前(別の正レい単語を)処理した範囲と被ってた場合
        result.add(incorrectStr);
        cursor+=incorrectStr.length;
      } else {
        result.add(correctStr);
        data.processedIdx.add(IntPair(cursor,correctEnd));
        changed=true;
        if(correctStr.length!=incorrectStr.length){
          // ずらさなければいけない
          final diffLen=correctStr.length-incorrectStr.length;
          data.processedIdx=data.processedIdx.map((d)=>cursor<d.item1
            ? IntPair(d.item1+diffLen,d.item2+diffLen)
            : d).toList();
        }
      }
    }

    if(changed){
      result.add(unmatched.last);
      data.text=result.join();
    }
  }
  return data;
}