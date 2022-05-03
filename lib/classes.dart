import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/dashboard.dart';
import 'package:tot_tracker/addClass.dart';
import 'package:tot_tracker/classCard.dart';

List classrooms = [];

class ClassesPage extends StatefulWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  getClassrooms()async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getClassrooms.php');
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getClassrooms.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        classrooms = json.decode(response.body);
      });
    }
    print(classrooms);
    print(classrooms.length);
    return classrooms;
  }

  @override
  void initState() {
    super.initState();
    classrooms = [];
    getClassrooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage())),
        ),
        title: const Text('Classrooms'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            tooltip: 'Add Child',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddClassPage())),
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
        itemCount: classrooms.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            child: Card(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClassCardPage(className: classrooms[index]['name'])));
                },
                splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 14,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: AssetImage("assets/teacher.png")
                      //     )
                      // ),
                      child: Icon(Icons.home, size:50.0, color:Colors.black),
                    ),
                    Text(classrooms[index]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
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







