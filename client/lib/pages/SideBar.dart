import 'dart:io';

import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromRGBO(240, 240, 240, 1.0);
    Color myColor2 = const Color.fromRGBO(1, 1,1, 1.0);
    return Drawer(
      backgroundColor: myColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: myColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,

                    child: const Center(
                      child: Text(
                        'DECK2',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  tileColor: myColor,
                  leading: const Icon(Icons.space_dashboard_outlined,color: Colors.black,),
                  title: const Text('Dashboard',
                    style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Handle the click on the Home button
                  },
                ),
                ListTile(
                  tileColor: myColor,
                  leading: const Icon(Icons.message_outlined,color: Colors.black,),
                  title: const Text('Daily reports',
                    style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Handle the click on the Profile button
                  },
                ),
                ListTile(
                  tileColor: myColor,
                  leading: const Icon(Icons.restart_alt,color: Colors.black,),
                  title: const Text('Daily updates',
                    style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),),
                  onTap: () {
                    // Handle the click on the Settings button
                  },
                ),
                ListTile(
                  tileColor: myColor,
                  leading: const Icon(Icons.map_outlined,color: Colors.black,),
                  title: const Text('Sites',
                    style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),),
                  onTap: () {
                    // Handle the click on the Logout button
                  },
                ),
              ],
            ),
          ),

          ListTile(
            tileColor: myColor,
            leading: const Icon(Icons.logout,color: Colors.black,),
            title: const Text('Log out',
              style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),),
            onTap: () {
              // Handle the click on the Logout button
            },
          ),
        ],
      ),
    );
  }
}