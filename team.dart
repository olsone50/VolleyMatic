
class Team {
  String name; // stores the name of the team
  int rank; // stores the rank of the team
  String? rosterPath; // stores an image path of the roster for the team

  /// constructor for team that requires a name, rank, and roster image path to store
  Team({required this.name, required this.rank, this.rosterPath,});
}