import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _username = '';
  String _password = '';

  String get username => _username;
  String get password => _password;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setUser(String username, String password) {
    _username = username;
    _password = password;
    notifyListeners();
  }

  void clearUser() {
    _username = '';
    _password = '';
    notifyListeners();
  }
}
