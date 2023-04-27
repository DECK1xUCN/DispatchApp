import 'package:client/pages/sites.dart';

import 'package:flutter/material.dart';

import 'stats.dart';
import 'dfrs.dart';
import 'flights.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State createState() => SidebarB();
}

class SidebarB extends State<Sidebar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromRGBO(240, 240, 240, 1.0); //background color
    Color selectedColor =
        const Color.fromRGBO(50, 50, 50, 1.0); //selected icon color
    double width = 35; //icon width

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Drawer(
            backgroundColor: myColor,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: myColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/deck1Logo.png",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Card(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100), // set the desired border radius
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                _selectedIndex == 0 ? selectedColor : myColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            minLeadingWidth: -10,
                            tileColor: myColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // center the children of the Row
                              children: [
                                SizedBox(
                                  width: width,
                                  height: width,
                                  child: _selectedIndex == 0
                                      ? Image.asset(
                                          "assets/dailyUpdatesSelected.png") // show selected icon
                                      : Image.asset("assets/dailyUpdates.png"),
                                ),
                                const SizedBox(width: 10),
                                // add some spacing between the image and text
                                Text('Flights',
                                    style:
                                        Theme.of(context).textTheme.displayLarge!.copyWith(
                                          inherit: true,
                                          color: _selectedIndex == 0
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 0;
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100), // set the desired border radius
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                _selectedIndex == 1 ? selectedColor : myColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            minLeadingWidth: -10,
                            tileColor: myColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // center the children of the Row
                              children: [
                                SizedBox(
                                  width: width,
                                  height: width,
                                  child: _selectedIndex == 1
                                      ? Image.asset(
                                          "assets/dailyReportsSelected.png") // show selected icon
                                      : Image.asset("assets/dailyReports.png"),
                                ),
                                const SizedBox(width: 10),
                                // add some spacing between the image and text
                                Text(
                                  'DFRs',
                                  style:
                                  Theme.of(context).textTheme.displayLarge!.copyWith(
                                    inherit: true,
                                    color: _selectedIndex == 1
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100), // set the desired border radius
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                _selectedIndex == 2 ? selectedColor : myColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            minLeadingWidth: -10,
                            tileColor: myColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // center the children of the Row
                              children: [
                                SizedBox(
                                  width: width,
                                  height: width,
                                  child: _selectedIndex == 2
                                      ? Image.asset(
                                          "assets/sitesSelected.png") // show selected icon
                                      : Image.asset("assets/sites.png"),
                                ),
                                const SizedBox(width: 10),
                                // add some spacing between the image and text
                                Text(
                                  'Sites',
                                  style:
                                  Theme.of(context).textTheme.displayLarge!.copyWith(
                                    inherit: true,
                                    color: _selectedIndex == 2
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 2;
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100), // set the desired border radius
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                _selectedIndex == 3 ? selectedColor : myColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            minLeadingWidth: -10,
                            tileColor: myColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // center the children of the Row
                              children: [
                                SizedBox(
                                  width: width,
                                  height: width,
                                  child: _selectedIndex == 3
                                      ? Image.asset(
                                          "assets/dashboardSelected.png") // show selected icon
                                      : Image.asset("assets/dashboard.png"),
                                ),
                                const SizedBox(width: 10),
                                // add some spacing between the image and text
                                Text(
                                  'Stats',
                                  style:
                                  Theme.of(context).textTheme.displayLarge!.copyWith(
                                    inherit: true,
                                    color: _selectedIndex == 3
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 3;
                              });
                            },
                          ),
                        ),
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
                  title: Text(
                    'Log out',
                    style: Theme.of(context).textTheme.displayLarge
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const <Widget>[
                Flights(),
                DFRs(),
                Sites(),
                Stats(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
