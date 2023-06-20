import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'package:socialize_backend/src/screens/profile_screen.dart';
import 'package:socialize_backend/src/models/user.dart';

class UserSearch extends StatefulWidget {
  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final _searchController = TextEditingController();
  User? _searchResult;

  void _searchUser() async {
    final enteredUsername = _searchController.text;
    try {
      _searchResult = await Provider.of<Auth>(context, listen: false)
          .findUser(enteredUsername); // Call findUser from auth.dart
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
          _searchResult != null
              ? ListTile(
                  title: Text(_searchResult!.username),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            ProfileScreen(username: _searchResult!.username),
                      ),
                    );
                  },
                )
              : Container()
        ],
      ),
    );
  }
}
