// Bar Chart Container
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildBarChart(List<String> departmentNames, List<double> completed,
    List<double> ongoing) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(15),
    decoration: _boxDecoration(),
    child: SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          titlesData: _buildFlTitlesData(departmentNames),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            horizontalInterval: 1000, // Interval for dollars
            getDrawingHorizontalLine: (value) => FlLine(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.3),
              strokeWidth: 1.5,
              dashArray: [5, 5], // Dotted lines
            ),
          ),
          barGroups: _getBarGroups(completed, ongoing),
        ),
      ),
    ),
  );
}

// Titles for Bar Chart X and Y axis
FlTitlesData _buildFlTitlesData(List<String> departmentNames) {
  return FlTitlesData(
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1000,
        getTitlesWidget: (value, meta) {
          return Text(
            '\$${value.toInt()}',
            style: const TextStyle(fontSize: 12, color: Colors.black),
          );
        },
        reservedSize: 50,
      ),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (double value, TitleMeta meta) {
          if (value.toInt() < departmentNames.length) {
            return Text(
              departmentNames[value.toInt()],
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            );
          }
          return Container();
        },
        reservedSize: 30, // Increased reserved space for more spacing
      ),
    ),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}

// Bar Chart Data
List<BarChartGroupData> _getBarGroups(
    List<double> completed, List<double> ongoing) {
  return List.generate(completed.length, (index) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
            toY: completed[index],
            color: Color(0xFF2A4FA1),
            width: 10,
            borderRadius: BorderRadius.circular(4)),
        BarChartRodData(
            toY: ongoing[index],
            color: Color(0xffffce93),
            width: 10,
            borderRadius: BorderRadius.circular(4)),
      ],
      barsSpace: 5, // Spacing between bars
    );
  });
}

// Box Decoration for Containers
BoxDecoration _boxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 2,
          offset: const Offset(0, 4)),
    ],
  );
}
