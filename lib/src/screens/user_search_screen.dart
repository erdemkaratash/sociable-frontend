import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/auth.dart';

class UserSearchScreen extends StatefulWidget {
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<User> _users = [];

  void _searchUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        List<User> users = await Provider.of<Auth>(context, listen: false)
            .searchUser(_usernameController.text);
        setState(() {
          _users = users;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username.';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              child: Text('Search'),
              onPressed: _searchUser,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (ctx, index) => ListTile(
                  title: Text(_users[index].username),
                  // Add more details of users as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
