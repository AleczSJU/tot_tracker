import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/classes.dart';

class AddClassPage extends StatefulWidget {
  const AddClassPage({Key? key}) : super(key: key);

  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name = '';

  _submit()async {
    //Local usage
    var url = Uri.http('10.0.0.144', 'addClass.php', {"name":name});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'addClass.php', {"name":name});
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
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassesPage())),
        ),
        title: const Text('Add a Classroom'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Classroom name'),
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
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if(!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  print(name);
                  _submit();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassesPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}