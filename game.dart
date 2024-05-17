class Game {
  String team1; // string for team name 1
  String team2; // string for team name 2
  String workTeam; // string for work team
  String time; // string for the time
  int courtNum; // number for the court

  /// constructor for team that requires team1, team2, workTeam, a time and a court number
  Game({
    required this.team1,
    required this.team2,
    required this.workTeam,
    required this.time,
    required this.courtNum,
  });
}
