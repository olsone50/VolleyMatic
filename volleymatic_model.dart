import 'package:flutter/material.dart';
import 'tournament.dart';
import 'team.dart';
import 'game.dart';

var tournaments = [ // creates a list of tournaments that stores the name, location, date, and number of courts
    Tournament(name: 'Bay Bash 14s/15s', location: 'Sports Advantage Center', date: DateTime(2024, 4, 13), numCourts: 3),
    Tournament(name: 'Ice Breaker 17s', location: 'Sports Advantage Center', date: DateTime(2024, 4, 14), numCourts: 3),
    Tournament(name: 'Bay Bash 16s', location: 'Sports Advantage Center', date: DateTime(2024, 4, 20), numCourts: 3),
  ];

class VolleymaticModel extends ChangeNotifier {
  var tournaments = [ // creates a list of tournaments that stores the name, location, date, and number of courts
    Tournament(name: 'Bay Bash 14s/15s', location: 'Sports Advantage Center', date: DateTime(2024, 4, 13), numCourts: 3),
    Tournament(name: 'Ice Breaker 17s', location: 'Sports Advantage Center', date: DateTime(2024, 4, 14), numCourts: 3),
    Tournament(name: 'Bay Bash 16s', location: 'Sports Advantage Center', date: DateTime(2024, 4, 20), numCourts: 3),
  ];

  var teams = [ // creates a list of teams that stores the name, rank, and image path for a roster
    Team(name: '1W 17 National', rank: 2, rosterPath: 'assets/1W 17 National Roster.png'),
    Team(name: '1W 16 National', rank: 3, rosterPath: 'assets/1W 16 National Roster.png'),
    Team(name: '1W 18 National', rank: 1, rosterPath: 'assets/1W 18 National Roster.png'),
    Team(name: '1W 17 Crimson', rank: 4, rosterPath: 'assets/1W 17 Crimson Roster.png'),
    Team(name: '1W 16 Crimson', rank: 5, rosterPath: 'assets/1W 16 Crimson Roster.png'),
    Team(name: '1W 16 Silver', rank: 6, rosterPath: 'assets/1W 16 Silver Roster.png'), 
  ];

  var games = [
    Game(team1: '1W 17 National', team2: '1W 18 National', workTeam: '1W 16 National', 
          time: '8:00 AM', courtNum: 1),
    Game(team1: '1W 17 Crimson', team2: '1W 16 Crimson', workTeam: '1W 16 Silver', 
          time: '8:00 AM', courtNum: 2),
    Game(team1: '1W 17 National', team2: '1W 16 National', workTeam: '1W 18 National', 
          time: '9:00 AM', courtNum: 1),
    Game(team1: '1W 17 Crimson', team2: '1W 16 Silver', workTeam: '1W 16 Crimson', 
          time: '9:00 AM', courtNum: 2),
    Game(team1: '1W 18 National', team2: '1W 16 National', workTeam: '1W 17 National', 
          time: '10:00 AM', courtNum: 1),
    Game(team1: '1W 16 Crimson', team2: '1W 16 Silver', workTeam: '1W 17 Crimson', 
          time: '10:00 AM', courtNum: 2),
  ];

  List<String> getTournamentNames(){
     List<String> names = [];
    for (Tournament tournament in tournaments) {
      names.add(tournament.name); // adds the name to the list of tournaments
    }
    return names; // returns a list of all the names of the tournaments
  }
}
