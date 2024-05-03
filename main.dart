// ignore_for_file: prefer_const_constructors, dangling_library_doc_comments

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
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register.dart';
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

  runApp(ChangeNotifierProvider(
      // creates a change notifier provider for the volleymatic model so that it will change if notified
      create: (context) => VolleymaticModel(supabase: supabase),
      child: MaterialApp(home: WelcomePage())));
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => Welcome();
}

class Welcome extends State<WelcomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<String?> userLogin({
    required final String email,
    required final String password,
  }) async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user?.userMetadata;
    return response.user?.id;
  }

  Future<void> _nativeGoogleSignIn() async {
    const webClientId =
        '274468659133-4mljqvk66mfoame9t67j84t55atk5qrj.apps.googleusercontent.com';
    const androidClientId =
        '274468659133-4h08ic3rj7s51f1aer47fqqk6f321oa1.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: androidClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            controller: _emailController,
            decoration: const InputDecoration(label: Text('Email')),
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
                email: _emailController.text,
                password: _passwordController.text,
              );
              setState(() {
                isLoading = false;
              });
              if (loginValue != null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainApp()));
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
                MaterialPageRoute(builder: (context) => RegistrationScreen()),
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

        OutlinedButton(
            // creates an outlined button for use as guest
            onPressed: () {
              _nativeGoogleSignIn();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainApp()),
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
              'GOOGLE LOGIN',
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
}

