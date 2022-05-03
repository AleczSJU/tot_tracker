import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tot_tracker/classrooms.dart';
import 'package:tot_tracker/addPlan.dart';

List plans = [];
//int i = 0;
//List currentPlans = [];

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key, required this.className}) : super (key: key);
  final String className;

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  String name = '';
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String cDay= '';
  String nDay = '';
  String plan = '';
  String planDate = '';
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    plans = [];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  getPlansForDay(String currentDay, String nextDay)async{
    plans = [];
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getPlansForDay.php', {"currentDay":currentDay, "nextDay":nextDay, "className":name});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getPlansForDay.php', {"currentDay":currentDay, "nextDay":nextDay, "className":name});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        plans = json.decode(response.body);
      });
      print(plans);
      print(plans.length);
      return plans;
    }
  }

  makePlan(String newPlan)async{
    //Local usage
    //var url = Uri.http('10.0.0.144', 'makePlan.php', {"plan":newPlan, "className":name, "date":cDay});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'makePlan.php', {"plan":newPlan, "className":name, "date":cDay});
    var response = await http.get(url);
  }

  deletePlan(String lessonplan_id)async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'deletePlan.php', {"planid":lessonplan_id});
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'deletePlan.php', {"planid":lessonplan_id});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.className;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage()));
          },
        ),
        title: Text(name),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  final tomorrow = _focusedDay.add(new Duration(hours: 24));
                  cDay = DateFormat('yyyy-MM-dd HH:mm:ss').format(_focusedDay);
                  nDay = DateFormat('yyyy-MM-dd HH:mm:ss').format(tomorrow);
                  print(cDay);
                  print(nDay);
                  getPlansForDay(cDay, nDay);
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: plans.length,
                itemBuilder: (BuildContext context, int index){
                  //i = index;
                  return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: ListTile(
                      //minVerticalPadding: 10,
                      title: Text(plans[index]['plan']),
                      //trailing: Text(plans[index]['date']),
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
                                deletePlan(plans[index]['lessonplan_id']);
                                //Navigator.pop(context, 'Yes');
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RoomPage(className: name)));
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
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final date = _focusedDay.add(new Duration(hours: 1));
          planDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPlanPage(className: name, planDate: planDate)));
          // final plan = await newPlan();
          // if (plan == null || plan.isEmpty) return;
          //
          // makePlan(plan);
          // setState(() => this.plan = plan);
        },
      ),
    );
  }
  Future<String?> newPlan() => showDialog<String>(
    context:context,
    builder: (context) => AlertDialog(
      title: Text("Make a Lesson Plan"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: "Write a Lesson Plan"),
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
