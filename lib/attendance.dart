import 'package:flutter/material.dart';
import 'package:tot_tracker/checkin.dart';
import 'package:tot_tracker/checkout.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List names = [];
int i = 0;

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  getChildNames()async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getChildNames.php');
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getChildNames.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        names = json.decode(response.body);
      });
      print(names);
      print(names.length);
      return names;
    }
  }

  @override
  void initState() {
    super.initState();
    getChildNames();
    //print(names);
  }

  @override
  Widget build(BuildContext context) {
    final namesIn = ['Alec Zubyk', 'Michelle Zubyk', 'Andrew Zubyk', 'Jack Zubyk', 'John Zubyk'];
    final namesOut = ['Test man', 'Test woman', 'Signed out', 'Nicholas Alephranso'];
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: TabBar(
                tabs: [
                  Tab(text: "Check-in"),
                  Tab(text: "Check-out"),
                ],
              ),
            ),
            title: const Text('Attendance'),
          ),
          body: TabBarView(
            children: <Widget>[
              Scaffold(
                body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 170,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 1
                  ),
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, index) {
                    i = index;
                    String signin = 'Would you like to sign-in ' + names[i]['name'] + '?';
                    return Container(
                      alignment: Alignment.center,
                      //child: _sendDataToCheckIn(names[index]),
                      child: Card(
                          color: Colors.white,
                          child: InkWell(
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage()));
                            // },
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Check-in'),
                                  content: Text(signin),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                    ),
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () => Navigator.pop(context, 'Yes'),
                                    ),
                                  ],
                                ),
                                //setState(() {});
                              ),
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
                                    Text(names[i]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
                                  ],
                                ),
                              )
                          )
                      ),
                    );
                  },
                ),
              ),
              Scaffold(
                body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 1
                  ),
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, index) {
                    i = index;
                    String signout = 'Would you like to sign-out ' + names[i]['name'] + '?';
                    return Container(
                      alignment: Alignment.center,
                      //child: _sendDataToCheckIn(names[index]),
                      child: Card(
                          color: Colors.white,
                          child: InkWell(
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage()));
                            // },
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Check-in'),
                                  content: Text(signout),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                    ),
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () => Navigator.pop(context, 'Yes'),
                                    ),
                                  ],
                                ),
                              ),
                              splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: MediaQuery.of(context).size.height / 12,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage("assets/teacher.png"),
                                            fit: BoxFit.cover,
                                          )
                                      ),
                                    ),
                                    Text(names[i]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
                                  ],
                                ),
                              )
                          )
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
        ),
    );
  }
}