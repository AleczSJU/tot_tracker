import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassroomDailyReportPage extends StatefulWidget {
  const ClassroomDailyReportPage({Key? key, required this.className}) : super(key: key);
  final String className;

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<ClassroomDailyReportPage> {
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
    );
  }
}