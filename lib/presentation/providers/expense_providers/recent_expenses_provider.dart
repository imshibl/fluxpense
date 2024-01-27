import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

//Recent Expenses Provider
final recentExpensesProvider = FutureProvider<List<ExpenseEntity>>((ref) async {
  final useCase = ref.read(expenseUseCaseProvider);
  return useCase.getRecentExpenses();
});
