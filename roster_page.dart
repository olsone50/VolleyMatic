// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

/// Description: This widget displays the roster of a given team.
/// The team name is displayed at the top with a list view of the roster
/// and coaches.
class RosterPage extends StatelessWidget {
  final String teamName;

  const RosterPage({super.key, required this.teamName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: 70, height: 70, child: Image.asset('assets/logo.png')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Colors.red, // set the container background color to red
                  ),
                  child: TextButton(
                      onPressed: null,
                      child: Text(teamName,
                          style: const TextStyle(
                            // sets text background color to red
                            fontSize: 24,
                            color: Colors.white,
                          ))),
                ),
              ),
            ],
          ),
          SizedBox(child: Text('assets/1W 16 Crimson Roster.png')),
        ],
      ),
    );
  }
}
