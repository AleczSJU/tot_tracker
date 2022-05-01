import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/children.dart';

class AddChildPage extends StatefulWidget {
  const AddChildPage({Key? key}) : super(key: key);

  @override _AddChildPageState createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name = '';
  String age = '';
  String gender = '';
  String classroom = '';

  _submit()async {
    //Local usage
    var url = Uri.http('10.0.0.144', 'addChild.php', {"name":name, "age":age, "gender":gender, "classroom":classroom});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'addChild.php', {"name":name, "age":age, "gender":gender, "classroom":classroom});
    var response = await http.get(url);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChildrenPage())),
        ),
        title: const Text('Add a Child'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name cannot be empty';
                  }
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Age cannot be empty';
                  }
                },
                onSaved: (value) {
                  age = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Gender cannot be empty';
                  }
                },
                onSaved: (value) {
                  gender = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Classroom'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Classroom cannot be empty';
                  }
                },
                onSaved: (value) {
                  classroom = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if(!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  print(name);
                  print(age);
                  print(gender);
                  print(classroom);
                  _submit();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChildrenPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}