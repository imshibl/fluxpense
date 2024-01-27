import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

//Delete Expense Provider
final deleteExpenseProvider = Provider<Future<void> Function(int)>((ref) {
  final useCase = ref.read(expenseUseCaseProvider);
  return (int id) => useCase.deleteExpense(id);
});
