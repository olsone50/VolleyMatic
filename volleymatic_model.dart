import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'tournament.dart';
import 'team.dart';
import 'game.dart';

class VolleymaticModel extends ChangeNotifier {
  final SupabaseClient supabase;

  VolleymaticModel({required this.supabase});

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

  /// fetches the list of tournaments from the database
  Future fetchTournaments() {
    return supabase.from('tournaments').select(); // fetches all the tournaments from the database
  }

  /// fetches the list of tournaments on a specific date from the database
  Future fetchTournamentsOnDate(String date){
    return supabase.from('tournaments').select().eq('date', date); // selects the tournaments that are on the date selected
  }

  /// fetches the tournament information from the database
  Future fetchTournament(int tournamentId){
    return supabase.from('tournaments').select().eq('tournament_id', tournamentId); // selects the tournament using the id
  }

  /// fetches the list of teams from a specific tournament from the database
  Future fetchTeamsFromTournament(int tournamentId){
    return supabase.from('teams').select().eq('tournament_id', tournamentId); // selects the team names and ranks from the team database
  }

  /// fetches the specific game from the database
  Future fetchGameFromId(int gameId){
    return supabase.from('games').select().eq('game_id', gameId); // selects the games that correspond to the gameId
  }

  /// fetches the specific match from the database
  Future fetchMatchesFromId(int matchId){
    return supabase.from('bracket_matchups').select().eq('match_id', matchId); // selects the matches that correspond to the matchId 
  }

  /// Adds a new team to the teams table
  Future<void> addTeam(int tournamentId, String name, int rank, String rosterImg) async {
    final response = await supabase.from('teams').insert([{
      'tournament_id': tournamentId,
      'name': name,
      'rank': rank,
      'roster_img': rosterImg,
      'set_wins': 0, // sets set wins and losses to zero
      'set_losses': 0
    }]);

    if (response.error != null) {
      throw Exception('Failed to add team'); // throw an exception if insertion fails
    }
  }

  /// Adds a new tournament to the tournaments table
  Future<void> addTournament(String name, String location, String date, int numCourts) async {
    final response = await supabase.from('tournaments').insert([{
      'name': name,  // inserts the tournament with the given information
      'location': location,
      'date': date,
      'num_courts': numCourts
    }]);
  }

  /// Function to update scores in the database
  Future<void> updateScores(int team1Score1, int team1Score2, team2Score1, team2Score2) async {
    await supabase.from('scores').upsert([ // inserts team scores into database
      {
        'team1_set1': team1Score1,
        'team1_set2': team1Score2,
        'team2_set1': team2Score1,
        'team2_set2': team2Score2,
      }
    ]);
  }

  /// creates an account for the user with the email, password, username, and club name
  Future<void> createAccount(String email, String username, String password, String clubName) async {
    final response = await supabase.auth.signUp(email: email, password: password, data: {'username': username, 'club_name': clubName});
  }

  /// logs in a user using email and password
  Future<void> loginUser(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword( // signs in the user with email and password
        email: email, 
        password: password,
      );
      final session = response.session; // access to session
      final user = response.user; // access to user

      print('User signed in successfully: ${user!.email}'); // user signed in successfully
    } catch (error) {
      // Handle any errors that occur during sign-in
      print('Error signing in: $error');
    }
  }
<<<<<<< Updated upstream
=======

    /// fetches the closest tournament date from today's date
  Future<String?> fetchClosestTournamentDate() async {
    final response = await supabase
        .from('tournaments')
        .select('date')
        .order('date', ascending: true)
        .limit(1);
    Map<String, dynamic> tournament = response[0];
    if (tournament.containsKey('date')) {
      return tournament['date'].toString(); // return just the date from the database
    }
    return null; // return null if no date is found or if the response is empty
  }

>>>>>>> Stashed changes
}
