import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class Auth with ChangeNotifier {
  User? _user;

  User get user {
    return _user!;
  }

  Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.http('localhost:5001', 'api/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('Response data: ${response.headers}');
      _user = User.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      print(response.statusCode);
      throw Exception('Failed to register.');
    }
  }

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.http('localhost:5001', 'api/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      _user = User.fromJson(jsonDecode(response.body));
      // Return true for successful login
      return true;
    } else {
      // Return false for unsuccessful login
      print(response.statusCode);
      return false;
    }
  }

  Future<void> updateUsername(String newUsername) async {
    if (_user != null) {
      print(user!.id + newUsername);
      final response = await http.post(
        Uri.parse('http://localhost:5000/updateUsername'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': _user!.id,
          'username': newUsername,
        }),
      );

      if (response.statusCode == 200) {
        _user = User.fromJson(jsonDecode(response.body));
        notifyListeners();
      } else {
        throw Exception('Failed to update username.');
      }
    }
  }
}
