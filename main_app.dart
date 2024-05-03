import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'volleymatic_model.dart';
import 'upcoming_tournaments_widget.dart';
import 'schedule_widget.dart';
import 'standings.dart';
import 'account_settings.dart';

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
            ScheduleWidget(model: volleymaticModel)),
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
      home: Scaffold(
        appBar: AppBar(
          title: SizedBox(
              width: 70, height: 70, child: Image.asset('assets/logo.png')),
          centerTitle: true,
        ), // puts the logo in the app bar and centers it
        body: _tabs[selectedTabIndex], // sets tab view to the selected tab
        bottomNavigationBar: BottomNavigationBar(
          // creates a bottom navigation bar for the app
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Upcoming'), // upcoming tournaments tab
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'Schedule'), // schedule tab
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Standings'), // standings tab
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Account Settings'), // account settings tab
          ],
          currentIndex: selectedTabIndex,
          onTap: _tabSwitched, // switches the tab view when clicked
          selectedItemColor: Colors.red, // makees the selected tab red
          unselectedItemColor: const Color.fromARGB(
              255, 135, 132, 131), // makes the unselected tabs gray
        ),
      ),
    );
  }

  /// switches the screens when different tabs are selected
  void _tabSwitched(int index) {
    setState(() {
      selectedTabIndex =
          index; // sets the selected tab index to the tab index when clicked
    });
  }
}
