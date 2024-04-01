
class Tournament {
  String name; // stores the name of the tournament
  String location ; // stores the location of the tournament
  DateTime date; // stores the date for the tournament
  int numCourts; // stores the number of courts for the tournament

  /// constructor for tournament that requires a name, location, date and number of courts to store
  Tournament({required this.name, required this.location, required this.date, required this.numCourts});
}