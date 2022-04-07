import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/showReport.dart';

List children = [];
int i = 0;
String cName = '';

class ClassroomDailyReportPage extends StatefulWidget {
  const ClassroomDailyReportPage({Key? key, required this.className}) : super(key: key);
  final String className;

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<ClassroomDailyReportPage> {
  String name = '';

  getChildrenInRoom()async{
    //Local usage
    var url = Uri.http('10.0.0.144', 'getChildrenInRoom.php', {"className":name});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getClassrooms.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        children = json.decode(response.body);
      });
      // print(children);
      // print(children.length);
      return children;
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getChildrenInRoom();
  //   //print(names);
  // }

  @override
  Widget build(BuildContext context) {
    name = widget.className;
    getChildrenInRoom();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(name),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 170,
            childAspectRatio: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 1
        ),
        itemCount: children.length,
        itemBuilder: (BuildContext context, index) {
          i = index;
          return Container(
            alignment: Alignment.center,
            //child: _sendDataToCheckIn(names[index]),
            child: Card(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowChildReportPage(child_id: children[i]['child_id'])));
                  },
                  //   onTap: () => showDialog<String>(
                  //     context: context,
                  //     builder: (BuildContext context) => AlertDialog(
                  //       title: const Text('Check-in'),
                  //       content: Text(signin),
                  //       actions: <Widget>[
                  //         TextButton(
                  //           child: const Text('Cancel'),
                  //           onPressed: () => Navigator.pop(context, 'Cancel'),
                  //         ),
                  //         TextButton(
                  //           child: const Text('Yes'),
                  //           onPressed: () => Navigator.pop(context, 'Yes'),
                  //         ),
                  //       ],
                  //     ),
                  //     //setState(() {});
                  //   ),
                    splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                    child: Center(
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
                          Text(children[i]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
                        ],
                      ),
                    )
                )
            ),
          );
        },
      ),
    );
  }
}