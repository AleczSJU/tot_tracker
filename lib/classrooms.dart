import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tot_tracker/calendar.dart';
import 'package:mysql1/mysql1.dart';

class ClassroomsPage extends StatefulWidget {
  const ClassroomsPage({Key? key}) : super(key: key);

  @override
  _ClassroomsPageState createState() => _ClassroomsPageState();
}

class _ClassroomsPageState extends State<ClassroomsPage> with TickerProviderStateMixin {
  List<Tab> _tabs = [];
  List<Widget> _tabViews = [];
  List<String> tabNames = [];
  var numTabs = 0;
  late TabController _tabController;

  Future<void> getTabs() async {
    var settings = new ConnectionSettings(
      host: '68.82.13.214',
      port: 3306,
      user: 'alecRemote',
      password: 'alecZubyk12',
      db: 'tot_tracker',
    );
    var conn = await MySqlConnection.connect(settings);
    var tabs = await conn.query('select name from classroom;');

    for (var row in tabs) {
      tabNames.add('${row[0]}');
      print('${row[0]}');
      numTabs++;
    }

    for (var i in tabNames) {
      _tabs.add(new Tab(child: Text(i),));
      _tabViews.add(new Scaffold(body: Calendar()));
    }
  }

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //length: numTabs,
      //child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Classrooms'),
            bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.white,
                //tabs: List<Widget>.generate(_tabs.length, (int index)),
                tabs: _tabs,
                // tabs: [
                //   Tab(
                //     child: Text('Angelfish'),
                //   ),
                //   Tab(
                //     child: Text('Starfish'),
                //   ),
                //   Tab(
                //     child: Text('Seahorses'),
                //   ),
                //   Tab(
                //     child: Text('Narwhals'),
                //   ),
                //   Tab(
                //     child: Text('Sharks'),
                //   ),
                //   Tab(
                //     child: Text('Sea Otters'),
                //   ),
                //   Tab(
                //     child: Text('Sea Turtles'),
                //   ),
                //   Tab(
                //     child: Text('Sea Dragons'),
                //   )
                // ]
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: _tabViews,
            // children: <Widget>[
            //   Scaffold(
            //     body: Calendar(),
            //   ),
            //   Scaffold(
            //     body: Calendar(),
            //   ),
            //   Scaffold(
            //     body: Calendar(),
            //   ),
            //   Scaffold(
            //     body: Calendar(),
            //   ),
            //   Scaffold(
            //     body: Calendar(),
            //   ),
            //   Scaffold(
            //     body: Calendar(),
            //   ),
            //   Scaffold(
            //     body: Calendar(),
            //   ),
            //   Scaffold(
            //     body: Calendar(),
            //   ),
            // ],
          )
      //),
    );
  }
}