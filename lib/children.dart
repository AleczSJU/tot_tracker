import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/dashboard.dart';
import 'package:tot_tracker/addChild.dart';
import 'package:tot_tracker/childCard.dart';

List children = [];

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({Key? key}) : super(key: key);

  @override
  _ChildrenPageState createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  getChildren()async {
    //Local usage
    var url = Uri.http('10.0.0.144', 'getChildNames.php');
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getChildNames.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        children = json.decode(response.body);
      });
    }
    //print(children);
    //print(children.length);
    return children;
  }

  @override
  void initState() {
    super.initState();
    children = [];
    getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage())),
        ),
        title: const Text('Children'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            tooltip: 'Add Child',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddChildPage())),
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
        itemCount: children.length,
        itemBuilder: (BuildContext context, index) {
          //i= index;
          return Container(
            child: Card(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChildCardPage(childName: children[index]['name'])));
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
                    Text(children[index]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
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







