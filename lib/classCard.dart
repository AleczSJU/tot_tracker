import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/classes.dart';

// List childInfo = [];
// int i = 0;

class ClassCardPage extends StatefulWidget {
  const ClassCardPage({Key? key, required this.className}) : super(key: key);
  final String className;

  @override
  _ClassCardPageState createState() => _ClassCardPageState();
}

class _ClassCardPageState extends State<ClassCardPage> {
  String name = "";
  List classInfo = [];
  //int i = 0;
  // String id = '';
  // String count = '';
  String nName = '';
  late TextEditingController controller;

  getInfo(String name)async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getInfoForClass.php', {"name":name});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getInfoForClass.php', {"name":name});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        classInfo = json.decode(response.body);
      });
    }
    //print(classInfo);
    //print(classInfo.length);
    return classInfo;
  }

  @override
  void initState() {
    super.initState();
    //getInfo();
    controller = TextEditingController();
    classInfo = [];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  deleteClass(String classroom_id)async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'deleteClass.php', {"classid":classroom_id});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'deleteClass.php', {"classid":classroom_id});
    var response = await http.get(url);
  }

  changeName(String id, String name)async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'updateClassName.php', {"classid":id, "newName":name});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'updateClassName.php', {"classid":id, "newName":name});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.className;
    getInfo(name);
    // if (classInfo.isEmpty) {
    //   id = '';
    //   count = '0';
    // }
    // } else {
    //   id = classInfo[0]["classroom_id"];
    //   count = classInfo[0]["count"];
    //   //print(id);
    // }
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
            "           Number of Children in room: ",
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: ListTile(
              //minVerticalPadding: 10,
              title: Text("   " + classInfo[0]["count"]),
              contentPadding: EdgeInsets.all(5.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          SizedBox(height: 60),
          Align(
            child: MaterialButton(
              height: 50,
              //When pressed it brings you to home screen nav page
              onPressed: () async {
                final nName = await newName();
                if (nName == null || nName.isEmpty) return;
                //deleteChild(classInfo[0]["classroom_id"]);
                changeName(classInfo[0]["classroom_id"], nName);
                setState(() => this.nName = nName);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesPage()));
              },
              color: Colors.blue,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text("Edit Name",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Align(
            child: MaterialButton(
              height: 50,
              //When pressed it brings you to home screen nav page
              onPressed: () {
                deleteClass(classInfo[0]["classroom_id"]);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesPage()));
              },
              color: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text("Remove Class",
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
  Future<String?> newName() => showDialog<String>(
    context:context,
    builder: (context) => AlertDialog(
      title: Text("Change classroom name"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: "Write a new name"),
        controller: controller,
      ),
      actions: [
        TextButton(
          child: Text("SUBMIT"),
          onPressed: submit,
        ),
      ],
    ),
  );

  void submit() {
    Navigator.of(context).pop(controller.text);

    controller.clear();
  }
}