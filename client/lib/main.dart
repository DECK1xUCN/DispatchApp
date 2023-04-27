import 'package:client/pages/dailyUpdateForm.dart';
import 'package:client/pages/flightForm.dart';
import 'package:client/pages/loading.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://api.deck1.sk/',
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(GraphQLProvider(
      client: client,
      child: MaterialApp(
          title: 'Deck1 Dispatch App',
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            primaryColor: const Color.fromRGBO(9, 166, 215, 1),
            colorScheme: const ColorScheme.dark(
              primary: Color.fromRGBO(9, 166, 215, 1),
              secondary: Color.fromRGBO(89, 178, 102, 1),
              error: Color.fromRGBO(252, 129, 129, 1),
            ),
            fontFamily: 'Lato',
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontSize: 36.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(28, 28, 28, 1)),
              titleLarge: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(28, 28, 28, 1)),
              bodyLarge: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(28, 28, 28, 1),
                  fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Lato',
                  color: Color.fromRGBO(28, 28, 28, 1)),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const Loading(),
            '/home': (context) => const Home(),
            '/flightform': (context) => const FlightForm(),
            '/dailyUpdateForm': (context) => const DailyUpdateForm(),
          })));
}
