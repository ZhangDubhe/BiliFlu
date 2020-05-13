import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Playing'),),
      body: ListView(
        children: <Widget>[
          _dateWidget()
        ],
      ),
    );
  }
  DateTime _selectedDate = DateTime.now();

  Widget _dateWidget() {
    return CalendarDatePicker(
      initialDate: _selectedDate,
      onDateChanged: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
      firstDate: DateTime(1996, 5, 1),
      lastDate: DateTime(2021, 5, 31),
    );
  }
}
