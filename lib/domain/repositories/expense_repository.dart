import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/data/repositories/expense_repository.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';

//Domain layer repository provider
final iExpenseRepositoryProvider = Provider<IExpenseRepository>((ref) {
  //data layer repository provider
  final repository = ref.read(expenseRepositoryProvider);
  return IExpenseRepository(repository);
});

abstract class AExpenseRepository {
  Future<void> addExpense(ExpenseEntity expense);

  Future<void> updateExpense(int id, ExpenseEntity updatedExpense);

  Future<List<ExpenseEntity>> getAllExpenses();

  Future<ExpenseEntity> getExpenseById(int id);

  Future<List<ExpenseEntity>> getRecentExpenses();

  Future<void> deleteExpense(int id);

  Future<double> getOverAllExpense();

  Future<List<ExpenseEntity>> getWeeklyExpenses(DateTime date);

  Future<List<ExpenseEntity>> getMonthlyExpenses(DateTime date);
}

class IExpenseRepository implements AExpenseRepository {
  final ExpenseRepository _repository;

  IExpenseRepository(this._repository);

  @override
  Future<void> addExpense(ExpenseEntity expense) async {
    await _repository.addExpense(expense);
  }

  @override
  Future<void> updateExpense(int id, ExpenseEntity updatedExpense) async {
    await _repository.updateExpense(id, updatedExpense);
  }

  @override
  Future<List<ExpenseEntity>> getAllExpenses() async {
    return _repository.getAllExpenses();
  }

  @override
  Future<ExpenseEntity> getExpenseById(int id) async {
    return _repository.getExpenseById(id);
  }

  @override
  Future<List<ExpenseEntity>> getRecentExpenses() async {
    return _repository.getRecentExpenses();
  }

  @override
  Future<void> deleteExpense(int id) async {
    await _repository.deleteExpense(id);
  }

  @override
  Future<double> getOverAllExpense() async {
    return await _repository.getOverallExpenses();
  }

  @override
  Future<List<ExpenseEntity>> getWeeklyExpenses(DateTime date) async {
    return await _repository.getWeeklyExpenses(date);
  }

  @override
  Future<List<ExpenseEntity>> getMonthlyExpenses(DateTime date) async {
    return await _repository.getMonthlyExpenses(date);
  }
}
