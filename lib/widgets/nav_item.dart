import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _gotoPage(context),
      child: child??Text('$routeName'),
    );
  }

  void _gotoPage(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }



  final String routeName;
  final Object arguments;
  final Widget child;

  NavItem({
    this.routeName,
    this.arguments,
    this.child
  });
}
