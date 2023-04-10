import 'dart:math';

import 'package:client/classes/CardContent.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/card_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _SidebarState();
}

class _SidebarState extends State<Dashboard> {
  String user = 'John Doe';
  String title = 'Airport Flight Officer';
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  CardContent cardContent = CardContent(
      title: 'Dispatched flights',
      subtitle: '7',
      icon: Icons.airplanemode_active,
      onTap: () => {});

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Color(0xff72719b), fontWeight: FontWeight.w400, fontSize: 16);

    Widget text = const Text('');
    for (int i = 1; i < 32; i++) {
      if (value == i) {
        text = Text('$i', style: style);
      }
    }

    return SideTitleWidget(axisSide: meta.axisSide, space: 5, child: text);
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: bottomTitleWidgets,
        interval: 1,
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
                            style: const TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 3.5,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: dummyData1,
                            isCurved: true,
                            dotData: FlDotData(
                              show: false,
                            ),
                          ),
                        ],
                        borderData: FlBorderData(
                            border: const Border(
                                bottom: BorderSide(), left: BorderSide())),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: _bottomTitles,
                          ),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: true,
                          )),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
                        ),
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
