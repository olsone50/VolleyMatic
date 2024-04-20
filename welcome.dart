// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'main_app.dart';
import 'login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _threeBarDesign(),
        SizedBox(width: 70, height: 70, child: Image.asset('assets/logo.png')),
        Text('WELCOME!'),
        ElevatedButton(
            // creates an elevated button for login
            onPressed: () {Login();}, // goes to login on pressed
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),
            child: Text('LOGIN',
              style: TextStyle(
                  color: Colors.white, fontSize: 25), // sets login text
            )),
        SizedBox(height: 20),
        OutlinedButton(
            // creates an outlined button for use as guest
            onPressed: () {
              MainApp();
            }, // runs main app when pressed
            style: ButtonStyle(
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    BorderSide(color: Colors.red), // set border color to red
              ),
            ),
            child: Text(
              'Continue as Guest',
              style: TextStyle(color: Colors.red, fontSize: 20),
            )),
      ],
    );
  }

  Row _threeBarDesign(){
    return Row(
      children: [
        Container(
          height: 100.0,
          width: 2.0,
          color: Color.fromARGB(255, 118, 6, 6),
        ),
        Container(
          height: 80.0,
          width: 2.0,
          color: Color.fromARGB(255, 165, 8, 8),
        ),
        Container(
          height: 60.0,
          width: 2.0,
          color: Color.fromARGB(255, 236, 8, 8),
        ),
      ],
    );
  }
}
