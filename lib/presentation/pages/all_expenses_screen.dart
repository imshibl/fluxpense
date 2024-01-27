// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/presentation/providers/expense_providers/add_expense_providers.dart';
import 'package:fluxpense/presentation/providers/expense_providers/all_expenses_provider.dart';
import 'package:fluxpense/presentation/widgets/expense_list.dart';
import 'package:fluxpense/utils/cap_first_letter.dart';

class AllExpensesScreen extends ConsumerWidget {
  const AllExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseTypeFilter = ref
        .watch(filterAllExpensesProvider); //to get expenses based on category

    return Scaffold(
      appBar: AppBar(
        title:
            Text("${capitalizeFirstLetter(expenseTypeFilter.name)} Expenses"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sort),
          ),
          //Filter By Category Icon
          IconButton(
            onPressed: () {
              //Dialog to Select Category to Filter
              showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer(builder: (context, ref, _) {
                      final expenseCategoryTypeFilter = ref.watch(
                          filterAllExpensesProvider); //to update selected category
                      return AlertDialog(
                        scrollable: true,
                        title: Text('Category Filter'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var category in ExpenseFilterType.values)
                              CheckboxListTile(
                                title: Text(category.name),
                                value: category.name ==
                                        expenseCategoryTypeFilter.name
                                    ? true
                                    : false,
                                onChanged: (value) {
                                  ref
                                      .read(filterAllExpensesProvider.notifier)
                                      .state = category;
                                },
                              ),
                          ],
                        ),
                      );
                    });
                  });
            },
            icon: Icon(Icons.filter_alt_outlined),
          )
        ],
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
                    categories: ref.read(categoryProvider),
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
