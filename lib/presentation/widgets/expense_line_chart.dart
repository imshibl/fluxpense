// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';

class ExpenseLineChart extends StatelessWidget {
  final List<ExpenseEntity> expenses;
  final String timeFrame;

  const ExpenseLineChart(
      {super.key, required this.expenses, required this.timeFrame});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //LINE CHART
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          height: 150,
          child: LineChart(
            LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(
                  border: Border.all(color: const Color(0xff37434d), width: 1),
                ),
                minX: 0,
                maxX: expenses.length.toDouble() - 1,
                minY: 0,
                maxY: _getMaxExpenseValue(),
                lineBarsData: [
                  _getLineChartBarData(expenses),
                ],
                lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                        fitInsideVertically: true,
                        fitInsideHorizontally: true,
                        tooltipRoundedRadius: 8,
                        getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                          return lineBarsSpot.map((lineBarSpot) {
                            return LineTooltipItem(
                              lineBarSpot.y.toInt().toString(),
                              const TextStyle(color: Colors.white),
                            );
                          }).toList();
                        }))),
          ),
        ),
        //Show overall expense based on Time Frame(weekly, monthly, all time)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$timeFrame Expense: "),
            Text(
              "${_getExpenseSum(expenses)}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  int _getExpenseSum(List<ExpenseEntity> expenses) {
    int sum = 0;
    for (var expense in expenses) {
      sum += expense.amount.toInt();
    }
    return sum;
  }

  LineChartBarData _getLineChartBarData(List<ExpenseEntity> expenses) {
    List<FlSpot> spots = [];

    for (int i = 0; i < expenses.length; i++) {
      double x = i.toDouble();
      double y = expenses[i].amount;
      spots.add(FlSpot(x, y));
    }

    return LineChartBarData(
      preventCurveOverShooting: true,
      spots: spots,
      isCurved: true,
      color: Colors.blue,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        spotsLine: const BarAreaSpotsLine(
          flLineStyle: FlLine(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  double _getMaxExpenseValue() {
    if (expenses.isEmpty) return 0;
    return expenses
        .map((e) => e.amount)
        .reduce((value, element) => value > element ? value : element);
  }
}
