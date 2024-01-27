import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/repositories/expense_repository.dart';

final expenseUseCaseProvider = Provider<ExpenseUseCase>((ref) {
  final repository = ref.read(iExpenseRepositoryProvider);
  return ExpenseUseCase(repository);
});

class ExpenseUseCase {
  final IExpenseRepository _repository;

  ExpenseUseCase(this._repository);

  Future<void> addExpense(ExpenseEntity expense) async {
    await _repository.addExpense(expense);
  }

  Future<void> updateExpense(int id, ExpenseEntity updatedExpense) async {
    await _repository.updateExpense(id, updatedExpense);
  }

  Future<List<ExpenseEntity>> getAllExpenses() async {
    return _repository.getAllExpenses();
  }

  Future<ExpenseEntity> getExpenseById(int id) async {
    return _repository.getExpenseById(id);
  }

  Future<List<ExpenseEntity>> getRecentExpenses() async {
    return _repository.getRecentExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await _repository.deleteExpense(id);
  }

  Future<double> getOverAllExpense() async {
    return await _repository.getOverAllExpense();
  }

  Future<List<ExpenseEntity>> getWeeklyExpenses(DateTime date) async {
    return await _repository.getWeeklyExpenses(date);
  }

  Future<List<ExpenseEntity>> getMonthlyExpenses(DateTime date) async {
    return await _repository.getMonthlyExpenses(date);
  }
}
