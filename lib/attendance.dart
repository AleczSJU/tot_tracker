import 'package:flutter/material.dart';
import 'package:tot_tracker/checkin.dart';
import 'package:tot_tracker/checkout.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    final names = ['Alec Zubyk', 'Michelle Zubyk', 'Andrew Zubyk', 'Jack Zubyk', 'John Zubyk'];
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
                                  content: const Text('Would you like to check-in user'),
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
                                    Text(names[index], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
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
                  itemCount: namesOut.length,
                  itemBuilder: (BuildContext context, index) {
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
                                  content: const Text('Would you like to check-out user'),
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
                                    Text(namesOut[index], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
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