import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/data/data_sources/local_database.dart';
import 'package:fluxpense/data/models/expense_model.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';

//Data layer repository provider
final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository();
});

class ExpenseRepository {
  final ExpenseDatabase _database = ExpenseDatabase.instance;

  // Add an expense
  Future<void> addExpense(ExpenseEntity expense) async {
    final db = await _database.database;
    final expenseModel = ExpenseModel.fromEntity(expense);
    await db.insert(
      'expenses',
      expenseModel.toMap(),
    );
  }

  // Update an expense
  Future<void> updateExpense(int id, ExpenseEntity updatedExpense) async {
    final db = await _database.database;
    final updatedExpenseModel = ExpenseModel.fromEntity(updatedExpense);

    await db.update(
      'expenses',
      updatedExpenseModel.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get all expenses
  Future<List<ExpenseEntity>> getAllExpenses() async {
    final db = await _database.database;

    final List<Map<String, dynamic>> maps =
        await db.query('expenses', orderBy: 'date DESC');

    List<ExpenseEntity> allExpenses = List.generate(maps.length, (index) {
      return ExpenseEntity(
        id: maps[index]['id'],
        amount: maps[index]['amount'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        category: maps[index]['category'],
      );
    });

    return allExpenses;
  }

  // Get the 10 most recent expenses(by date)
  Future<List<ExpenseEntity>> getRecentExpenses() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      orderBy: 'date DESC',
      limit: 10, // Limit the result to the 10 most recent expenses
    );
    List<ExpenseEntity> recentExpenses = List.generate(maps.length, (index) {
      return ExpenseEntity(
        id: maps[index]['id'],
        amount: maps[index]['amount'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        category: maps[index]['category'],
      );
    });

    return recentExpenses;
  }

  // Get a single expense by id
  Future<ExpenseEntity> getExpenseById(int id) async {
    final db = await _database.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );

    return ExpenseEntity(
      id: maps[0]['id'],
      amount: maps[0]['amount'],
      description: maps[0]['description'],
      date: maps[0]['date'],
      category: maps[0]['category'],
    );
  }

  // Get overall expenses as a double
  Future<double> getOverallExpenses() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');

    // Calculate the sum of all expenses
    double overallExpenses = 0;

    for (var map in maps) {
      overallExpenses += map['amount'];
    }

    return overallExpenses;
  }

  // Get weekly expenses
  Future<List<ExpenseEntity>> getWeeklyExpenses(DateTime date) async {
    final DateTime startOfWeek =
        date.subtract(Duration(days: date.weekday - 1));
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'date >= ? AND date < ?',
      whereArgs: [
        startOfWeek.toLocal().toString(),
        endOfWeek.toLocal().toString()
      ],
      orderBy: 'date DESC',
    );

    List<ExpenseEntity> weeklyExpenses = List.generate(maps.length, (index) {
      return ExpenseEntity(
        id: maps[index]['id'],
        amount: maps[index]['amount'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        category: maps[index]['category'],
      );
    });

    return weeklyExpenses;
  }

  // Get monthly expenses
  Future<List<ExpenseEntity>> getMonthlyExpenses(DateTime date) async {
    final DateTime startOfMonth = DateTime(date.year, date.month, 1);
    final DateTime endOfMonth = DateTime(date.year, date.month + 1, 1)
        .subtract(const Duration(days: 1));

    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'date >= ? AND date <= ?',
      whereArgs: [
        startOfMonth.toLocal().toString(),
        endOfMonth.toLocal().toString()
      ],
      orderBy: 'date DESC',
    );

    List<ExpenseEntity> monthlyExpenses = List.generate(maps.length, (index) {
      return ExpenseEntity(
        id: maps[index]['id'],
        amount: maps[index]['amount'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        category: maps[index]['category'],
      );
    });

    return monthlyExpenses;
  }

  Future<void> deleteExpense(int id) async {
    final db = await _database.database;
    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
