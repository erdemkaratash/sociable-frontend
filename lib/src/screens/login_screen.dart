import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialize_backend/src/providers/auth.dart';
import 'package:socialize_backend/src/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _username = '';
  String _password = '';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      final bool isLoginSuccessful = await Provider.of<Auth>(context, listen: false).login(_username, _password);

      if (isLoginSuccessful) {
        Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed!'),
          ),
        );
      }
    } catch (error) {
      var errorMessage = 'Could not authenticate you. Please try again later.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

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
          title: Text('Login', style: TextStyle(fontFamily: 'Montserrat')),
          backgroundColor: Colors.grey[900],
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
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
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontFamily: 'Montserrat'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username = value!;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
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
                          style: TextStyle(fontFamily: 'Montserrat'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          child: Text('Login', style: TextStyle(fontFamily: 'Montserrat')),
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[800],
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
