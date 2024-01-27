// ignore_for_file: prefer_const_constructors, unused_result

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';

import 'package:fluxpense/presentation/providers/expense_providers/add_expense_providers.dart';
import 'package:fluxpense/presentation/providers/expense_providers/all_expenses_provider.dart';
import 'package:fluxpense/presentation/providers/expense_providers/expense_chart_providers.dart';
import 'package:fluxpense/presentation/providers/expense_providers/get_overall_expense.dart';
import 'package:fluxpense/presentation/providers/expense_providers/recent_expenses_provider.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  late String selectedCategory;

  //Select Date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  //Add expense
  Future<void> _addExpense() async {
    final addExpense = ref.read(addExpenseProvider);

    double amount = double.parse(amountController.text);
    String description = descriptionController.text;

    ExpenseEntity expense = ExpenseEntity(
      amount: amount,
      description: description,
      date: selectedDate.toLocal().toString(),
      category: selectedCategory,
    );

    await addExpense(expense).whenComplete(() {
      //refresh the providers to update changes data in UI
      ref.refresh(recentExpensesProvider);
      ref.refresh(allExpensesProvider);
      ref.refresh(getOverallExpenseProvider);
      ref.refresh(getExpenseTimeFrameProvider);

      //show a snack bar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Expense Added"),
      ));
      // Navigate back to the home screen after adding expense
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.read(categoryProvider);

    //update selected category if it is null
    try {
      if (kDebugMode) {
        print(selectedCategory);
      }
    } catch (e) {
      selectedCategory = categories[0].name;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Expense Amount Field
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 16),
            //Expense Date Field
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date',
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            //Expense Category Dropdown
            DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category.name,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: category.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(category.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                }),
            SizedBox(height: 16),
            //Expense Description Field
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Add Expense
          _addExpense();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
