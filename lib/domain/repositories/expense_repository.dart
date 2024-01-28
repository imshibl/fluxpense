import 'package:fluxpense/domain/enitity/expense_entity.dart';

abstract class ExpenseRepository {
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
