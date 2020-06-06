import 'dart:convert' show json;
import 'package:bilibiliflu/models/suit.dart';

class GoodList {

  List<Good> list;

  GoodList.fromParams({this.list});

  factory GoodList(jsonStr) => jsonStr == null ? null : jsonStr is String ? new GoodList.fromJson(json.decode(jsonStr)) : new GoodList.fromJson(jsonStr);

  GoodList.fromJson(jsonRes) {
    list = jsonRes['list'] == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes['list']){
      list.add(listItem == null ? null : new Good.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"list": $list}';
  }
}

class Good {
  String id;
  int price;
  String name;
  String desc;
  String pic;
  String videoUrl;
  List<String> previews;
  List<Suit> suits;

  Good.fromParams({this.id, this.price, this.name, this.desc, this.pic, this.videoUrl, this.previews, this.suits});

  Good.fromJson(jsonRes) {
    id = jsonRes['id'];
    price = jsonRes['price'];
    desc = jsonRes['desc'] ?? '这个手办非常奈斯，可以说话可以跳舞';
    name = jsonRes['name'];
    pic = jsonRes['pic'];
    videoUrl = jsonRes['videoUrl'];
    previews = jsonRes['previews'] == null ? null : [];

    for (var previewsItem in previews == null ? [] : jsonRes['previews']){
      previews.add(previewsItem);
    }

    suits = jsonRes['suits'] == null ? null : [];

    for (var suitsItem in suits == null ? [] : jsonRes['suits']){
      suits.add(suitsItem == null ? null : new Suit.fromJson(suitsItem));
    }
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'}, "price": $price,"name": ${name != null?'${json.encode(name)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"videoUrl": ${videoUrl != null?'${json.encode(videoUrl)}':'null'},"previews": $previews,"suits": $suits}';
  }
}


