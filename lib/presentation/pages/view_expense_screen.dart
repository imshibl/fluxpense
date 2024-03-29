// ignore_for_file: unused_result

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/presentation/providers/expense_providers/add_expense_providers.dart';
import 'package:fluxpense/presentation/providers/expense_providers/all_expenses_provider.dart';
import 'package:fluxpense/presentation/providers/expense_providers/delete_expense_provider.dart';
import 'package:fluxpense/presentation/providers/expense_providers/expense_chart_providers.dart';
import 'package:fluxpense/presentation/providers/expense_providers/get_overall_expense.dart';
import 'package:fluxpense/presentation/providers/expense_providers/get_single_expense_provider.dart';
import 'package:fluxpense/presentation/providers/expense_providers/recent_expenses_provider.dart';

//View/Edit Expense Screen
class ViewExpenseScreen extends ConsumerStatefulWidget {
  const ViewExpenseScreen({super.key});

  @override
  ConsumerState<ViewExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<ViewExpenseScreen> {
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late String selectedCategory;
  String newCategory = ""; //For updating category

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

  //Update expense
  Future<void> _updateExpense(
      {required int id, required String category}) async {
    final updateExpense = ref.read(updateSingleExpenseProvider);

    double amount = double.parse(amountController.text);
    String description = descriptionController.text;

    ExpenseEntity expense = ExpenseEntity(
        id: id,
        amount: amount,
        description: description,
        date: selectedDate.toLocal().toString(),
        category: category);

    await updateExpense(id, expense).whenComplete(() {
      //refresh the providers to update changed data in UI
      ref.refresh(recentExpensesProvider);
      ref.refresh(allExpensesProvider);
      ref.refresh(getOverallExpenseProvider);
      ref.refresh(getExpenseTimeFrameProvider);

      // Navigate back to the home screen after adding expense
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expenseId = ModalRoute.of(context)!.settings.arguments
        as int; //get passed expense id from the expense list
    final categories =
        ref.read(categoryProvider); //to create category dropdownbutton

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense'),
        actions: [
          //Delete expense icon
          IconButton(
            onPressed: () {
              final deleteExpense = ref.read(deleteExpenseProvider);
              deleteExpense(expenseId).whenComplete(() {
                ref.refresh(recentExpensesProvider);
                ref.refresh(allExpensesProvider);
                ref.refresh(getOverallExpenseProvider);
                ref.refresh(getExpenseTimeFrameProvider);

                //show a snack bar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Expense Deleted"),
                  ),
                );
                // Navigate back to the home screen after adding expense
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: ref.watch(getSingleExpensesProvider(expenseId)).when(
            data: (expense) {
              amountController =
                  TextEditingController(text: expense.amount.toString());
              descriptionController =
                  TextEditingController(text: expense.description);

              selectedCategory = expense.category;

              //set selectedDate if it is not null
              try {
                if (kDebugMode) {
                  print(selectedDate);
                }
              } catch (e) {
                selectedDate = DateTime.parse(expense.date);
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Expense Amount TextField
                    TextField(
                      controller: amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Amount'),
                    ),
                    const SizedBox(height: 16),
                    //Expense Date Field
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date',
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                                  margin: const EdgeInsets.only(right: 10),
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
                            newCategory = selectedCategory;
                          });
                        }),
                    const SizedBox(height: 16),
                    //Expense Description TextField
                    TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () => const CircularProgressIndicator(),
          ),
      //users can click this FAB if they want to update their data or else they can go back to the home screen.
      //even if they click this FAB without any data changes,it will update the data the original data,thus make no changes.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Add Expense
          //only update category if newCategory is not empty
          if (newCategory.isNotEmpty) {
            _updateExpense(id: expenseId, category: newCategory);
          } else {
            _updateExpense(id: expenseId, category: selectedCategory);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
