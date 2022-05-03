import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/roomPage.dart';

class AddPlanPage extends StatefulWidget {
  const AddPlanPage({Key? key, required this.className, required this.planDate}) : super(key: key);
  final String className;
  final String planDate;

  @override
  _AddPlanPageState createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name = '';
  String plan = '';
  String date = '';

  @override
  void initState() {
    super.initState();
  }

  _submit()async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'makePlan.php', {"plan":plan, "className":name, "date":date});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'makePlan.php', {"plan":plan, "className":name, "date":date});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.className;
    date = widget.planDate;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoomPage(className: name))),
        ),
        title: const Text('Create a lesson plan'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'New Plan:'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Plan cannot be empty';
                  }
                },
                minLines: 10,
                maxLines: 20,
                onSaved: (value) {
                  plan = value!;
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoomPage(className: name)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
