import 'package:flutter/material.dart';

/// Name: Derek Gresser
/// Date: 4/3/24
/// Description: This widget displays the roster of a given team.
/// The team name is displayed at the top with a list view of the roster
/// and coaches.
/// Bugs: Data is currently hard coded. Database not used yet.
class RosterPage extends StatelessWidget {
  final String teamName;
  final List<String> rosterList = [
    'Sarah Johnson',
    'Emily Brown',
    'Alexa Ramirez',
    'Jessica Lee',
    'Amanda Thompson',
    'Mia Smith',
    'Tiffany Wells',
    'Erica Rhimes',
    'Julie Potts',
  ];

  RosterPage({super.key, required this.teamName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Roster'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(teamName,
                  style: const TextStyle(
                    fontSize: 24,
                    decoration: TextDecoration.underline,
                  )),
            ],
          ),
          //Players list view
          Expanded(
            child: ListView.builder(
              itemCount: rosterList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  leading: Text((index + 1).toString()),
                  title: Text(rosterList[index],
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                );
              },
            ),
          ),
          //Coaches list tile
          const ListTile(
            dense: true,
            title: Text('Coaches:\nLisa Smith\nRyan Anderson',
                style: TextStyle(
                  fontSize: 14,
                )),
          ),
          const SizedBox(height: 18), //Space below bottom
        ],
      ),
    );
  }
}
