import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tot_tracker/roomPage.dart';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/dashboard.dart';

List roomNames = [];
int i = 0;

class ClassroomsPage extends StatefulWidget {
  const ClassroomsPage({Key? key}) : super(key: key);

  @override
  _ClassroomsPageState createState() => _ClassroomsPageState();
}

class _ClassroomsPageState extends State<ClassroomsPage> {

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

  // getTabs(){
  //   for (var i = 0; i < tabNames.length; i++) {
  //     _tabs.add(Tab(child: Text(tabNames[i]['name']),));
  //     _tabViews.add(Scaffold(body: Calendar()));
  //   }
  //   //print(_tabs.length);
  //   return _tabs;
  // }

  // getTabsViews(){
  //   for (var i = 0; i < _tabs.length; i++) {
  //     //_tabs.insert(i, Tab(child: Text(tabNames[i]['name']),));
  //     _tabViews.insert(i, Scaffold(body: Calendar()));
  //   }
  //   print(_tabViews.length);
  //   return _tabViews;
  // }

  @override
  void initState() {
    super.initState();
    getAllClassrooms();
    // _tabController = TabController(vsync: this, length: _tabs.length);
    // print(_tabController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //length: _tabs.length,
      //child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
              },
            ),
            title: const Text('Classrooms'),
            // bottom: PreferredSize(
            //   child: TabBar(
            //     controller: _tabController,
            //     isScrollable: true,
            //     unselectedLabelColor: Colors.white.withOpacity(0.3),
            //     indicatorColor: Colors.white,
            //     tabs: _tabs,
            //   ),
            //     preferredSize: Size.fromHeight(30.0),
            // ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RoomPage(className: roomNames[index]['name'])));
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
          // body: Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text('Classroom:'),
          //       Text(tabNames[0]['name']),
          //     ],
          //   ),
          // ),
          // body: TabBarView(
          //   controller: _tabController,
          //   children: _tabViews,
          // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(Icons.add),
        // ),
      //),
    );
  }
}


// Future<void> getTabs() async {
//   var settings = new ConnectionSettings(
//     host: '68.82.13.214',
//     port: 3306,
//     user: 'alecRemote',
//     password: 'alecZubyk12',
//     db: 'tot_tracker',
//   );
//   var conn = await MySqlConnection.connect(settings);
//   var tabs = await conn.query('select name from classroom;');
//
//   for (var row in tabs) {
//     tabNames.add('${row[0]}');
//     print('${row[0]}');
//     numTabs++;
//   }
//
//   for (var i in tabNames) {
//     _tabs.add(new Tab(child: Text(i),));
//     _tabViews.add(new Scaffold(body: Calendar()));
//   }
// }

// bottom: TabBar(
//     controller: _tabController,
//     isScrollable: true,
//     unselectedLabelColor: Colors.white.withOpacity(0.3),
//     indicatorColor: Colors.white,
//     //tabs: List<Widget>.generate(_tabs.length, (int index)),
//     tabs: _tabs,
//     // tabs: [
//     //   Tab(
//     //     child: Text('Angelfish'),
//     //   ),
//     //   Tab(
//     //     child: Text('Starfish'),
//     //   ),
//     //   Tab(
//     //     child: Text('Seahorses'),
//     //   ),
//     //   Tab(
//     //     child: Text('Narwhals'),
//     //   ),
//     //   Tab(
//     //     child: Text('Sharks'),
//     //   ),
//     //   Tab(
//     //     child: Text('Sea Otters'),
//     //   ),
//     //   Tab(
//     //     child: Text('Sea Turtles'),
//     //   ),
//     //   Tab(
//     //     child: Text('Sea Dragons'),
//     //   )
//     // ]
// ),

// body: TabBarView(
//   controller: _tabController,
//   children: _tabViews,
//   // children: <Widget>[
//   //   Scaffold(
//   //     body: Calendar(),
//   //   ),
//   //   Scaffold(
//   //     body: Calendar(),
//   //   ),
//   //   Scaffold(
//   //     body: Calendar(),
//   //   ),
//   //   Scaffold(
//   //     body: Calendar(),
//   //   ),
//   //   Scaffold(
//   //     body: Calendar(),
//   //   ),
//   //   Scaffold(
//   //     body: Calendar(),
//   //   ),
//   //   Scaffold(
//   //     body: Calendar(),
//   //   ),
//   //   Scaffold(
//   //     body: Calendar(),
//   //   ),
//   // ],
// )