import 'package:client/pages/loading.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/flights.dart';

void main() => runApp(MaterialApp(
        title: 'Deck1 Dispatch App',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          
          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default `decoration` for the Input fields
          inputDecorationTheme: const InputDecorationTheme( // TODO: Further designing choices are needed
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintStyle: TextStyle(fontFamily: 'Hind', color: Colors.black),

          ),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            displayLarge:
                TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.black),
          ),
        ),


        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Home(),
          '/flights': (context) => Flights(),
        }));
