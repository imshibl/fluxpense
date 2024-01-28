import 'package:flutter_test/flutter_test.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ExpenseUseCase expenseUseCase;
  late MockExpenseRepository mockExpenseRepository;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    expenseUseCase = ExpenseUseCase(mockExpenseRepository);
  });

  ExpenseEntity expense = ExpenseEntity(
      id: 1,
      description: 'title',
      amount: 1.0,
      date: "2021-01-01",
      category: 'category');

  final dateTime = DateTime.now();

  test('add expense', () async {
    when(mockExpenseRepository.addExpense(expense))
        .thenAnswer((_) async => isA<Future<void>>());

    final result = expenseUseCase.addExpense(expense);

    expect(result, isA<Future<void>>());
  });

  test('update expense', () async {
    when(mockExpenseRepository.updateExpense(1, expense))
        .thenAnswer((_) async => isA<Future<void>>());

    final result = expenseUseCase.updateExpense(1, expense);

    expect(result, isA<Future<void>>());
  });

  test('get all expenses', () {
    when(mockExpenseRepository.getAllExpenses())
        .thenAnswer((_) => Future.value(<ExpenseEntity>[]));

    final result = expenseUseCase.getAllExpenses();

    expect(result, isA<Future<List<ExpenseEntity>>>());
  });

  test('get recent expenses', () {
    when(mockExpenseRepository.getRecentExpenses())
        .thenAnswer((_) => Future.value(<ExpenseEntity>[]));

    final result = expenseUseCase.getRecentExpenses();

    expect(result, isA<Future<List<ExpenseEntity>>>());
  });

  test('get expense by id', () {
    when(mockExpenseRepository.getExpenseById(1))
        .thenAnswer((_) => Future.value(expense));

    final result = expenseUseCase.getExpenseById(1);

    expect(result, isA<Future<ExpenseEntity>>());
  });

  test('should get overall expense amount as a double value', () async {
    when(mockExpenseRepository.getOverAllExpense())
        .thenAnswer((_) async => 0.0);

    final result = await expenseUseCase.getOverAllExpense();

    expect(result, 0.0);
  });

  test('get weekly expenses', () {
    when(mockExpenseRepository.getWeeklyExpenses(dateTime))
        .thenAnswer((_) => Future.value(<ExpenseEntity>[]));

    final result = expenseUseCase.getWeeklyExpenses(dateTime);

    expect(result, isA<Future<List<ExpenseEntity>>>());
  });

  test('get monthly expenses', () {
    when(mockExpenseRepository.getMonthlyExpenses(dateTime))
        .thenAnswer((_) => Future.value(<ExpenseEntity>[]));

    final result = expenseUseCase.getMonthlyExpenses(dateTime);

    expect(result, isA<Future<List<ExpenseEntity>>>());
  });

  test('delete expense', () {
    when(mockExpenseRepository.deleteExpense(1))
        .thenAnswer((_) async => isA<Future<void>>);

    final result = expenseUseCase.deleteExpense(1);

    expect(result, isA<Future<void>>());
  });
}
