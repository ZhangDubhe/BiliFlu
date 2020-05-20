import 'dart:convert' show json;

class Suit {

  String id;
  String name;
  String pic;

  Suit.fromParams({this.id, this.name, this.pic});

  Suit.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    pic = jsonRes['pic'];
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'}}';
  }
}