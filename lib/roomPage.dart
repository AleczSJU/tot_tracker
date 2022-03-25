import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tot_tracker/calendar.dart';
import 'package:http/http.dart' as http;

List names = [];
int i = 0;

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key, required this.className}) : super (key: key);
  final String className;

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    name = widget.className;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(name),
      ),
      body: Center(
        child: Calendar(className: name),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
