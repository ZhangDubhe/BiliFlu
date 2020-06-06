import 'package:bilibiliflu/pages/goods/good_view_model.dart';
import 'package:flutter/material.dart';

class TestDemo extends StatefulWidget {
  @override
  _TestDemoState createState() => _TestDemoState();
}

class _TestDemoState extends State<TestDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(20),
      child: Center(
        child: RaisedButton(
        child: Text('Test'),
        onPressed: _test,),
      ),
    );
  }
  GoodViewModel viewModel = GoodViewModel();
  void _test() {
    viewModel.postFrame();
  }
}
