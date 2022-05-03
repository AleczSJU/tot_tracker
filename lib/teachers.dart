import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/dashboard.dart';
import 'package:tot_tracker/addTeacher.dart';
import 'package:tot_tracker/teacherCard.dart';

List teachers = [];

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  getTeachers()async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getAllTeachers.php');
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getAllTeachers.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        teachers = json.decode(response.body);
      });
    }
    print(teachers);
    print(teachers.length);
    return teachers;
  }

  @override
  void initState() {
    super.initState();
    teachers = [];
    getTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage())),
        ),
        title: const Text('Teachers'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            tooltip: 'Add Child',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTeacherPage())),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 170,
          childAspectRatio: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 1,
        ),
        itemCount: teachers.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            child: Card(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeacherCardPage(tName: teachers[index]['name'])));
                },
                splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 14,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/teacher.png")
                          )
                      ),
                    ),
                    Text(teachers[index]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}







