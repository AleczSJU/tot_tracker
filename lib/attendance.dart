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
              Container(
                child: ListView.builder(
                 //How many posts show up on home page
                  itemCount: 10,
                  //Calls the function to build the card for each post
                  itemBuilder: (BuildContext context, int index){
                     return CheckInCard();
                   },
                 )
              ),
              Container(
                  child: ListView.builder(
                    //How many posts show up on home page
                    itemCount: 10,
                    //Calls the function to build the card for each post
                    itemBuilder: (BuildContext context, int index){
                      return CheckOutCard();
                    },
                  )
              ),
            ],
          ),
        )
        ),
    );
  }
}