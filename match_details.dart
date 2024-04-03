import 'package:flutter/material.dart';
import 'roster_page.dart';
import 'update_scores.dart';

/// Name: Derek Gresser
/// Date: 4/3/24
/// Description: This widget displays the match details for a given matchup.
/// When the team name is clicked, the user is pushed to the roster page.
/// If the user is an admin a Update Scores button is available in the
/// actions. The user is pushed to that screen when clicked.
/// Bugs: Data is currently hard coded. Database not used yet.
class MatchDetails extends StatelessWidget {
  const MatchDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volleymatic'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          updateScoresButton(context),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: Colors.white, // Background color for "Match Details"
            padding: const EdgeInsets.all(16.0),
            child: const Text('Match Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red, // Background color for everything else
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      detailsRow('Court 1\n8:00 AM'),
                      linkedTeamName(context, '1W 17 National'),
                      linkedTeamName(context, '1W 16 National'),
                      detailsRow('Work Team:\n1W 18 National'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UpdateScores()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: const Text('Update Scores'),
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
