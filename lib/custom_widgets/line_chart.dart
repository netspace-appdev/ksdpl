import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../common/helper.dart';
class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false), // Hide grid lines
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 25,
              getTitlesWidget: (value, meta) {
                List<String> months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
                return Text(
                  months[value.toInt()],
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                );
              },
              interval: 1,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false), // Hide border
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 2000,
        lineBarsData: [
          buildLineData(Colors.pink, [800, 1200, 1500, 1000, 1600, 1400, 700, 900, 1100, 500, 600, 400]), // Pink line
          buildLineData(Colors.teal, [500, 800, 1200, 1400, 1000, 900, 500, 600, 700, 1000, 1100, 1300]), // Teal line
          buildLineData(Colors.black, [700, 900, 1000, 1300, 1100, 600, 500, 400, 800, 1200, 1500, 1700]), // Black line
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.indigo,
            tooltipRoundedRadius: 10,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  spot.y.toStringAsFixed(1),
                  const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
          touchCallback: (event, response) {},
          handleBuiltInTouches: true,
          getTouchedSpotIndicator: (barData, indicators) {
            return indicators.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(color: barData.color, strokeWidth: 3),
                FlDotData(show: true, getDotPainter: (spot, percent, bar, index) {
                  return FlDotCirclePainter(
                    radius: 5,
                    color:AppColor.primaryColor,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                }),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  // Function to create a line graph with smooth curves
  LineChartBarData buildLineData(Color color, List<double> data) {
    return LineChartBarData(
      spots: List.generate(data.length, (index) => FlSpot(index.toDouble(), data[index])),
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );
  }
}

// Legend Widget
class Legend1 extends StatelessWidget {
  final Color color;
  final String text;

  const Legend1({Key? key, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 15, height: 15, decoration: BoxDecoration(color: color, )),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 14, fontWeight:FontWeight.w400)),
        const SizedBox(width: 15),
      ],
    );
  }
}