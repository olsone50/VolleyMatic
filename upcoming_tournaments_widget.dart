import 'package:flutter/material.dart';
import 'package:volley_matic/match_details.dart';
import 'package:volley_matic/tournament.dart';
import '_calendar.dart';
import 'volley_matic.dart';

class UpcomingTournaments extends StatefulWidget {
  const UpcomingTournaments({super.key, required VolleymaticModel model});

  @override
  State<UpcomingTournaments> createState() => UpcomingTournamentsWidget();
}

class UpcomingTournamentsWidget extends State<UpcomingTournaments> {

  var tournaments = VolleymaticModel().tournaments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Tournaments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calendar(model: VolleymaticModel())),
              );
            }
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tournaments.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.red,
                  child: ListTile(
                    onTap: () { tapped(tournaments[index]); },
                    title: Text(
                      tournaments[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${tournaments[index].date}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Location: ${tournaments[index].location}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  //Handle Button Press
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  tapped(Tournament tournaments) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchDetails()));
  }
}
