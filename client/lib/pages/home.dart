import 'package:client/pages/sites.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'stats.dart';
import 'dfrs.dart';
import 'flights.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State createState() => HomeB();
}

class HomeB extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        const Color.fromRGBO(34, 47, 62, 1.0); //background color
    Color backgroundColorSelected =
        const Color.fromRGBO(48, 63, 80, 1); //selected icon color
    double width = 35; //icon width

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Drawer(
            backgroundColor: backgroundColor,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/deck1Logo.png",
                        color: Colors.white,
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
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedIndex == 0
                                ? backgroundColorSelected
                                : backgroundColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            minLeadingWidth: -10,
                            tileColor: Colors.transparent,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // center the children of the Row
                              children: [
                                SizedBox(
                                    width: width,
                                    height: width,
                                    child: _selectedIndex == 0
                                        ? const Icon(Icons.local_airport,
                                            color: Colors.white, size: 32)
                                        : const Icon(
                                            Icons.local_airport,
                                            color: Color.fromRGBO(
                                                129, 132, 135, 1),
                                            size: 32,
                                          )),
                                const SizedBox(width: 10),
                                // add some spacing between the image and text
                                Text(
                                  'Flights',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        inherit: true,
                                        color: _selectedIndex == 0
                                            ? Colors.white
                                            : Color.fromRGBO(129, 132, 135, 1),
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
                      // Card(
                      //   shadowColor: Colors.transparent,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(
                      //         100), // set the desired border radius
                      //   ),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color:
                      //           _selectedIndex == 1 ? selectedColor : myColor,
                      //       borderRadius: BorderRadius.circular(15.0),
                      //     ),
                      //     child: ListTile(
                      //       minLeadingWidth: -10,
                      // tileColor: Colors.transparent,
                      //       title: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         // center the children of the Row
                      //         children: [
                      //           SizedBox(
                      //               width: width,
                      //               height: width,
                      //               child: _selectedIndex == 1
                      //                   ? Icon(Icons.description,
                      //                       color:
                      //                           Theme.of(context).primaryColor,
                      //                       size: 32)
                      //                   : const Icon(
                      //                       Icons.description,
                      //                       color: Color.fromRGBO(129, 132, 135, 1),
                      //                       size: 32,
                      //                     )),
                      //           const SizedBox(width: 10),
                      //           // add some spacing between the image and text
                      //           Text(
                      //             'DFRs',
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .displayLarge!
                      //                 .copyWith(
                      //                   inherit: true,
                      //                   color: _selectedIndex == 1
                      //                       ? Colors.white
                      //                       : Color.fromRGBO(129, 132, 135, 1),
                      //                 ),
                      //           ),
                      //         ],
                      //       ),
                      //       onTap: () {
                      //         setState(() {
                      //           _selectedIndex = 1;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // Card(
                      //   shadowColor: Colors.transparent,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(
                      //         100), // set the desired border radius
                      //   ),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color:
                      //           _selectedIndex == 2 ? selectedColor : myColor,
                      //       borderRadius: BorderRadius.circular(15.0),
                      //     ),
                      //     child: ListTile(
                      //       minLeadingWidth: -10,
                      // tileColor: Colors.transparent,
                      //       title: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         // center the children of the Row
                      //         children: [
                      //           SizedBox(
                      //               width: width,
                      //               height: width,
                      //               child: _selectedIndex == 2
                      //                   ? Icon(Icons.place,
                      //                       color:
                      //                           Theme.of(context).primaryColor,
                      //                       size: 32)
                      //                   : const Icon(
                      //                       Icons.place,
                      //                       color: Color.fromRGBO(129, 132, 135, 1),
                      //                       size: 32,
                      //                     )),
                      //           const SizedBox(width: 10),
                      //           // add some spacing between the image and text
                      //           Text(
                      //             'Sites',
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .displayLarge!
                      //                 .copyWith(
                      //                   inherit: true,
                      //                   color: _selectedIndex == 2
                      //                       ? Colors.white
                      //                       : Color.fromRGBO(129, 132, 135, 1),
                      //                 ),
                      //           ),
                      //         ],
                      //       ),
                      //       onTap: () {
                      //         setState(() {
                      //           _selectedIndex = 2;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Card(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100), // set the desired border radius
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedIndex == 3
                                ? backgroundColorSelected
                                : backgroundColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            minLeadingWidth: -10,
                            tileColor: Colors.transparent,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // center the children of the Row
                              children: [
                                SizedBox(
                                    width: width,
                                    height: width,
                                    child: _selectedIndex == 3
                                        ? const Icon(Icons.bar_chart,
                                            color: Colors.white, size: 32)
                                        : const Icon(
                                            Icons.bar_chart_outlined,
                                            color: Color.fromRGBO(
                                                129, 132, 135, 1),
                                            size: 32,
                                          )),
                                const SizedBox(width: 10),
                                // add some spacing between the image and text
                                Text(
                                  'Stats',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        inherit: true,
                                        color: _selectedIndex == 3
                                            ? Colors.white
                                            : Color.fromRGBO(129, 132, 135, 1),
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
                // ListTile(
                // tileColor: Colors.transparent,
                //   leading: const Icon(
                //     Icons.logout,
                //     color: Color.fromRGBO(129, 132, 135, 1),
                //     size: 32,
                //   ),
                //   title: Text('Log out',
                //       style: Theme.of(context).textTheme.displayLarge),
                //   onTap: () {},
                // ),
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
