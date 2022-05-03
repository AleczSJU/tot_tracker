import 'package:flutter/material.dart';
import 'package:tot_tracker/dailyReportPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/dashboard.dart';

List roomNames = [];
int i = 0;

class DailyReportPage extends StatefulWidget {
  const DailyReportPage({Key? key}) : super(key: key);

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
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
      print(roomNames);
      //numTabs = tabNames.length;
      return roomNames;
    }
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
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
          },
        ),
        title: const Text('Classrooms'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 1
        ),
        itemCount: roomNames.length,
        itemBuilder: (BuildContext context, index) {
          i = index;
          return Container(
            alignment: Alignment.center,
            child: Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomDailyReportPage(className: roomNames[index]['name'])));
                  },
                  splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Icon(Icons.home, size:50.0, color:Colors.black)),
                        Text(roomNames[i]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}