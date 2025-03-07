import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileViewChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Profile View",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 5),
            const Text(
              "1024",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: _getBarGroups(), // Bar chart data
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 500),
                        FlSpot(1, 800),
                        FlSpot(2, 400),
                        FlSpot(3, 600),
                        FlSpot(4, 300),
                        FlSpot(5, 700),
                        FlSpot(6, 1000), // Highlighted point
                        FlSpot(7, 600),
                        FlSpot(8, 800),
                        FlSpot(9, 400),
                      ],
                      isCurved: true,
                      color: Colors.amber,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bar chart data
  List<BarChartGroupData> _getBarGroups() {
    return List.generate(10, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: index == 6 ? 1000 : (500 + (index % 4) * 150), // Highlight bar at index 6
            color: index == 6 ? Colors.amber : Colors.grey.withOpacity(0.3),
            width: 18,
          ),
        ],
      );
    });
  }
}
