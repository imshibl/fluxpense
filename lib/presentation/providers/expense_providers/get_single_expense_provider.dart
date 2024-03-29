import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

//Get Single Expense by Id Provider
final getSingleExpensesProvider =
    FutureProvider.family.autoDispose<ExpenseEntity, int>((ref, id) async {
  final useCase = ref.read(expenseUseCaseProvider);
  return useCase.getExpenseById(id);
});

//Update Single Expense By Id Provider
final updateSingleExpenseProvider =
    Provider<Future<void> Function(int, ExpenseEntity)>((ref) {
  final useCase = ref.read(expenseUseCaseProvider);
  return (int id, ExpenseEntity expense) => useCase.updateExpense(id, expense);
});
