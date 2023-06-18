import 'package:flutter/material.dart';
import 'package:socialize_backend/src/providers/search_provider.dart';
import 'package:socialize_backend/src/screens/profile_screen.dart';
import 'package:socialize_backend/src/models/user.dart';

class UserSearch extends StatefulWidget {
  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final _searchController = TextEditingController();
  List<User> _searchResults = [];

  void _searchUser() async {
    final enteredUsername = _searchController.text;
    try {
      _searchResults = await SearchProvider().searchUser(enteredUsername);
      setState(() {});
    } catch (error) {
      print('Failed to search user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onSubmitted: (_) => _searchUser(),
              decoration: InputDecoration(
                labelText: 'Search Username',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchUser,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(_searchResults[i].username),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(username: _searchResults[i].username),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
