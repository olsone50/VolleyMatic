import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volley_matic/volley_matic.dart';
//import 'volleymatic_model.dart';
import 'upcoming_tournaments_widget.dart';
//import 'schedule_widget.dart';
//import 'standings_widget.dart';
import 'account_settings.dart';
import '_schedule.dart';
import '_standings.dart';

void main() {
  final volleymaticModel = VolleymaticModel(); // gets the model
  volleymaticModel.initializeSupabase(); // initializes the Supabase database

  runApp(ChangeNotifierProvider(
      // creates a change notifier provider for the volleymatic model so that it will change if notified
      create: (context) => volleymaticModel,
      child: MaterialApp(home: Welcome())));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Widget> _tabs = [
    Consumer<VolleymaticModel>(
      builder: (context, volleymaticModel, child) =>
          UpcomingTournaments(model: volleymaticModel),
    ),
    Consumer<VolleymaticModel>(
        builder: (context, volleymaticModel, child) =>
            Schedule(model: volleymaticModel)),
    Consumer<VolleymaticModel>(
      builder: (context, volleymaticModel, child) =>
          Standings(model: volleymaticModel),
    ),
    Consumer<VolleymaticModel>(
      builder: (context, volleymaticModel, child) =>
          Settings(model: volleymaticModel),
    ),
  ];
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red), // makes the primary color red
        home: Scaffold(
          //appBar: AppBar(title: SizedBox(width: 70, height: 70, child: Image.asset('assets/logo.png')), centerTitle: true,), // puts the logo in the app bar and centers it
          body: _tabs[selectedTabIndex], // sets tab view to the selected tab
          bottomNavigationBar: BottomNavigationBar( // creates a bottom navigation bar for the app
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Upcoming'), // upcoming tournaments tab
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Schedule'), // schedule tab
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Standings'), // standings tab
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Account Settings'), // account settings tab
            ],
            currentIndex: selectedTabIndex,
            onTap: _tabSwitched, // switches the tab view when clicked
            selectedItemColor: Colors.red, // makees the selected tab red
            unselectedItemColor: const Color.fromARGB(255, 135, 132, 131), // makes the unselected tabs gray
          ),
        ));
  }

  void _tabSwitched(int index) {
    setState(() {
      selectedTabIndex = index; // sets the selected tab index to the tab index when clicked
    });
  }
}
