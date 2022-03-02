import 'package:flutter/material.dart';
import 'package:tot_tracker/attendance.dart';

class CheckInCard extends StatelessWidget {
  final String name;
  const CheckInCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Yes'),
                      child: const Text('Yes'),
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
                      height: MediaQuery.of(context).size.height / 14,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/teacher.png")
                          )
                      ),
                    ),
                    Text(name, style: TextStyle(color: Colors.black, height: 4.0, fontSize: 15)),
                  ],
                ),
              )
          )
      ),
    );
  }
}