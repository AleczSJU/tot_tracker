import 'package:flutter/material.dart';
import 'package:tot_tracker/attendance.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      //Size of card
      aspectRatio: 2,
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
    final String name = "Alec Zubyk";
    final String dob = "January 26, 2000";
    final String age = "22";
    final String classroom = "Starfish";

    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(name, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            ),
            SizedBox(height: 10.0),
            Text("Classroom: " + classroom, style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            ),
            Text("Age: " + age, style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            ),
            Text("DOB: " + dob, style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 15,
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
      flex: 2,
      //Image user posts
      //For now it is just a random downloaded image
      //child: Image.asset(DemoValues.userImage),
      child: Icon(Icons.people),
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
        _UserNumberAndEmail(),
        _CheckInButton(),
      ],
    );
  }
}

class _UserNumberAndEmail extends StatelessWidget {
  const _UserNumberAndEmail({Key? key}) : super(key: key);

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
            Text("222-111-2222"),
            Text("azubyk@gmail.com"),
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
//         child: Icon(Icons.people),
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
        child: Text('Check-in', style: TextStyle(fontSize: 20.0)),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
        onPressed: () {},
      ),
    );
  }
}

