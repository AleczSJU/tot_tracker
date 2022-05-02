import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/dashboard.dart';

List names = [];
List signedIn = [];
List signedOut = [];
int i = 0;
int j = 0;

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  getSignedIn()async {
    //Local usage
    var url = Uri.http('10.0.0.144', 'getSignedInChildren.php');
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getSignedInChildren.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        signedIn = json.decode(response.body);
      });
    }
    print(signedIn);
    print(signedIn.length);
    return signedIn;
  }

  getSignedOut()async {
    //Local usage
    var url = Uri.http('10.0.0.144', 'getSignedOutChildren.php');
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getSignedOutChildren.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        signedOut = json.decode(response.body);
      });
    }
    print(signedOut);
    print(signedOut.length);
    return signedOut;
  }

  @override
  void initState() {
    super.initState();
    //getChildNames();
    getSignedIn();
    getSignedOut();
    //print(names);
    signedIn = [];
    signedOut = [];
  }

  _signInChild(String childName)async{
    //Local usage
    var url = Uri.http('10.0.0.144', 'signIn.php', {"childName":childName});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'signIn.php', {"childName":childName});
    var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   setState(() {
    //     signedOut = json.decode(response.body);
    //   });
    // }
    // print(signedOut);
    // print(signedOut.length);
    // return signedOut;
  }

  _signOutChild(String childName)async{
    //Local usage
    var url = Uri.http('10.0.0.144', 'signOut.php', {"childName":childName});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'signOut.php', {"childName":childName});
    var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   setState(() {
    //     signedOut = json.decode(response.body);
    //   });
    // }
    // print(signedOut);
    // print(signedOut.length);
    // return signedOut;
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
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage())),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: TabBar(
                tabs: [
                  Tab(text: "Signed-out"),
                  Tab(text: "Signed-in"),
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
                  itemCount: signedOut.length,
                  itemBuilder: (BuildContext context, index) {
                    i = index;
                    String signin = 'Would you like to sign-in ' + signedOut[i]['name'] + '?';
                    //int id = signedOut[i]['child_id'] as int;
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
                                  title: const Text('Sign-in'),
                                  content: Text(signin),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                    ),
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        _signInChild(signedOut[index]['name']);
                                        //Navigator.pop(context, 'Yes');
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage()));
                                          //_signInChild(id);
                                      }
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
                                    Text(signedOut[i]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
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
                  itemCount: signedIn.length,
                  itemBuilder: (BuildContext context, index) {
                    j = index;
                    String signout = 'Would you like to sign-out ' + signedIn[j]['name'] + '?';
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
                                  title: const Text('Sign-in'),
                                  content: Text(signout),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                    ),
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        _signOutChild(signedIn[index]['name']);
                                        //Navigator.pop(context, 'Yes');
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage()));
                                        },
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
                                    Text(signedIn[j]['name'], style: TextStyle(color: Colors.black, height: 4.0, fontSize: 12)),
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