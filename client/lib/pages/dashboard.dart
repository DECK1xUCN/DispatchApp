import 'package:client/classes/CardContent.dart';
import 'package:flutter/material.dart';

import '../widgets/card_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _SidebarState();
}

class _SidebarState extends State<Dashboard> {
  CardContent cardContent = CardContent(
      title: 'Title 1',
      subtitle: 'Subtitle 1',
      icon: 'Icon 1'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welocme, User', // replace once backend is functional
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                    child: Text('Graph'),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardWidget(cardContent: cardContent),
                            CardWidget(cardContent: cardContent),
                          ],
                        ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardWidget(cardContent: cardContent),
                            CardWidget(cardContent: cardContent),
                          ],
                        )
                      ],
                    )
                  )
                ],
            )
        )
      ),
    );
  }
}
