import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

final allExpensesProvider = FutureProvider<List<ExpenseEntity>>((ref) async {
  final useCase = ref.read(expenseUseCaseProvider);
  return useCase.getAllExpenses();
});
