// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';

class AddTeams extends StatelessWidget {
  AddTeams({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController rankController = TextEditingController();

  final teamNames = [];
  final teamRanks = []; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: SizedBox(
                width: 70, height: 70, child: Image.asset('assets/logo.png')),
            centerTitle: true,
            actions: [ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // goes back to the upcoming tournaments screen when clicked
                  Navigator.pop(context);       
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red)),
                child: Text('Done',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.all(20.0), // adds padding to all sides
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              'ENTER TEAM INFORMATION',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // adds space between team information and text fields
            Row(children: [Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)), 
                  Spacer(), Text('Rank', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),]),   
            SizedBox(height: 40),     
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Team Name')),
            TextField(
                controller: rankController,
                decoration: InputDecoration(labelText: 'Rank'),
                keyboardType: TextInputType.number),
            SizedBox(height: 20), // adds space between textfields and roster upload
            Row(children: [Text('Roster (optional)', style: TextStyle(fontSize: 18)), Spacer(), ElevatedButton(onPressed: null, child: Icon(Icons.upload))]),
            SizedBox(height: 30), // adds space between roster upload and button
            SizedBox(
                child: OutlinedButton(
                    // creates an outlined button for add teams
                    onPressed: _addTeam,
                    style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            color: Colors.red), // set border color to red
                      ),
                    ), 
                    child: Text('Add Team',style: TextStyle(color: Colors.red, fontSize: 25), // sets text
                    ))),
          ]),
        ));
  }

  Column _addTeam() {
    teamNames.add(nameController.text);
    teamRanks.add(rankController.text);     

    return Column(children: [   
      ListView.builder(itemCount: teamNames.length, 
          itemBuilder: (context, index) {return ListTile(title: Text(teamNames[index]), trailing: Text(teamRanks[index]));},)
    ]); 
  }
}
