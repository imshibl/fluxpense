import 'package:flutter/material.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/presentation/providers/expense_providers/add_expense_providers.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseEntity> expenses;
  final List<CategoryModel> categories;

  const ExpenseList(
      {super.key, required this.expenses, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/view-expense',
              arguments: expenses[index].id,
            );
          },
          leading: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: getCategoryColor(expenses[index].category, categories),
                shape: BoxShape.circle),
          ),
          title: Text(expenses[index].category),
          subtitle: Text(
              '${expenses[index].amount.toString()} - ${DateFormat.yMMMd().format(DateTime.parse(expenses[index].date))}'),
        );
      },
    );
  }

  Color getCategoryColor(String categoryName, List<CategoryModel> categories) {
    for (var category in categories) {
      if (category.name == categoryName) {
        return category.color;
      }
    }

    return Colors.grey;
  }
}
