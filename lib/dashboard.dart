import 'package:flutter/material.dart';
import 'package:tot_tracker/main.dart';
import 'package:tot_tracker/attendance.dart';
import 'package:tot_tracker/dailyReport.dart';
import 'package:tot_tracker/staff.dart';
import 'package:tot_tracker/classrooms.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: const [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage()));
                  },
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Icon(Icons.people, size:50.0, color:Colors.black)),
                        Text("Attendance", style: TextStyle(color: Colors.black, height: 4.0, fontSize: 20)),
                      ],
                    ),
                  )
              )
          ),
          Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StaffPage()));
                  },
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Icon(Icons.contacts, size:50.0, color:Colors.black)),
                        Text("Staff", style: TextStyle(color: Colors.black, height: 4.0, fontSize: 20)),
                      ],
                    ),
                  )
              )
          ),
          Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DailyReportPage()));
                  },
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Icon(Icons.map, size:50.0, color:Colors.black)),
                        Text("Daily Reports", style: TextStyle(color: Colors.black, height: 4.0, fontSize: 20)),
                      ],
                    ),
                  )
              )
          ),
          Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage()));
                  },
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Icon(Icons.home, size:50.0, color:Colors.black)),
                        Text("Classrooms", style: TextStyle(color: Colors.black, height: 4.0, fontSize: 20)),
                      ],
                    ),
                  )
              )
          ),
        ],
      )
    );
  }
}