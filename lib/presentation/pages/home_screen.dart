// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';

import 'package:fluxpense/presentation/providers/expense_providers/add_expense_providers.dart';
import 'package:fluxpense/presentation/providers/expense_providers/expense_chart_providers.dart';
import 'package:fluxpense/presentation/providers/expense_providers/get_overall_expense.dart';
import 'package:fluxpense/presentation/providers/expense_providers/recent_expenses_provider.dart';

import 'package:fluxpense/presentation/widgets/expense_line_chart.dart';
import 'package:fluxpense/presentation/widgets/expense_pie_chart.dart';

import '../widgets/expense_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<ExpenseEntity>> recentExpenses =
        ref.watch(recentExpensesProvider);
    AsyncValue<double> overAllExpenses = ref.watch(getOverallExpenseProvider);

    //CHART DATA PROVIDERS
    TimeFrameSortType timeFrameSorter = ref.watch(timeFrameSortTypeProvider);
    AsyncValue<List<ExpenseEntity>> expenseTimeFrame =
        ref.watch(getExpenseTimeFrameProvider);

    //CATRGORIES
    final categories = ref.read(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Fluxpense'), actions: [
        IconButton(
          onPressed: () {
            // Navigate to settings screen
            Navigator.of(context).pushNamed('/settings');
          },
          icon: Icon(
            Icons.settings,
          ),
        )
      ]),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                // SHOW EXPENSE SUMMARY & EXPENSE TIME FRAME
                child: Row(
                  children: [
                    Text(
                      'Expense Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    DropdownButton<TimeFrameSortType>(
                      underline: SizedBox(),
                      value: timeFrameSorter,
                      onChanged: (value) {
                        ref.read(timeFrameSortTypeProvider.notifier).state =
                            value!;
                      },
                      items: const [
                        DropdownMenuItem(
                          value: TimeFrameSortType.weekly,
                          child: Text("Weekly"),
                        ),
                        DropdownMenuItem(
                          value: TimeFrameSortType.monthly,
                          child: Text("Monthly"),
                        ),
                        DropdownMenuItem(
                          value: TimeFrameSortType.allTime,
                          child: Text("All Time"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SHOW EXPENSE CHART
              expenseTimeFrame.when(
                data: (expenses) {
                  if (expenses.isNotEmpty && expenses.length > 1) {
                    final Map<TimeFrameSortType, String> timeFrameMap = {
                      TimeFrameSortType.weekly: 'Weekly',
                      TimeFrameSortType.monthly: 'Monthly',
                      TimeFrameSortType.allTime: 'All Time',
                    };
                    return ExpenseLineChart(
                      expenses: expenses.reversed.toList(),
                      timeFrame: timeFrameMap[timeFrameSorter]!,
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      height: 150,
                      alignment: Alignment.center,
                      child: Text('No data available.'),
                    );
                  }
                },
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) =>
                    Text('Error fetching recent expenses: $error'),
              ),

              expenseTimeFrame.when(
                data: (expenses) {
                  if (expenses.isNotEmpty && expenses.length > 1) {
                    return PieChartWidget(
                        expenses: expenses, categories: categories);
                  } else {
                    return SizedBox();
                  }
                },
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) =>
                    Text('Error fetching recent expenses: $error'),
              ),
            ],
          ),

          // SHOW OVERALL EXPENSE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Overall Expense: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    overAllExpenses.when(
                      data: (expense) {
                        return Text(
                          expense.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        return Text("Error");
                      },
                      loading: () {
                        return Text("Loading");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          // SHOW RECENT EXPENSE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the screen to see all expenses
                        Navigator.pushNamed(context, '/all-expenses');
                      },
                      child: Text(
                        'Show all',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SHOW RECENT EXPENSE LIST (MAX 10)
              recentExpenses.when(
                data: (recentExpenses) {
                  if (recentExpenses.isNotEmpty) {
                    return ExpenseList(
                      expenses: recentExpenses,
                      categories: categories,
                    );
                  } else {
                    return Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Text('No recent transactions.'),
                    );
                  }
                },
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) =>
                    Text('Error fetching recent expenses: $error'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen to add a new expense
          Navigator.pushNamed(context, '/add-expense');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
