// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:flutter/material.dart';
import 'volleymatic_model.dart';
import 'game.dart';
import 'package:tournament_bracket/tournament_bracket.dart';
import 'team.dart';
import 'match_details.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key, required this.model});

  final VolleymaticModel model; // gets the volleymatic model for the app

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  String? _selectedName; // a string for the selected name
  bool showPoolPlay = true; // pool play is set to true

  @override
  Widget build(BuildContext context) {
    final List<String> teamNames = widget.model.getTournamentNames(); // gets all the names for the tournaments

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              color: Color.fromARGB(
                  255, 102, 11, 4), // makes the color of the dropdown dark red
              child: ListView(shrinkWrap: true, children: [
                DropdownButton<String>(
                  value:
                      _selectedName, // sets the value to the selected value of the dropdown
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedName =
                          newValue; // sets the state as the dropdown menu item
                    });
                  },
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white), // sets the text color and font size
                  dropdownColor: Color.fromARGB(255, 102, 11, 4),
                  items:
                      teamNames.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          value), // creates a dropdown menu item widget as the text of the tournament
                    );
                  }).toList(), // assigns the list to the dropdown menu
                ),
              ])),
          _poolOrBracketRow(), // displays the text and icons of pool or bracket play
          showPoolPlay ? _poolPlayView() : _bracketPlayView(),
        ],
      ),
    );
  }

  /// returns a row with text that either says Pool Play or Bracket Play with the corresponding icons
  Row _poolOrBracketRow() {
    return Row(children: [
      Text(
          showPoolPlay
              ? 'POOL PLAY'
              : 'BRACKET PLAY', // displays pool play or bracket play text
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold)), // bolds the text name
      Spacer(), // adds space between text and icon
      ElevatedButton(
          onPressed: () {
            setState(() {
              showPoolPlay = !showPoolPlay; // toggle the view state to show pool play or show bracket play
            });
          },
          child: showPoolPlay ? Icon(Icons.table_chart) : Icon(Icons.list))
    ]);
  }

  /// returns an {Expanded} form of the pool play view that has two text buttons and two list views for 
  /// the different pools for each tournament 
  Expanded _poolPlayView() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // streches each item to the sides of the screen
      children: [
          Container(
            decoration: BoxDecoration(
            color: Colors.red,), // set the container background color to red
          child: TextButton(onPressed: null, child: Text('Pool 1',
              style: const TextStyle( // sets text background color to red 
              fontSize: 24,
               color: Colors.white,))),
            ),
        _listPoolWidgets(
            widget.model.pool1Games), // display the first pool games
        Container(
              decoration: BoxDecoration(
              color: Colors.red,), // set the container background color to red
            child: TextButton(onPressed: null, child: Text('Pool 2',
              style: const TextStyle( // sets text background color to red 
              fontSize: 24,
              color: Colors.white,
        ))),),
        _listPoolWidgets(
            widget.model.pool2Games), // display the second pool games
      ],
    ));
  }

  /// returns a {ListView} of the pools for each tournament that displays the two teams playing each other
  /// and the court number and game time
  Expanded _listPoolWidgets(List<Game> pool) {
    return Expanded(
      child: ListView.separated( // creates a list view for the pool
      itemCount: pool.length,
      itemBuilder: (context, index) {
        var game = pool[index];
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ // displays the two teams playing each other
              Text(game.team1),
              Text('VS'),
              Text(game.team2),
            ],
          ),
          subtitle: Text('Court ${game.courtNum} - ${game.time}'), // displays the court number and game time
          onTap: () {
            Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MatchDetails())); // goes to match details when clicked
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.red), // creates a divider between each list tile
    ));
  }

  /// returns a scrollable bracket view of the teams based on their rankings 
  SingleChildScrollView _bracketPlayView() {
    final teams = widget.model.teams; // get the teams from the model

    final pool1Teams = teams.where((team) => team.rank <= 3).toList(); // filter teams for pool1
  
    return SingleChildScrollView(scrollDirection: Axis.horizontal,
      child: Column(children: [ // creates the bracket
        _bracket([pool1Teams]),]));
  }

  /// creates a bracket view that includes the names of the teams and the theme of the bracket
  TBracket<Team> _bracket(List<List<Team>> teams){
    return TBracket<Team>(
      space: 100 / 4, // creates space between items and the different levels
      separation: 100,
      stageWidth: 200,
      onSameTeam: (team1, team2) { // don't include duplicate teams
        if (team1 != null && team2 != null) {
          return team1.name == team2.name;
        }
        return false;
      },
      onContainerTapDown: (model, tapDownDetails) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MatchDetails())), // goes to match details when clicked
      hadderBuilder: (context, index, count) => Text(''), // no labels above each game
      connectorColor: Colors.red,
      teamContainerDecoration: BracketBoxDecroction( // makes the boxes around the names red
        borderRadious: 17,
        color: Colors.red,
      ),
      stageIndicatorBoxDecroction: BracketStageIndicatorBoxDecroction(primaryColor: Colors.transparent,
      secondaryColor: Colors.transparent), // set the background color to transparent
      containt: teams,
      teamNameBuilder: (Team t) { // creates the individual teams in the bracket
        return BracketText(
          text: t.name,
          textStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
      },
      context: context,
    );
  }
}

