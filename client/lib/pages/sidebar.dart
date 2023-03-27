import 'package:client/pages/home.dart';
import 'package:client/pages/noHome.dart';
import 'package:client/pages/notimplemented.dart';
import 'package:flutter/material.dart';

import 'stats.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromRGBO(240, 240, 240, 1.0); //background color
    double width = 40; //icon width
    return Drawer(
      backgroundColor: myColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: myColor,
            child: Center(
              child: Image.asset(
                "assets/deck1Logo.png",
                scale: 0.8,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  tileColor: myColor,
                  leading: SizedBox(
                    width: width,
                    height: width,
                    child: Image.asset("assets/dailyReports.png"),
                  ),
                  title: const Text(
                    'Flights',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NoHome()),
                    );
                  },
                ),
                ListTile(
                  tileColor: myColor,
                  leading: SizedBox(
                    width: width,
                    height: width,
                    child: Image.asset("assets/dailyUpdates.png"),
                  ),
                  title: const Text(
                    'DFRs',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NoHome()),
                    );
                    //change page
                    // Handle the click on the Settings button
                  },
                ),
                ListTile(
                  tileColor: myColor,
                  leading: SizedBox(
                    width: width,
                    height: width,
                    child: Image.asset("assets/sites.png"),
                  ),
                  title: const Text(
                    'Sites',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NoHome()),
                    );
                    // Handle the click on the Logout button
                  },
                ),
                ListTile(
                  hoverColor: Colors.blue,
                  tileColor: myColor,
                  leading: SizedBox(
                    width: width,
                    height: width,
                    child: Image.asset("assets/dashboard.png"),
                  ),
                  title: const Text(
                    'Stats',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            tileColor: myColor,
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: const Text(
              'Log out',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoHome()),
              );
            },
          ),
        ],
      ),
    );
  }


}
