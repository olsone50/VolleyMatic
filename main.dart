// ignore_for_file: prefer_const_constructors, dangling_library_doc_comments, use_build_context_synchronously

/// Names: Carissa Engebose, Evan Olson, Derek Gresser, Luke Kastern
/// Date: 4/19/2024
/// Description: An app that has four tabs to display upcoming tournaments (in both list and calendar view),
/// schedule (pool play and bracket play), standings, and account information.
/// Bugs: The addTournament, Upcoming Tournaments, Standings, and Roster were all working, but the addTeam
/// and schedule along with any of the account related tabs don't work yet.
/// Reflection: It took us a little time to figure out how to get specific information back from the database
/// and finding how to use the information without using a FutureBuilder. There was a lot of information that we
/// needed from our database that wasn't working like it was supposed to while running the app. At one point, we could
/// see all the tournaments from the database that were added, but then it just showed a circular progress indicator
/// for a long time.
///

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register.dart';
import 'user_model.dart';
import 'volleymatic_model.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://thssqujpqkjapvwqfdal.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRoc3NxdWpwcWtqYXB2d3FmZGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIyNTg4NTYsImV4cCI6MjAyNzgzNDg1Nn0.HFtkIhXMrPTYkaFbSsJnssBCfJHKajNYUhQCtYrjZuQ',
  );
  final supabase = Supabase.instance.client; // opens a connection to Supabase

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => VolleymaticModel(supabase: supabase)),
      ChangeNotifierProvider(create: (_) => UserModel()),
    ], child: MaterialApp(home: WelcomePage())),
  );
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => Welcome();
}

class Welcome extends State<WelcomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    return Scaffold(
        body: Column(
      children: [
        _coloredBox(const Color.fromARGB(
            255, 251, 27, 11)), // creates a designed box effect
        _coloredBox(const Color.fromARGB(255, 251, 27, 11).withOpacity(0.75)),
        _coloredBox(const Color.fromARGB(255, 251, 27, 11).withOpacity(0.40)),
        Spacer(), // adds a space
        SizedBox(width: 90, height: 90, child: Image.asset('assets/logo.png')),
        SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(label: Text('Username')),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(label: Text('Password')),
            obscureText: true,
          ),
        ),

        SizedBox(height: 30),

        ElevatedButton(
            // creates an elevated button for login
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              dynamic loginValue = await userLogin(
                username: _usernameController.text,
                password: _passwordController.text,
              );
              setState(() {
                isLoading = false;
              });
              if (loginValue == 'success') {
                userModel.setUser(
                    _usernameController.text, _passwordController.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainApp()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(loginValue)),
                );
              }
            }, // goes to login on pressed

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(200, 50),
            ),
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.white, fontSize: 25), // sets login text
            )),
        SizedBox(height: 20),
        OutlinedButton(
            // creates an outlined button for use as guest
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationScreen()),
              );
            }, // runs main app when pressed
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size(200, 50)),
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    BorderSide(color: Colors.red), // set border color to red
              ),
            ),
            child: Text(
              'REGISTER',
              style: TextStyle(color: Colors.red, fontSize: 20),
            )),
        Spacer(), // adds a space
        _coloredBox(const Color.fromARGB(255, 251, 27, 11)
            .withOpacity(0.40)), // creates a designed box effect
        _coloredBox(const Color.fromARGB(255, 251, 27, 11).withOpacity(0.75)),
        _coloredBox(const Color.fromARGB(255, 251, 27, 11)),
      ],
    ));
  }

  /// returns a {Container} of the box from the color given
  Container _coloredBox(Color color) {
    return Container(
      // creates a box from a color
      height: 50,
      width: 450,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  Future<String> userLogin(
      {required String username, required String password}) async {
    final response = await Supabase.instance.client
        .from('users')
        .select()
        .eq('username', username)
        .single();

    if (response.isEmpty) {
      return 'Username not found';
    }

    final dbPassword = response['password'];

    if (dbPassword != password) {
      return 'Incorrect Password';
    }

    return 'success';
  }
}
