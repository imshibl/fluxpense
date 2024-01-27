// PieChartWidget.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';

import 'package:fluxpense/presentation/providers/expense_providers/add_expense_providers.dart';

class PieChartWidget extends StatelessWidget {
  final List<ExpenseEntity> expenses;

  final List<CategoryModel>
      categories; //Get using Expense Category List Provider

  const PieChartWidget(
      {super.key, required this.expenses, required this.categories});

  //Get Expense based on Category
  Map<String, double> getCategoryExpenses(List<ExpenseEntity> expenses) {
    Map<String, double> categoryExpenses = {};
    for (var expense in expenses) {
      final category = expense.category;
      categoryExpenses[category] =
          (categoryExpenses[category] ?? 0) + expense.amount;
    }
    return categoryExpenses;
  }

  //Get Category Color Based on Category Name
  Color getCategoryColor(String categoryName) {
    for (var category in categories) {
      if (category.name == categoryName) {
        return category.color;
      }
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> categoryExpenses = getCategoryExpenses(expenses);

    return AspectRatio(
      aspectRatio: 1.8,
      child: PieChart(
        PieChartData(
          sections: categoryExpenses.entries
              .map(
                (entry) => PieChartSectionData(
                  value: entry.value,
                  title: "${entry.key}\n${entry.value.toStringAsFixed(1)}",
                  color: getCategoryColor(entry.key),
                  radius: 50,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
              .toList(),
          sectionsSpace: 0,
          centerSpaceRadius: 30,
          startDegreeOffset: -90,
        ),
      ),
    );
  }
}
