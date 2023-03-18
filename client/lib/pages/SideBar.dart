import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromRGBO(240, 240, 240, 1.0);//background color
    double width = 35;//icon width
    double height = 35;//icon height
    return Drawer(
      backgroundColor: myColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            color: myColor,
            child: Center(
              child: Image.asset(
                "assets/deck1-logo.png",
                scale: 0.5,
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
                    height: height,
                    child: Image.asset("assets/Dashboard.png"),
                  ),
                  title: const Text(
                    'Dashboard',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Handle the click on the Home button
                  },
                ),
                ListTile(
                  tileColor: myColor,
                  leading: SizedBox(
                    width: width,
                    height: height,
                    child: Image.asset("assets/DailyReports.png"),
                  ),
                  title: const Text(
                    'Daily reports',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: (

                      ) {
                    // Handle the click on the Profile button
                  },
                ),
                ListTile(
                  tileColor: myColor,
                  leading: SizedBox(
                    width: width,
                    height: height,
                    child: Image.asset("assets/DailyUpdates.png"),
                  ),
                  title: const Text(
                    'Daily updates',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Handle the click on the Settings button
                  },
                ),
                ListTile(
                  tileColor: myColor,
                  leading: SizedBox(
                    width: width,
                    height: height,
                    child: Image.asset("assets/Sites.png"),
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
                    // Handle the click on the Logout button
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
              // Handle the click on the Logout button
            },
          ),
        ],
      ),
    );
  }
}
