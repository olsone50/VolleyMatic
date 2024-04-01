import 'package:flutter/material.dart';
import '_tournaments.dart';
import 'package:table_calendar/table_calendar.dart';

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