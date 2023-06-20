import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _newUsernameController.text = Provider.of<Auth>(context).user.username;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _newUsernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontFamily: 'Montserrat'),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(fontFamily: 'Montserrat'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Update Username',
                        style: TextStyle(fontFamily: 'Montserrat')),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool success =
                            await Provider.of<Auth>(context, listen: false)
                                .updateUsername(_newUsernameController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success
                                ? 'Update successful'
                                : 'Update failed'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[800],
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
