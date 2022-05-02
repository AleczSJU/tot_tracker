import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/children.dart';

// List childInfo = [];
// int i = 0;

class ChildCardPage extends StatefulWidget {
  const ChildCardPage({Key? key, required this.childName}) : super(key: key);
  final String childName;

  @override
  _ChildCardPageState createState() => _ChildCardPageState();
}

class _ChildCardPageState extends State<ChildCardPage> {
  String name = "";
  List childInfo = [];
  int i = 0;

  getInfo(String name)async {
    //Local usage
    var url = Uri.http('10.0.0.144', 'getInfoForChild.php', {"name":name});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getChildNames.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        childInfo = json.decode(response.body);
      });
    }
    //print(childInfo);
    //print(childInfo.length);
    return childInfo;
  }

  @override
  void initState() {
    super.initState();
    //getInfo();
    childInfo = [];
  }

  deleteChild(String child_id)async {
    //Local usage
    var url = Uri.http('10.0.0.144', 'deleteChild.php', {"childid":child_id});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'deleteChild.php', {"childid":child_id});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.childName;
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
              title: Text("   " + childInfo[0]["name"]),
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
              title: Text("   " + childInfo[0]["age"]),
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
              title: Text("   " + childInfo[0]["gender"]),
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
              title: Text("   " + childInfo[0]["className"]),
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
                deleteChild(childInfo[0]["child_id"]);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChildrenPage()));
              },
              color: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text("Remove Child",
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