import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List reports = [];
int i = 0;

class ShowChildReportPage extends StatefulWidget {
  const ShowChildReportPage({Key? key, required this.childName}) : super(key: key);
  final String childName;

  @override
  _ChildDailyReportPageState createState() => _ChildDailyReportPageState();
}

class _ChildDailyReportPageState extends State<ShowChildReportPage> {
  String name = '';
  String cName = '';
  String report = '';
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
    var url = Uri.http('10.0.0.144', 'getReport.php', {"childName":name});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getReport.php', {"childName":name});
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

  makeReport(String newReport)async{
    //Local usage
    var url = Uri.http('10.0.0.144', 'makeReport.php', {"report":newReport, "childName":name});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getReport.php', {"childName":name});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.childName;
    getReports();
    //print(report);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(name),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: reports.length,
            itemBuilder: (BuildContext context, int index){
              i = index;
              //String date = DateFormat('yyyy-MM-dd – kk:mm').format(reports[index]['date']);
              return Card(
                elevation: 6,
                margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: ListTile(
                  //minVerticalPadding: 10,
                  title: Text(reports[index]['report']),
                  trailing: Text(reports[index]['date']),
                  contentPadding: EdgeInsets.all(20.0),
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
          final report = await newReport();
          if (report == null || report.isEmpty) return;

          makeReport(report);
          setState(() => this.report = report);
        },
      ),
    );
  }
  Future<String?> newReport() => showDialog<String>(
    context:context,
    builder: (context) => AlertDialog(
      title: Text("Make a Report"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: "Write a report"),
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