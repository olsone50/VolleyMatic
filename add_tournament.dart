// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'add_teams.dart';

class AddTournament extends StatelessWidget {
  AddTournament({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController numCourtsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(width: 70, height: 70, 
                child: Image.asset('assets/logo.png')), // adds logo to the top bar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // adds padding to all sides
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, // stretches the items to fill the screen
          children: [Text('ENTER TOURNAMENT INFORMATION',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            SizedBox(height: 30), // adds space between title and text field
            textFields(), // adds text fields
            SizedBox(height: 30), // adds space between textfields and button
            SizedBox(child: OutlinedButton( // creates an outlined button for add tournaments
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddTeams())); // goes to add teams on pressed
                    },
                    style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(color: Colors.red), // set border color to red
                      ),
                    ),
                    child: Text('Add Tournament',style: TextStyle(color: Colors.red, fontSize: 25),
                    ))),
          ]),
      ),
    );
  }

  Column textFields() {
    return Column( children: [TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Tournament Name')),
            TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location')),
            TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime),
            TextField(
                controller: numCourtsController,
                decoration: InputDecoration(labelText: 'Number of Courts'),
                keyboardType: TextInputType.number)
      ]);
  }
}
