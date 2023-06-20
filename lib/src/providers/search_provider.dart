import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socialize_backend/src/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String api_url = dotenv.env['API_URL']!;

class SearchProvider {
  Future<List<User>> searchUser(String username) async {
    final response = await http.get(
      Uri.http(api_url, '/api/user/findUser', {'username': username}),
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

  

// Add this method within your Auth class.

Future<User?> findUser(String username) async {
  try {
    final response = await http.get(
      Uri.http(api_url, 'api/user/findUser', {'username': username}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // Add authorization headers if required
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('_id')) {
        // Assuming token is not provided, you can set it to an empty string
        // or handle it appropriately based on your use case.
        return User(
          id: jsonResponse['_id'],
          username: jsonResponse['username'],
          token: '',
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
