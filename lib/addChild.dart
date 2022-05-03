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
    //var url = Uri.http('10.0.0.144', 'addChild.php', {"name":name, "age":age, "gender":gender, "classroom":classroom});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'addChild.php', {"name":name, "age":age, "gender":gender, "classroom":classroom});
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
                // minLines: 3,
                // maxLines: 6,
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
                  // print(name);
                  // print(age);
                  // print(gender);
                  // print(classroom);
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