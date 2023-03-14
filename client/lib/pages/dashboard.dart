import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _SidebarState();
}

class _SidebarState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  SizedBox(
                    height: 50,
                    child: Text('Title'),
                  ),
                  SizedBox(
                    height: 200,
                    child: Text('Graph'),
                  ),
                  Expanded(
                    child: Text('Buttons'),
                  )
                ],
            )
        )
      ),
    );
  }
}
