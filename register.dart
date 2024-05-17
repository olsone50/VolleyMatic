import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => Register();
}

class Register extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _coloredBox(const Color.fromARGB(
            255, 251, 27, 11)), // creates a designed box effect
        _coloredBox(const Color.fromARGB(255, 251, 27, 11).withOpacity(0.75)),
        _coloredBox(const Color.fromARGB(255, 251, 27, 11).withOpacity(0.40)),
        const Spacer(), // adds a space
        SizedBox(width: 90, height: 90, child: Image.asset('assets/logo.png')),
        const SizedBox(height: 30),

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

        const SizedBox(height: 30),

        ElevatedButton(
            // creates an elevated button for registration
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              final username = _usernameController.text;
              final password = _passwordController.text;

              if (username.isNotEmpty && password.isNotEmpty) {
                final response = await Supabase.instance.client
                    .from('users')
                    .select('username')
                    .eq('username', username);

                final List<dynamic> users = response ?? [];
                if (users.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Username is already taken')),
                  );
                } else if (_validatePassword(password)) {
                  createUser(username: username, password: password);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Password should be at least 7 characters long and contain at least one number and one capital letter')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
              }

              setState(() {
                isLoading = false;
              });
            }, // goes to welcome on pressed

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(200, 50),
            ),
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : const Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: Colors.white, fontSize: 25), // sets sign up text
                  )),
        const SizedBox(height: 20),
        OutlinedButton(
            // creates an outlined button for returning to welcome
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            }, // goes back to welcome page when pressed
            style: ButtonStyle(
              minimumSize: const MaterialStatePropertyAll(Size(200, 50)),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(
                    color: Colors.red), // set border color to red
              ),
            ),
            child: const Text(
              'BACK',
              style: TextStyle(color: Colors.red, fontSize: 20),
            )),
        const Spacer(), // adds a space
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

  Future<bool> createUser(
      {required String username, required String password}) async {
    final response = await Supabase.instance.client.from('users').insert(
        {'username': username, 'password': password, 'is_admin': false});

    if (response.error != null) {
      print('Error inserting user: ${response.error!.message}');
      return false;
    } else {
      return true;
    }
  }

  bool _validatePassword(String password) {
    if (password.length < 7) return false;
    if (!password.contains(RegExp(r'\d'))) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    return true;
  }
}
