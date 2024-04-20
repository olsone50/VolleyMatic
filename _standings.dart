// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'volleymatic_model.dart';

class Standings extends StatefulWidget {
  const Standings({super.key, required this.model});

  final VolleymaticModel model;

  @override
  State<Standings> createState() => StandingsWidget();
}

class StandingsWidget extends State<Standings> {
  late String _selectedName;
  late int _selectedId;
  final Map<String, int> _tournamentNameToId = {}; // creates a map to store the names and ids of tournaments

  @override
  void initState() {
    super.initState();
    _selectedName = ''; // initialize with an empty string
    _selectedId = 1; // initialize with 1

    widget.model.fetchTournaments().then((tournaments) { // fetch tournaments from the database
      if (tournaments.isNotEmpty) {
        tournaments.sort((a, b) => b['date'].compareTo(a['date'])); // sort tournaments by date in descending order

        _selectedName = tournaments.first['name']; // gets the name of the most recent tournament
        _selectedId = tournaments.first['tournament_id']; // gets the tournament_id of the most recent tournament

        setState(() {}); // update the state
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _dropdownTournamentList(), // displays dropdown list
            SizedBox(height: 20),
            Text('STANDINGS', style: TextStyle( // creates a standings title
                fontSize: 30,
                fontWeight: FontWeight.bold)),
            SizedBox(height: 10), // adds space between items
            Container(
              decoration: BoxDecoration(
              color: Colors.red,), // set the container background color to red
              child: TextButton(onPressed: null, child: Row(children: [Text('Team',
                style: const TextStyle( // sets text background color to red 
                fontSize: 24,
                 color: Colors.white,)), Spacer(), Text('  Wins  ', style: const TextStyle( // sets text background color to red 
                fontSize: 24,
                 color: Colors.white,)), Text('  Losses', style: const TextStyle( // sets text background color to red 
                fontSize: 24,
                 color: Colors.white,)), ])),
              ),
            _standingsTable(), // displays the standings table
          ],
      ),
    );
  }

  /// returns a dropdown list of all the tournament names
  Container _dropdownTournamentList() {
  return Container(
    color: Color.fromARGB(255, 102, 11, 4),
    child: FutureBuilder(
      future: widget.model.fetchTournaments(), // get the tournaments from the database
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // show loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // show error message if data fetching fails
        } else {
          List<String> tournamentNames = snapshot.data!.map((tournament) {
            String name = tournament['name'] as String;
            int id = tournament['tournament_id'] as int;
      
            _tournamentNameToId[name] = id; // store values in the map

            return name;
          }).toList();
          return ListView(
            shrinkWrap: true,
            children: [
              DropdownButton<String>(
                value: _selectedName,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedName = newValue!;
                    _selectedId = _tournamentNameToId[newValue]!; // get id from the map
                  });
                },
                style: TextStyle(fontSize: 25, color: Colors.white),
                dropdownColor: Color.fromARGB(255, 102, 11, 4),
                items: tournamentNames.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          );
        }
      },
    ),
  );
}

  /// returns a {Table} with all the team names and their wins and losses
  FutureBuilder _standingsTable() {
    return FutureBuilder(
      future: widget.model.fetchTeamsFromTournament(_selectedId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // show loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // show error message if data fetching fails
        } else {
          List<TableRow> rows = [];
          List<Map<String, dynamic>> teamsData = snapshot.data!;
          
          for (var teamData in teamsData) { // gets the information from the data 
            String teamName = teamData['name'];
            int wins = teamData['set_wins'];
            int losses = teamData['set_losses'];

            rows.add( // adds the name and the wins and losses to the table rows
              TableRow(
                children: [
                  Text(teamName, style: TextStyle(fontSize: 20)),
                  Center(child: Text('$wins', style: TextStyle(fontSize: 20))),
                  Center(child: Text('$losses', style: TextStyle(fontSize: 20))),
                ],
              ),
            );
          }
          return Table( // returns a table of the teams in the tournament and their scores
            columnWidths: {
              0: FlexColumnWidth(2.5), // makes the first column larger
            },
            border: TableBorder.all(color: Colors.red, width: 2.0),
            children: rows,
          );
        }
      },
    );
  }
}