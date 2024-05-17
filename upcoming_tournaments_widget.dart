// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'add_tournament.dart';
import 'schedule_widget.dart';
import 'package:flutter/material.dart';
import 'calendar.dart';
import 'volleymatic_model.dart';

class UpcomingTournaments extends StatefulWidget {
  UpcomingTournaments({super.key, required this.model});

  final VolleymaticModel model; // gets model for the app

  @override
  State<UpcomingTournaments> createState() => UpcomingTournamentsWidget();
}

class UpcomingTournamentsWidget extends State<UpcomingTournaments> {
  bool showListView = true; // show list view is set to true

  @override
  Widget build(BuildContext context) {
    if (showListView) {
      return Column(children: [
        _listViewOrCalendarView(),
        Expanded(
          child: _listOfTournaments(), // displays the tournaments
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
                addTapped();
              },
            ),
          ),
        )
      ]);
    } else {
      return Column(children: [
        _listViewOrCalendarView(),
        Expanded(child: Calendar(model: widget.model))
      ]);
    }
  }

  /// returns a {FutureBuilder} of the list of tournaments from the database
  FutureBuilder _listOfTournaments() {
    return FutureBuilder(
        future: widget.model.fetchTournaments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final tournaments = snapshot.data!;
          return ListView.builder(
            itemCount: tournaments.length,
            itemBuilder: (context, index) {
              final tournament = tournaments[index]; // gets tournament
              return Card(
                margin: const EdgeInsets.all(8.0),
                color: Colors.red,
                child: ListTile(
                  onTap: () {
                    tournamentTapped();
                  },
                  title: Text(
                    tournament['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tournament['date'], // gets the date of the tournament
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        tournament[
                            'location'], // gets the location of the tournament
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  /// returns a row that says upcoming tournaments with either a calendar icon or list icon
  Container _listViewOrCalendarView() {
    return Container(
      padding: const EdgeInsets.all(8.0), // adds padding
      child: Row(children: [
        Text('UPCOMING TOURNAMENTS', // displays upcoming tournaments text
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)), // bolds the text name
        Spacer(), // adds space between text and icon
        ElevatedButton(
            onPressed: () {
              setState(() {
                showListView =
                    !showListView; // toggle the view state to show list view or show calendar view
              });
            },
            child: showListView ? Icon(Icons.calendar_today) : Icon(Icons.list))
      ]),
    );
  }

  /// shows the {ScheduleWidget} screen
  tournamentTapped() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScheduleWidget(model: widget.model)),
    );
  }

  /// shows the {AddTournament} screen
  addTapped() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTournament(model: widget.model)));
  }
}
