import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/data/repositories/expense_repository_impl.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/repositories/expense_repository.dart';

//Domain layer usecase provider
final expenseUseCaseProvider = Provider<ExpenseUseCase>((ref) {
  //data layer repository impl provider
  final repository = ref.read(expenseRepositoryImplProvider);
  return ExpenseUseCase(repository);
});

class ExpenseUseCase {
  final ExpenseRepository _repository;

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
