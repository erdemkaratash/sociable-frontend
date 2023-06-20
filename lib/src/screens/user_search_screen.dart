import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
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
          .findUser(enteredUsername);
      setState(() {});
    } catch (error) {
      print('Failed to search user: $error');
    }
  }

  void _showUserProfile(User user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: ClipOval(
          child: FittedBox(
            child: Image.asset('assets/avatar.jpg', width: 50, height: 50),
            fit: BoxFit.cover,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(user.username, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Poke'),
              onPressed: () {},
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
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
                    _showUserProfile(_searchResult!);
                  },
                )
              : Container()
        ],
      ),
    );
  }
}
