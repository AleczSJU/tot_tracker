import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowChildReportPage extends StatefulWidget {
  const ShowChildReportPage({Key? key, required this.child_id}) : super(key: key);
  final String child_id;

  @override
  _ChildDailyReportPageState createState() => _ChildDailyReportPageState();
}

class _ChildDailyReportPageState extends State<ShowChildReportPage> {
  String id = '';

  @override
  Widget build(BuildContext context) {
    id = widget.child_id;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(id),
      ),
    );
  }
}