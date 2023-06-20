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


    print(response.statusCode.runtimeType);
    if (response.statusCode < 400) {
      print(response.body);
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
        print(_user!.id + newUsername);
        print(_user!.token);

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

        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          print(response.body);
          _user = User.fromJson(jsonDecode(response.body));
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
}
