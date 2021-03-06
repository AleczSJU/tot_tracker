import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/teachers.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({Key? key}) : super(key: key);

  @override _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name = '';
  String age = '';
  String gender = '';
  String email = '';
  String phoneNumber = '';
  String? classroom = null;
  List roomNames = [];
  List<String> _classrooms = [];

  getAllClassrooms()async{
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getClassrooms.php');
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getClassrooms.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        roomNames = json.decode(response.body);
      });
      //print(roomNames);
      //print(roomNames.length);
      for(int i = 0; i<roomNames.length; i++) {
        _classrooms.insert(i, roomNames[i]['name']);
      }
      return roomNames;
    }
  }

  _submit()async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'addTeacher.php', {"name":name, "age":age, "gender":gender, "email":email, "phoneNumber":phoneNumber, "classroom":classroom});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'addTeacher.php', {"name":name, "age":age, "gender":gender, "email":email, "phoneNumber":phoneNumber, "classroom":classroom});
    var response = await http.get(url);
  }

  @override
  void initState() {
    super.initState();
    getAllClassrooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeacherPage())),
        ),
        title: const Text('Add a Teacher'),
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
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Gender cannot be empty';
                  }
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Gender cannot be empty';
                  }
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Classroom'),
                validator: (value) => value == null ? "Select a classroom" : null,
                value: classroom,
                onChanged: (String? newValue) {
                  setState(() {
                    classroom = newValue!;
                  });
                },
                items: _classrooms.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
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
                  print(email);
                  print(phoneNumber);
                  print(classroom);
                  _submit();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeacherPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}