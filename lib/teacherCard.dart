import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/teachers.dart';

// List childInfo = [];
// int i = 0;

class TeacherCardPage extends StatefulWidget {
  const TeacherCardPage({Key? key, required this.tName}) : super(key: key);
  final String tName;

  @override
  _TeacherCardPageState createState() => _TeacherCardPageState();
}

class _TeacherCardPageState extends State<TeacherCardPage> {
  String name = "";
  List teacherInfo = [];
  int i = 0;

  getInfo(String name)async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getInfoForTeacher.php', {"name":name});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getInfoForTeacher.php', {"name":name});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        teacherInfo = json.decode(response.body);
      });
    }
    //print(teacherInfo);
    //print(teacherInfo.length);
    return teacherInfo;
  }

  @override
  void initState() {
    super.initState();
    //getInfo();
    teacherInfo = [];
  }

  deleteTeacher(String teacher_id)async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'deleteTeacher.php', {"teacherid":teacher_id});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'deleteTeacher.php', {"teacherid":teacher_id});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.tName;
    getInfo(name);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.close, color: Colors.white),
        //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChildrenPage())),
        // ),
        title: Text(name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            "           Name: ",
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: ListTile(
              //minVerticalPadding: 10,
              title: Text("   " + teacherInfo[0]["name"]),
              contentPadding: EdgeInsets.all(5.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          SizedBox(height: 10),
          Text(
            "           Age: ",
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: ListTile(
              //minVerticalPadding: 10,
              title: Text("   " + teacherInfo[0]["age"]),
              contentPadding: EdgeInsets.all(5.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          SizedBox(height: 10),
          Text(
            "           Gender: ",
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: ListTile(
              //minVerticalPadding: 10,
              title: Text("   " + teacherInfo[0]["gender"]),
              contentPadding: EdgeInsets.all(5.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          SizedBox(height: 10),
          Text(
            "           Email: ",
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: ListTile(
              //minVerticalPadding: 10,
              title: Text("   " + teacherInfo[0]["email"]),
              contentPadding: EdgeInsets.all(5.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          SizedBox(height: 10),
          Text(
            "           Phone Number: ",
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: ListTile(
              //minVerticalPadding: 10,
              title: Text("   " + teacherInfo[0]["phone_number"]),
              contentPadding: EdgeInsets.all(5.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          SizedBox(height: 10),
          Text(
            "           Classroom: ",
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: ListTile(
              //minVerticalPadding: 10,
              title: Text("   " + teacherInfo[0]["className"]),
              contentPadding: EdgeInsets.all(5.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          SizedBox(height: 40),
          Align(
            child: MaterialButton(
              height: 50,
              //When pressed it brings you to home screen nav page
              onPressed: () {
                deleteTeacher(teacherInfo[0]["teacher_id"]);
                Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherPage()));
              },
              color: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text("Remove Teacher",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}