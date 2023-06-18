import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/register_screen.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/main_screen.dart';
import 'src/screens/user_search_screen.dart';
import 'src/screens/edit_profile_screen.dart';
import 'src/providers/auth.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          MainScreen.routeName: (ctx) => MainScreen(),
          EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
        },
      ),
    );
  }
}
