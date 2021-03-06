import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/showReport.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({Key? key, required this.childName, required this.className}) : super(key: key);
  final String childName;
  final String className;

  @override
  _AddReportPageState createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name = '';
  String report = '';
  String cName = '';

  @override
  void initState() {
    super.initState();
  }

  _submit()async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'makeReport.php', {"report":newReport, "childName":name});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'makeReport.php', {"report":report, "childName":name});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.childName;
    cName = widget.className;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowChildReportPage(childName: name, className: cName))),
        ),
        title: const Text('Make a report'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'New Report:'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Report cannot be empty';
                  }
                },
                minLines: 10,
                maxLines: 20,
                onSaved: (value) {
                  report = value!;
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if(!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  // print(name);
                  // print(age);
                  // print(gender);
                  // print(classroom);
                  _submit();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowChildReportPage(childName: name, className: cName)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
