import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class GoodList extends StatefulWidget {
  @override
  GoodListState createState() => new GoodListState();
}

class GoodListState extends State<GoodList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(''),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(GoodList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class ListViewModel {
  fetch () async {
    var res = await rootBundle.load('assets/data/goods.json');
    print(res);

  }
}