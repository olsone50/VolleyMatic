// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'volleymatic_model.dart';
import 'package:flutter/material.dart';
import 'add_teams.dart';

class AddTournament extends StatelessWidget {
  AddTournament({super.key, required this.model});

  final VolleymaticModel model; // gets model for the database

  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController numCourt = TextEditingController();

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
                      model.addTournament(name.text, location.text, date.text, int.parse(numCourt.text)); // adds tournament to the model
                      final tournament = [name.text, date.text, location.text]; // makes a list of the tournament information
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddTeams(tournamentList: tournament, model: model))); // goes to add teams on pressed
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

  /// returns a {Column} of textfields for the add tournament function including tournament name, location,
  /// date, and number of courts
  Column textFields() {
    return Column( children: [TextField( // textfield for tournament name
                controller: name,
                decoration: InputDecoration(labelText: 'Tournament Name')),
            TextField( // textfields for location
                controller: location, 
                decoration: InputDecoration(labelText: 'Location')),
            TextField(// textfield for date
                controller: date,
                decoration: InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime),
            TextField( // textfield for number of courts
                controller: numCourt,
                decoration: InputDecoration(labelText: 'Number of Courts'),
                keyboardType: TextInputType.number)
      ]);
  }
}
