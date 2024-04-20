import 'package:flutter/material.dart';
import 'main_app.dart';
import 'login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _threeBarDesign(),
        SizedBox(
          width: 70,
          height: 70,
          child: Image.asset('assets/logo.png'),
        ),
        const Text('WELCOME!'),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()), // Navigate to Login screen
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainApp()), // Navigate to MainApp screen
            );
          },
          style: ButtonStyle(
            side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(color: Colors.red),
            ),
          ),
          child: const Text(
            'Continue as Guest',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Row _threeBarDesign() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100.0,
          width: 2.0,
          color: const Color.fromARGB(255, 118, 6, 6),
        ),
        Container(
          height: 80.0,
          width: 2.0,
          color: const Color.fromARGB(255, 165, 8, 8),
        ),
        Container(
          height: 60.0,
          width: 2.0,
          color: const Color.fromARGB(255, 236, 8, 8),
        ),
      ],
    );
  }
}
