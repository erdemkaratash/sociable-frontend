import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String api_url = dotenv.env['API_URL']!;

class Auth with ChangeNotifier {
  User? _user;

  User get user {
    return _user!;
  }

  Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.http(api_url, 'api/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print(response.body);
      // Return true for successful login
      return true;
    } else {
      // Return false for unsuccessful login
      print(response.statusCode);
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.http(api_url, 'api/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      _user = User.fromJson(jsonDecode(response.body));
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  Future<bool> updateUsername(String newUsername) async {
    if (_user != null) {
      try {
        final response = await http.put(
          Uri.http(api_url, 'api/user/update'),
          headers: {
            HttpHeaders.authorizationHeader: _user!.token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': newUsername,
          }),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> updatedUserJson = jsonDecode(response.body);
          // Create a new User object with the updated fields, but keep the original token.
          _user = User(
            id: updatedUserJson['_id'],
            username: updatedUserJson['username'],
            token: _user!.token,
          );
          notifyListeners();
          return true;
        } else {
          print(response.statusCode);
          return false;
        }
      } catch (error) {
        print('An error occurred: $error');
        return false;
      }
    }
    return false; // Default return value
  }

  Future<User?> findUser(String username) async {
    try {
      final response = await http.get(
        Uri.http(api_url, '/api/user/findUser', {'username': username}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // Add authorization headers if required
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('_id')) {
          return User(
            id: jsonResponse['_id'],
            username: jsonResponse['username'],
            token: '', //Not needed for now.
          );
        } else {
          print("User not found");
          return null;
        }
      } else {
        print("Error retrieving user. Status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print('An error occurred: $error');
      return null;
    }
  }
}
