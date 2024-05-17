// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'volleymatic_model.dart';

class AddTeams extends StatefulWidget {
  const AddTeams(
      {super.key, required this.tournamentList, required this.model});

  final dynamic
      tournamentList; // gets the tournament information from the add tournament
  final VolleymaticModel model;

  @override
  State<AddTeams> createState() => _AddTeamsState();
}

class _AddTeamsState extends State<AddTeams> {
  final File? _image = null; // variable to store the selected image
  TextEditingController name = TextEditingController();
  TextEditingController rank = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: SizedBox(
                width: 70, height: 70, child: Image.asset('assets/logo.png')),
            centerTitle: true,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context); // goes back to the upcoming tournaments screen when clicked
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red)),
                child: Text('Done',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              )
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // adds padding to all sides
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'ENTER TEAM INFORMATION',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                      height:
                          20), // adds space between team information and text fields
                  Row(children: [
                    Text('Team Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Spacer(),
                    Text('Rank',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ]),
                  SizedBox(height: 20),
                  _teamsList(), // displays the list of teams with a given tournament id
                  SizedBox(height: 40),
                  TextField(
                      controller: name,
                      decoration: InputDecoration(labelText: 'Team Name')),
                  TextField(
                      controller: rank,
                      decoration: InputDecoration(labelText: 'Rank'),
                      keyboardType: TextInputType.number),
                  SizedBox(
                      height:
                          20), // adds space between textfields and roster upload
                  Row(children: [
                    Text('Roster (optional)', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    ElevatedButton(onPressed: null, child: Icon(Icons.upload))
                  ]),
                  SizedBox(
                      height:
                          30), // adds space between roster upload and button
                  SizedBox(
                      child: OutlinedButton(
                          // creates an outlined button for add teams
                          onPressed: _addTeam,
                          style: ButtonStyle(
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                  color: Colors.red), // set border color to red
                            ),
                          ),
                          child: Text(
                            'Add Team',
                            style: TextStyle(
                                color: Colors.red, fontSize: 25), // sets text
                          ))),
                ]),
          ),
        ));
  }

  void _addTeam() async {
    await widget.model.addTeam(widget.tournamentList[0], name.text,
        int.parse(rank.text), _image!.path);
    setState(
        () {}); // trigger rebuild to update team list after adding the team
  }

  FutureBuilder _teamsList() {
    return FutureBuilder(
        future: widget.model.fetchTeamsFromTournament(widget.tournamentList[
            0]), // gets the teams using the tournament information
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // show a loading indicator while fetching data
          }
          final teams = snapshot.data!;
          return Expanded(
              child: Column(
            children: [
              ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return ListTile(
                    title: Text(team['name']), // displays the team name
                    trailing: Text(team['rank']), // displays the team rank
                  );
                },
              ),
            ],
          ));
        });
  }
}
