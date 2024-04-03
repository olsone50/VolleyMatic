import 'package:flutter/material.dart';
import 'match_details.dart';
import 'tournament.dart';
import 'volleymatic_model.dart';

class UpcomingTournaments extends StatefulWidget {
  final VolleymaticModel model; // Add this line to declare model as a property

  const UpcomingTournaments({Key? key, required this.model}) : super(key: key);

  @override
  State<UpcomingTournaments> createState() => UpcomingTournamentsWidget();
}


class UpcomingTournamentsWidget extends State<UpcomingTournaments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Tournaments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => Calendar(model: widget.model)), // Use widget.model here
              // );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.model.tournaments.length, // Use widget.model.tournaments here
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            color: Colors.red,
            child: ListTile(
              onTap: () {
                tapped(widget.model.tournaments[index]); // Use widget.model.tournaments here
              },
              title: Text(
                widget.model.tournaments[index].name, // Use widget.model.tournaments here
                style: const TextStyle(color: Colors.white)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${widget.model.tournaments[index].date}', // Use widget.model.tournaments here
                    style: const TextStyle(color: Colors.white)),
                  Text(
                    'Location: ${widget.model.tournaments[index].location}', // Use widget.model.tournaments here
                    style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  tapped(Tournament tournament) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchDetails()));         
  }
}

