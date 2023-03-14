import 'dart:io';

import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromRGBO(245, 245, 245, 1.0);
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: myColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("https://www.google.com/imgres?imgurl=https%3A%2F%2Fdeck1.com%2Fgraphics%2Fdeck1-01.svg&imgrefurl=https%3A%2F%2Fdeck1.dk%2F&tbnid=CwSYtpf-VgBTTM&vet=12ahUKEwie0szlwdv9AhWFtioKHVH0DfoQMygAegUIARDgAQ..i&docid=zo-aJGPaRKhy2M&w=800&h=380&q=deck1&ved=2ahUKEwie0szlwdv9AhWFtioKHVH0DfoQMygAegUIARDgAQ"),
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
                  title: const Text(
                      'Dashboard',
                      style: TextStyle(fontFamily:HttpHeaders.contentMD5Header ),),

                  onTap: () {
                    // Handle the click on the Home button
                  },
                ),
                ListTile(
                  title: const Text('Daily Reports',style: TextStyle(fontFamily:HttpHeaders.contentMD5Header ),),
                  onTap: () {
                    // Handle the click on the Search button
                  },
                ),
                ListTile(
                  title: const Text('Daily update'),
                  onTap: () {
                    // Handle the click on the Settings button
                  },
                ),
                ListTile(
                  title: const Text('Site'),
                  onTap: () {
                    // Handle the click on the About button
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              // Handle the click on the Logout button
            },
          ),
        ],
      ),
    );
  }
}
