import 'package:flutter/material.dart';
import 'volleymatic_model.dart';

class Standings extends StatefulWidget {
  final VolleymaticModel model; // Define 'model' property

  const Standings({Key? key, required this.model}) : super(key: key);

  @override
  State<Standings> createState() => StandingsWidget();
}

class StandingsWidget extends State<Standings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Standings'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.red),
          columns: const [
            DataColumn(label: Text('Team')),
            DataColumn(label: Text('Wins')),
            DataColumn(label: Text('Losses')),
          ],
          rows: widget.model.teams.asMap().entries.map((entry) {
            final index = entry.key;
            final team = entry.value;
            final isEvenRow = index.isEven;
            final backgroundColor = isEvenRow
                ? Colors.red[100]
                : null; // Change this to whatever color you prefer
            return DataRow(
              color: MaterialStateProperty.all(backgroundColor),
              cells: [
                DataCell(Text(team.name)),
                DataCell(Text(team.winCount.toString())),
                DataCell(Text(team.lossCount.toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
