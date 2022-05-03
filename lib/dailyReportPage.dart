import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/showReport.dart';
import 'package:tot_tracker/dailyReport.dart';


class ClassroomDailyReportPage extends StatefulWidget {
  const ClassroomDailyReportPage({Key? key, required this.className}) : super(key: key);
  final String className;

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<ClassroomDailyReportPage> {
  String name = '';
  List children = [];
  int i = 0;
  String cName = '';

  getChildrenInRoom()async{
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getChildrenInRoom.php', {"className":name});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getChildrenInRoom.php', {"className":name});
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

  @override
  void initState() {
    super.initState();
    children = [];
  }


  @override
  Widget build(BuildContext context) {
    name = widget.className;
    getChildrenInRoom();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DailyReportPage()));
          },
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowChildReportPage(childName: children[index]['name'], className: name)));
                  },
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
                          Text(children[index]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
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