import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tot_tracker/dashboard.dart';

List teachers = [];
List signedIn = [];
List signedOut = [];
int i = 0;
int j = 0;

class StaffPage extends StatefulWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  // getTeachers()async {
  //   //Local usage
  //   //var url = Uri.http('10.0.0.144', 'getAllTeachers.php');
  //   //Non-local usage
  //   var url = Uri.http('68.82.13.214', 'getAllTeachers.php');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       teachers = json.decode(response.body);
  //     });
  //     print(teachers);
  //     print(teachers.length);
  //     return teachers;
  //   }
  // }

  getSignedIn()async {
    //Local usage
    var url = Uri.http('10.0.0.144', 'getTeachersSignedIn.php');
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getTeachersSignedIn.php');
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
    var url = Uri.http('10.0.0.144', 'getTeachersSignedOut.php');
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'getTeachersSignedOut.php');
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
    teachers = [];
    signedIn = [];
    signedOut = [];
  }

  _signInTeacher(String teacherName)async{
    //Local usage
    var url = Uri.http('10.0.0.144', 'teacherSignIn.php', {"teacherName":teacherName});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'teacherSignIn.php', {"teacherName":teacherName});
    var response = await http.get(url);
  }

  _signOutTeacher(String teacherName)async{
    //Local usage
    var url = Uri.http('10.0.0.144', 'teacherSignOut.php', {"teacherName":teacherName});
    //Non-local usage
    //var url = Uri.http('68.82.13.214', 'teacherSignOut.php', {"teacherName":teacherName});
    var response = await http.get(url);
  }

  @override
  Widget build(BuildContext context) {
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
                                            _signInTeacher(signedOut[index]['name']);
                                            //Navigator.pop(context, 'Yes');
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => StaffPage()));
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
                                          _signOutTeacher(signedIn[index]['name']);
                                          //Navigator.pop(context, 'Yes');
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => StaffPage()));
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

// return Scaffold(
// appBar: AppBar(
// title: const Text('Staff'),
// leading: BackButton(
// color: Colors.white,
// onPressed: () => Navigator.of(context).pop(),
// ),
// ),
// body: Container(
// child: ListView.builder(
// //How many posts show up on home page
// itemCount: teachers.length,
// //Calls the function to build the card for each post
// itemBuilder: (BuildContext context, int index){
// i = index;
// return AspectRatio(
// //Size of card
// aspectRatio: 2.5,
// child: Card(
// elevation: 2,
// child: Container(
// margin: const EdgeInsets.all(4.0),
// padding: const EdgeInsets.all(4.0),
// child: Column(
// children: <Widget>[
// //Shows the post of the user with info
// _Card(),
// Divider(color: Colors.grey),
// //Shows users profile image and contact info at bottom
// _CardDetails(),
// ],
// ),
// ),
// ),
// );
// },
// )
// ),
// );
//
// class _Card extends StatelessWidget {
//   const _Card({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 3,
//       child: Row(
//         children: <Widget>[
//           //All info of user
//           _CardNameAndInfo(),
//           //Image user posts
//           _CardImage(),
//         ],
//       ),
//     );
//   }
// }
//
// class _CardNameAndInfo extends StatelessWidget {
//   const _CardNameAndInfo({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final String name = "Alec";
//     final String age = "20";
//     final String classroom = "Sharks";
//
//     return Expanded(
//       flex: 4,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Text(teachers[i]['name'], style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//             ),
//             SizedBox(height: 10.0),
//             Text("Classroom: " + teachers[i]['classroom'], style: TextStyle(
//               //fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//             ),
//             Text("Age: " + teachers[i]['age'], style: TextStyle(
//               //fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _CardImage extends StatelessWidget {
//   const _CardImage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Expanded(
//       //flex: 0,
//       //Image user posts
//       //For now it is just a random downloaded image
//       //child: Image.asset(DemoValues.userImage),
//       //child: Icon(Icons.people),
//       //child: Icon(Icons.people),
//       child: CircleAvatar(
//         radius: 50,
//          //Profile image for the user
//          backgroundImage: AssetImage("assets/teacher.png"),
//       ),
//     );
//   }
// }
//
// class _CardDetails extends StatelessWidget {
//   const _CardDetails({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         //Displays user profile image and contact info at bottom
//         //_UserImage(),
//         _CardNumberAndEmail(),
//         _CheckInButton(),
//       ],
//     );
//   }
// }
//
// class _CardNumberAndEmail extends StatelessWidget {
//   const _CardNumberAndEmail({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             //Gets the values from the DemoValues file for now
//             Text(teachers[i]['phone_number'], style: TextStyle(
//               //fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//             ),
//             Text(teachers[i]['email'], style: TextStyle(
//               //fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class _UserImage extends StatelessWidget {
// //   const _UserImage({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       flex: 1,
// //       child: Icon(Icons.people),
// //       // child: CircleAvatar(
// //       //   //Profile image for the user
// //       //   backgroundImage: AssetImage(DemoValues.userImage),
// //       // ),
// //     );
// //   }
// // }
//
// class _CheckInButton extends StatelessWidget {
//   const _CheckInButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextButton(
//         child: Text('Check-in', style: TextStyle(fontSize: 15.0)),
//         style: TextButton.styleFrom(
//           primary: Colors.white,
//           backgroundColor: Colors.blue,
//         ),
//         onPressed: () {},
//       ),
//     );
//   }
// }