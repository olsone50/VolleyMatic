// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'roster_page.dart';
import 'update_scores.dart';
import 'volleymatic_model.dart';

/// Description: This widget displays the match details for a given matchup.
/// When the team name is clicked, the user is pushed to the roster page.
/// If the user is an admin a Update Scores button is available in the
/// actions. The user is pushed to that screen when clicked.
class MatchDetails extends StatelessWidget {
  //***Modify constructor to retreive some game details from schedule_widget??***
  const MatchDetails({super.key, required this.model, required this.info});

  final VolleymaticModel model;
  final dynamic info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: 70, height: 70, child: Image.asset('assets/logo.png')),
        centerTitle: true,
        actions: [
          updateScoresButton(context),
        ],
      ),
      body: FutureBuilder(
        future: info,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final matchDetails = snapshot.data!
                as Map<String, dynamic>; // gets the match details
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('MATCH DETAILS',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            detailsRow(
                                'Court Number: ${matchDetails['court_no'].toString()}'),
                            linkedTeamName(context, matchDetails['team1']),
                            linkedTeamName(context, matchDetails['team2']),
                            detailsRow(
                                'Work Team: ${matchDetails['work_team']}'),
                            detailsRow(
                                'Time: ${matchDetails['time'].toString()}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  /// Returns a row that displays the team name of a given matchup.
  /// The GestureDetector is used to push the user to the RosterPage
  /// when the name is clicked.
  Widget linkedTeamName(BuildContext context, String teamName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RosterPage(teamName: teamName)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Text(teamName,
                style: const TextStyle(
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  /// Returns a button that displays 'Update Scores'.
  Widget updateScoresButton(BuildContext context) {
    final String team1Name = info['team1'];
    final String team2Name = info['team2'];

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateScores(team1Name, team2Name,
                  model: model)), // goes to the update scores page
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // makes the button red
      ),
      child: const Text('Update Scores',
          style: TextStyle(color: Colors.white)), // makes the text white
    );
  }

  /// Returns a row for the match details with the desired text.
  Widget detailsRow(String textInfo) {
    return Row(
      children: [
        Text(
          textInfo,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
