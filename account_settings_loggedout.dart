import 'package:flutter/material.dart';
import 'volleymatic_model.dart';

class SettingsLogOut extends StatefulWidget {
  const SettingsLogOut({super.key, required VolleymaticModel model});

  @override
  State<SettingsLogOut> createState() => SettingsWidgetLogOut();
}

class SettingsWidgetLogOut extends State<SettingsLogOut> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Logout logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Delete account logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
                    ),
                    child: const Text(
                      'Create an Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
