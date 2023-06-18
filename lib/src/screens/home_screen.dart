import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

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

    return MaterialApp(
      theme: _darkTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          elevation: 0, // remove shadow
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0),
              Image.asset(
                'assets/logo.png',
                height: 100.0,
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800], // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
                child: Text('Register', style: TextStyle(fontFamily: 'Montserrat')),
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterScreen.routeName);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800], // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
                child: Text('Login', style: TextStyle(fontFamily: 'Montserrat')),
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
