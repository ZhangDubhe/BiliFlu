import 'dart:convert' show json;

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

  int price;
  String name;
  String pic;
  String videoUrl;
  List<String> previews;

  Good.fromParams({this.price, this.name, this.pic, this.videoUrl, this.previews});

  Good.fromJson(jsonRes) {
    price = jsonRes['price'];
    name = jsonRes['name'];
    pic = jsonRes['pic'];
    videoUrl = jsonRes['videoUrl'];
    previews = jsonRes['previews'] == null ? null : [];

    for (var previewsItem in previews == null ? [] : jsonRes['previews']){
      previews.add(previewsItem);
    }
  }

  @override
  String toString() {
    return '{"price": $price,"name": ${name != null?'${json.encode(name)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"videoUrl": ${videoUrl != null?'${json.encode(videoUrl)}':'null'},"previews": $previews}';
  }
}

