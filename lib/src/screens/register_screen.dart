import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.grey,
      colorScheme: ColorScheme.dark().copyWith(secondary: Colors.grey[600]),
      scaffoldBackgroundColor: Colors.grey[900],
      textTheme: ThemeData.dark().textTheme.copyWith(
        bodyText1: TextStyle(fontFamily: 'Montserrat'),
        bodyText2: TextStyle(fontFamily: 'Montserrat'),
        headline6: TextStyle(fontFamily: 'Montserrat'),
      ),
    );

    return Theme(
      data: _darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register', style: TextStyle(fontFamily: 'Montserrat')),
          backgroundColor: Colors.grey[900],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  style: TextStyle(fontFamily: 'Montserrat'),
                  controller: _usernameController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(fontFamily: 'Montserrat'),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontFamily: 'Montserrat'),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[800],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                  child: Text('Register', style: TextStyle(fontFamily: 'Montserrat')),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<Auth>(context, listen: false).register(
                        _usernameController.text,
                        _passwordController.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
