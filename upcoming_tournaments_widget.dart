import 'package:flutter/material.dart';
import '_tournaments.dart';
import '_calendar.dart';


class _HomeScreenState extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Tournaments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarWidget()),
              );
            }
          )
        ],
      ),
    );
  }
}

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