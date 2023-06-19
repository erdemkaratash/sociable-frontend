import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socialize_backend/src/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String api_url = dotenv.env['API_URL']!;

class SearchProvider {
  Future<List<User>> searchUser(String username) async {
    final response = await http.get(
      Uri.http(api_url, '/search', {'username': username}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      var jsonResponse = jsonDecode(response.body);
      List<User> users = [];
      for (var user in jsonResponse) {
        users.add(User.fromJson(user));
      }
      return users;
    } else {
      // If the server returns an unexpected response,
      // then throw an exception.
      throw Exception('Failed to search user.');
    }
  }
}
