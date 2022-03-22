import 'package:flutter/material.dart';
import 'package:tot_tracker/checkout.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List teachers = [];
int i = 0;

class StaffPage extends StatefulWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  getTeachers()async {
    //Local usage
    //var url = Uri.http('10.0.0.144', 'getAllTeachers.php');
    //Non-local usage
    var url = Uri.http('68.82.13.214', 'getAllTeachers.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        teachers = json.decode(response.body);
      });
      print(teachers);
      print(teachers.length);
      return teachers;
    }
  }

  @override
  void initState() {
    super.initState();
    getTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff'),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          child: ListView.builder(
            //How many posts show up on home page
            itemCount: teachers.length,
            //Calls the function to build the card for each post
            itemBuilder: (BuildContext context, int index){
              i = index;
              return AspectRatio(
                //Size of card
                aspectRatio: 2.5,
                child: Card(
                  elevation: 2,
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: <Widget>[
                        //Shows the post of the user with info
                        _Card(),
                        Divider(color: Colors.grey),
                        //Shows users profile image and contact info at bottom
                        _CardDetails(),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: <Widget>[
          //All info of user
          _CardNameAndInfo(),
          //Image user posts
          _CardImage(),
        ],
      ),
    );
  }
}

class _CardNameAndInfo extends StatelessWidget {
  const _CardNameAndInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = "Alec";
    final String age = "20";
    final String classroom = "Sharks";

    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(teachers[i]['name'], style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            ),
            SizedBox(height: 10.0),
            Text("Classroom: " + teachers[i]['classroom'], style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            ),
            Text("Age: " + teachers[i]['age'], style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      //flex: 0,
      //Image user posts
      //For now it is just a random downloaded image
      //child: Image.asset(DemoValues.userImage),
      //child: Icon(Icons.people),
      //child: Icon(Icons.people),
      child: CircleAvatar(
        radius: 50,
         //Profile image for the user
         backgroundImage: AssetImage("assets/teacher.png"),
      ),
    );
  }
}

class _CardDetails extends StatelessWidget {
  const _CardDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        //Displays user profile image and contact info at bottom
        //_UserImage(),
        _CardNumberAndEmail(),
        _CheckInButton(),
      ],
    );
  }
}

class _CardNumberAndEmail extends StatelessWidget {
  const _CardNumberAndEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Gets the values from the DemoValues file for now
            Text(teachers[i]['phone_number'], style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            ),
            Text(teachers[i]['email'], style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _UserImage extends StatelessWidget {
//   const _UserImage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 1,
//       child: Icon(Icons.people),
//       // child: CircleAvatar(
//       //   //Profile image for the user
//       //   backgroundImage: AssetImage(DemoValues.userImage),
//       // ),
//     );
//   }
// }

class _CheckInButton extends StatelessWidget {
  const _CheckInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text('Check-in', style: TextStyle(fontSize: 15.0)),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
        onPressed: () {},
      ),
    );
  }
}