import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volleymatic/main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => Register();
}

class Register extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> createUser({
    required final String email,
    required final String password,
  }) async {
    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );
    final error = response.user?.createdAt;
    if (error == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(), // adds a space
          SizedBox(
              width: 90, height: 90, child: Image.asset('assets/logo.png')),
          const SizedBox(height: 30),

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

          const SizedBox(height: 30),

          ElevatedButton(
              // creates an elevated button for login
              onPressed: () async {
                final userValue = await createUser(
                    email: _emailController.text,
                    password: _passwordController.text);
                if (userValue == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomePage()));
                }
              }, // goes to login on pressed

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                    color: Colors.white, fontSize: 25), // sets login text
              )),
        ])));
  }
}
