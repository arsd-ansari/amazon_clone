import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const AuthScreen());
    default:
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Wrong Route'),
                ),
              ));
  }
}
