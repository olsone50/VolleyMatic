import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volleyball Tournaments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = <Widget>[
    const HomeScreenBody(),
    const ScheduleScreen(),
    const StandingsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 
      ? AppBar(
        title: const Text('Upcoming Tournaments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarScreen()),
              );
            }
          )
        ],
      )
      : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day_rounded),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart),
            label: 'Standings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Home Screen
class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tournaments.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          color: Colors.red,
          child: ListTile(
            title: Text(
              tournaments[index].title,
              style: const TextStyle(color: Colors.white)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date: ${tournaments[index].date}',
                  style: const TextStyle(color: Colors.white)),
                Text(
                  'Location: ${tournaments[index].location}',
                  style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Calendar Screen
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Tournaments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          )
        ],
      ),
      body: const CalendarWidget(),
    );
  }
}

// Calendar
class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime firstDay = DateTime(now.year, now.month - 1, now.day);
    final DateTime lastDay = DateTime(now.year, now.month + 1, now.day);
    final DateTime focusedDay = now;

    Map<DateTime, List<String>> events = {};

    for (var tournament in tournaments) {
      DateTime date = DateTime.parse(tournament.date);
      events.update(date, (value) {
        // ignore: unnecessary_null_comparison
        if (value != null) {
          value.add(tournament.title);
          return value;
        } else {
          return [tournament.title];
        }
      }, ifAbsent: () => [tournament.title]);
    }

    // Find the closest upcoming tournament
    Tournament? closestTournament;
    DateTime closestDate = DateTime(9999, 12, 31); // Initialize with a far future date

    for (var tournament in tournaments) {
      DateTime date = DateTime.parse(tournament.date);
      if (date.isAfter(now) && date.isBefore(closestDate)) {
        closestDate = date;
        closestTournament = tournament;
      }
    }

    return Column(
      children: [
        // Calendar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCalendar(
            firstDay: firstDay,
            focusedDay: focusedDay,
            lastDay: lastDay,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.red),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonShowsNext: false,
            ),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            eventLoader: (day) {
              return events[day] ?? [];
            },
          ),
        ),
        // Closest tournament card
        closestTournament != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Closest Tournament:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Title: ${closestTournament.title}',
                          style: const TextStyle(color: Colors.white)),
                        Text(
                          'Date: ${closestTournament.date}',
                          style: const TextStyle(color: Colors.white)),
                        Text(
                          'Location: ${closestTournament.location}',
                          style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              )
            : Container(), // If no upcoming tournament found, display an empty container
      ],
    );
  }
}

// Standings
class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Standings'),
      ),
      body: const Center(
        child: Text('Standings Screen'),
      ),
    );
  }
}

// Schedule
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: const Center(
        child: Text('Schedule Screen'),
      ),
    );
  }
}

// Settings 
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SettingsWidget(),
    );
  }
}

// Settings 1
class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User Name:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Club Name:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Volleyball Club',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Tournament:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Tournament 1',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to change password screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
                    ),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Logout logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Delete account logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
                    ),
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// Settings 2
class SettingsWidgetLogOut extends StatelessWidget {
  const SettingsWidgetLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Logout logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Delete account logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
                    ),
                    child: const Text(
                      'Create an Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

class Tournament {
  final String title;
  final String date;
  final String location;

  Tournament({
    required this.title,
    required this.date,
    required this.location,
  });
}

List<Tournament> tournaments = [
  Tournament(
    title: 'Volleyball Tournament 1',
    date: '2024-04-05',
    location: 'City Sports Complex',
  ),
  Tournament(
    title: 'Volleyball Tournament 2',
    date: '2024-04-12',
    location: 'Beach Arena',
  ),
  Tournament(
    title: 'Volleyball Tournament 3',
    date: '2024-04-19',
    location: 'Indoor Arena',
  ),
];