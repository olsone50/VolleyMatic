import 'package:flutter/material.dart';
import 'package:volleymatic/volleymatic_model.dart';

/// Name: Derek Gresser
/// Date: 4/3/24
/// Description: This widget allows an admin to updates the scores
/// for a given game. There are text fields for Sets 1 and 2 for
/// each team. There is also a Set 3 checkbox and Update Scores
/// button that currently only pops the navigator.
/// Bugs: Data is currently hard coded. Database not used yet.
class UpdateScores extends StatefulWidget {
  const UpdateScores(String team1name, String team2name,
      {super.key, required VolleymaticModel model});

  @override
  State<UpdateScores> createState() => UpdateScoresState();
}

class UpdateScoresState extends State<UpdateScores> {
  //Bool to hold the checkbox's state
  bool set3Bool = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Scores'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CheckboxListTile(
            title: const Text('Set 3'),
            value: set3Bool,
            onChanged: (bool? value) {
              setState(() {
                set3Bool = value!;
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text('1W 17 National',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          scoreRow('Set 1:'),
          scoreRow('Set 2:'),
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text('1W 16 National',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          scoreRow('Set 1:'),
          scoreRow('Set 2:'),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Update Scores'),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns a row with lableText denoting the set number and a
  /// text field for updating that teams score.
  Widget scoreRow(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        children: [
          Text(labelText, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 120),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
