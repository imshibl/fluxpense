import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

//All Expenses/Categorized Expense Provider
final allExpensesProvider = FutureProvider<List<ExpenseEntity>>((ref) async {
  final useCase = ref.read(expenseUseCaseProvider);
  final allExpenses = await useCase.getAllExpenses();

  final expenseFilter = ref.watch(filterAllExpensesProvider);
  final List<ExpenseEntity> filteredExpenses = [];

  if (expenseFilter == ExpenseFilterType.all) {
    return allExpenses;
  }

  for (final expense in allExpenses) {
    if (expense.category.toLowerCase() == expenseFilter.name) {
      filteredExpenses.add(expense);
    }
  }
  return filteredExpenses;
});

//Expense Filter Enums
enum ExpenseFilterType {
  all,
  food,
  transportation,
  entertainment,
  shopping,
  health,
  education,
  personal,
  savings,
  investments,
  other,
}

//Select Filter Provider
final filterAllExpensesProvider = StateProvider<ExpenseFilterType>((ref) {
  return ExpenseFilterType.all;
});
