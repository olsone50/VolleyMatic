// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'volleymatic_model.dart';
import 'package:intl/intl.dart';


class Calendar extends StatefulWidget {
  const Calendar({super.key, required this.model});

  final VolleymaticModel model;

  @override
  State<Calendar> createState() => CalendarWidget();
}

class CalendarWidget extends State<Calendar> {
  DateTime? _selectedDate = DateTime.now(); // makes a variable for the current selected date

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime firstDay = DateTime(now.year, now.month - 1, now.day);
    final DateTime lastDay = DateTime(now.year, now.month + 1, now.day);
    final DateTime focusedDay = now; 

    return Column(
      children: [
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
              todayTextStyle: TextStyle(color: Colors.black), // makes the font color black for today's date so that it shows up
              todayDecoration:  BoxDecoration(
                border: Border.all(color: Colors.red), // outlines box for today's date
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration( // makes the selected date have a red circle
                color: Colors.red.withOpacity(0.8),
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
            selectedDayPredicate: (DateTime day) {
              return isSameDay(day, _selectedDate);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay; // switches the selected day
              });
            },
          ),
        ),
        if (_selectedDate != null) _buildTournamentList(), // displays the tournaments list for the date selected
      ],
    );
  }

  /// returns an {Expanded} widget that has a {ListView} of all the tournaments that are on a selected date
  Expanded _buildTournamentList(){
    return Expanded(
      child: FutureBuilder (
        future: widget.model.fetchTournamentsOnDate(DateFormat('MM-dd-yyyy').format(_selectedDate!)), // gets the tournaments from the database
        builder:(context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator()); // display loading symbol if still loading
              }
                final tournaments = snapshot.data!;
                return ListView.builder(
                  itemCount: tournaments.length,
                  itemBuilder: ((context, index) {
                    final tournament = tournaments[index];
                    return ListTile(
                      leading: Container(height: 5, width: 5, color: Colors.red),
                      title: Text(tournament['name']),
                      subtitle: Text.rich(
                        TextSpan(
                          text: '${tournament['date']}\n${tournament['location']}',
                        ),
                      ),
                    );
                  }),
                );
            },
        ),
    );
  }
}
