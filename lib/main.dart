import 'package:flutter/material.dart';
import 'package:tot_tracker/login.dart';
import 'package:tot_tracker/signup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomePage(),
  ));
}

class WelcomePage extends StatelessWidget {
   const WelcomePage({Key? key}) : super(key: key);

   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                //Widget used to display text at top
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Tot Tracker",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              //Container is used to display the image on screen
              Container(
                height: MediaQuery.of(context).size.height /3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/students.png")
                  )
                ),
              ),
              //Column is used to add the buttons to screen
              Column(
                children: <Widget>[
                  //Login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    //When pressed it brings you to login page
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //Sign up button
                  // MaterialButton(
                  //   minWidth: double.infinity,
                  //   height: 60,
                  //   //When pressed it brings you to the sign up page
                  //   onPressed: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  //   },
                  //   color: Color(0xff0095FF),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(50)
                  //   ),
                  //   child: Text(
                  //     "Sign Up",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 18
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
