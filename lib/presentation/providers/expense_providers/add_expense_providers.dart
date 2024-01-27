import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

final addExpenseProvider =
    Provider<Future<void> Function(ExpenseEntity)>((ref) {
  final useCase = ref.read(expenseUseCaseProvider);
  return (ExpenseEntity expense) => useCase.addExpense(expense);
});

class CategoryModel {
  final String name;
  final Color color;

  CategoryModel({required this.name, required this.color});
}

final categoryProvider = StateProvider<List<CategoryModel>>((ref) {
  return [
    CategoryModel(name: 'Food', color: Colors.green),
    CategoryModel(name: 'Transportation', color: Colors.blue),
    CategoryModel(name: 'Entertainment', color: Colors.orange),
    CategoryModel(name: 'Shopping', color: Colors.purple),
    CategoryModel(name: 'Health', color: Colors.red),
    CategoryModel(name: 'Education', color: Colors.yellow),
    CategoryModel(name: 'Personal', color: Colors.pink),
    CategoryModel(name: 'Savings', color: Colors.brown),
    CategoryModel(name: 'Investments', color: Colors.lime),
    CategoryModel(name: 'Other', color: Colors.grey),
  ];
});
