import 'package:client/classes/CardContent.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/rendering/box.dart';

import '../widgets/card_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _SidebarState();
}

class _SidebarState extends State<Dashboard> {
  String user = 'John Doe';
  String title = 'Airport Flight Officer';
  List<FlSpot> spots = [
    FlSpot(0,0),
    FlSpot(1,5),
    FlSpot(2,4),
    FlSpot(3,3),
    FlSpot(4,2),
    FlSpot(5,1),
  ];

  CardContent cardContent = CardContent(
      title: 'Dispatched flights',
      subtitle: '7',
      icon: Icons.airplanemode_active,
      onTap: () => print('test')
  );

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
                            style: TextStyle(fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            title,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container( // TODO: Make more beutiful
                    height: 100,
                    child: LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(enabled: false),
                          gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.grey,
                                strokeWidth: 1,
                              );
                            },
                            drawVerticalLine: true,
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: Colors.grey,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              axisNameWidget: Text("Bottom"),
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: defaultGetTitle,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              axisNameWidget: Text("Left"),
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: defaultGetTitle,
                              ),
                            ),
                          ),
                          minX: 0,
                          maxX: 20,
                          minY: 0,
                          maxY: 20,
                          lineBarsData: [
                            LineChartBarData(
                              show: true,
                              spots: spots,
                              color: Colors.green,
                              barWidth: 2,
                              isCurved: true,

                            ),
                          ]
                        ),



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
