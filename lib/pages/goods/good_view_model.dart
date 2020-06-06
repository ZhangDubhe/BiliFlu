import 'dart:convert';

import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
import 'package:flutter/services.dart';

class GoodViewModel {
  Future<List<Good>> fetch() {
    try {
      return rootBundle.loadString('assets/data/goods.json')
          .then((c) => json.decode(c))
          .then((c) => GoodList.fromJson(c))
          .then((c) => c.list);
    } catch (e){
      print(e);
    }
  }

  Future<void> postFrame() {
    GlobalServiceCenter.http.get('http://10.23.99.14:8080/test').then((value) {
      print(value);
    });
  }
}