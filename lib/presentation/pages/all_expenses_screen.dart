// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/presentation/providers/expense_providers/add_expense_providers.dart';
import 'package:fluxpense/presentation/providers/expense_providers/all_expenses_provider.dart';
import 'package:fluxpense/presentation/widgets/expense_list.dart';

class AllExpensesScreen extends ConsumerWidget {
  const AllExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.read(categoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Expenses'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final allExpensesAsyncValue = ref.watch(allExpensesProvider);

          //LIST ALL EXPENSES
          return allExpensesAsyncValue.when(
            data: (expenses) {
              if (expenses.isEmpty) {
                return Center(child: Text('No expenses found'));
              }
              return ListView(
                children: [
                  ExpenseList(
                    expenses: expenses,
                    categories: categories,
                  ),
                ],
              );
            },
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) =>
                Text('Error fetching expenses: $error'),
          );
        },
      ),
    );
  }
}
