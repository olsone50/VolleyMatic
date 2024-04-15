import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'tournament.dart';
import 'team.dart';
import 'game.dart';

class VolleymaticModel extends ChangeNotifier {
  void initializeSupabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize( // gets the database functionality for the model
      url: 'https://thssqujpqkjapvwqfdal.supabase.co', // supabase project URL
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRoc3NxdWpwcWtqYXB2d3FmZGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIyNTg4NTYsImV4cCI6MjAyNzgzNDg1Nn0.HFtkIhXMrPTYkaFbSsJnssBCfJHKajNYUhQCtYrjZuQ',
    );
  } 

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

  var pool1Games = [ // creates a list of games for pool 1
    Game(team1: '1W 17 National', team2: '1W 18 National', workTeam: '1W 16 National', 
          time: '8:00 AM', courtNum: 1),
    Game(team1: '1W 17 National', team2: '1W 16 National', workTeam: '1W 18 National', 
          time: '9:00 AM', courtNum: 1),
    Game(team1: '1W 18 National', team2: '1W 16 National', workTeam: '1W 17 National', 
          time: '10:00 AM', courtNum: 1),
  ];

  var pool2Games = [
    Game(team1: '1W 17 Crimson', team2: '1W 16 Crimson', workTeam: '1W 16 Silver', 
          time: '8:00 AM', courtNum: 2),
    Game(team1: '1W 17 Crimson', team2: '1W 16 Silver', workTeam: '1W 16 Crimson', 
          time: '9:00 AM', courtNum: 2),
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

  List<String> getPool1Names(){
    List<String> names = [];
    for(Game game in pool1Games){
      if(!names.contains(game.team1)){
        names.add(game.team1);// adds the team 1 name if not already in list
      } else if(!names.contains(game.team2)){
        names.add(game.team2); // adds the team 2 name if not already in list
      }
    }
    return names; // returns a list of all the team names from pool 1
  }

  List<String> getPool2Names(){
    List<String> names = [];
    for(Game game in pool2Games){
      if(!names.contains(game.team1)){
        names.add(game.team1);// adds the team 1 name if not already in list
      } else if(!names.contains(game.team2)){
        names.add(game.team2); // adds the team 2 name if not already in list
      }
    }
    return names; // returns a list of all the team names from pool 2
  }
}
