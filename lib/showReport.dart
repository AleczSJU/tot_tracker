import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/dailyReportPage.dart';
import 'package:tot_tracker/addReport.dart';



class ShowChildReportPage extends StatefulWidget {
  const ShowChildReportPage({Key? key, required this.childName, required this.className}) : super(key: key);
  final String childName;
  final String className;

  @override
  _ChildDailyReportPageState createState() => _ChildDailyReportPageState();
}

class _ChildDailyReportPageState extends State<ShowChildReportPage> {
  String name = '';
  String cName = '';
  String report = '';
  List reports = [];
  int i = 0;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    reports = [];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  getReports()async{
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getReport.php', {"childName":name});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getReport.php', {"childName":name});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        reports = json.decode(response.body);
      });
      //print(reports);
      //print(reports.length);
      return reports;
    }
  }

  deleteReport(String report_id)async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'deleteReport.php', {"reportid":report_id});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'deleteReport.php', {"reportid":report_id});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.childName;
    cName = widget.className;
    getReports();
    //print(report);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassroomDailyReportPage(className: cName)));
          },
        ),
        title: Text(name),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: reports.length,
            itemBuilder: (BuildContext context, int index){
              i = index;
              return Card(
                elevation: 6,
                margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: ListTile(
                  //minVerticalPadding: 10,
                  title: Text(reports[index]['report']),
                  trailing: Text(reports[index]['date']),
                  contentPadding: EdgeInsets.all(20.0),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Sign-in'),
                        content: const Text('Would you like to delete the report?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              deleteReport(reports[index]['report_id']);
                              //Navigator.pop(context, 'Yes');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowChildReportPage(childName: name, className: cName)));
                            },
                          ),
                        ],
                      ),
                    ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ),
              );
            }
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReportPage(childName: name, className: cName)));
        },
      ),
    );
  }
}