import 'package:client/classes/CardContent.dart';
import 'package:flutter/material.dart';

import '../widgets/card_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _SidebarState();
}

class _SidebarState extends State<Dashboard> {
  String user = 'John Doe';
  String title = 'Airport Flight Officer';

  CardContent cardContent = CardContent(
      title: 'Dispatched flights',
      subtitle: '7',
      icon: Icons.airplanemode_active);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Welcome, $user",
                            style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            title,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                    child: Text(
                        'Graph',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const Text(
                    'Today',
                    style: TextStyle(fontSize: 35, color: Colors.black),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardWidget(cardContent: cardContent),
                          CardWidget(cardContent: cardContent),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardWidget(cardContent: cardContent),
                          CardWidget(cardContent: cardContent),
                        ],
                      )
                    ],
                  ))
                ],
              ))),
    );
  }
}
