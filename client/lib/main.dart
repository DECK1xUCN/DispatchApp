import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() => runApp(MaterialApp(
    title: 'Deck1 Dispatch App',
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],

      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
    initialRoute: '/home',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
    }
));

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Loading');
  }
}



