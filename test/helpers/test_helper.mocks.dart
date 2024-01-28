// Mocks generated by Mockito 5.4.4 from annotations
// in fluxpense/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:fluxpense/domain/enitity/expense_entity.dart' as _i2;
import 'package:fluxpense/domain/repositories/expense_repository.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeExpenseEntity_0 extends _i1.SmartFake implements _i2.ExpenseEntity {
  _FakeExpenseEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ExpenseRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockExpenseRepository extends _i1.Mock implements _i3.ExpenseRepository {
  MockExpenseRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> addExpense(_i2.ExpenseEntity? expense) =>
      (super.noSuchMethod(
        Invocation.method(
          #addExpense,
          [expense],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> updateExpense(
    int? id,
    _i2.ExpenseEntity? updatedExpense,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateExpense,
          [
            id,
            updatedExpense,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i2.ExpenseEntity>> getAllExpenses() => (super.noSuchMethod(
        Invocation.method(
          #getAllExpenses,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.ExpenseEntity>>.value(<_i2.ExpenseEntity>[]),
      ) as _i4.Future<List<_i2.ExpenseEntity>>);

  @override
  _i4.Future<_i2.ExpenseEntity> getExpenseById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getExpenseById,
          [id],
        ),
        returnValue: _i4.Future<_i2.ExpenseEntity>.value(_FakeExpenseEntity_0(
          this,
          Invocation.method(
            #getExpenseById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.ExpenseEntity>);

  @override
  _i4.Future<List<_i2.ExpenseEntity>> getRecentExpenses() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecentExpenses,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.ExpenseEntity>>.value(<_i2.ExpenseEntity>[]),
      ) as _i4.Future<List<_i2.ExpenseEntity>>);

  @override
  _i4.Future<void> deleteExpense(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteExpense,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<double> getOverAllExpense() => (super.noSuchMethod(
        Invocation.method(
          #getOverAllExpense,
          [],
        ),
        returnValue: _i4.Future<double>.value(0.0),
      ) as _i4.Future<double>);

  @override
  _i4.Future<List<_i2.ExpenseEntity>> getWeeklyExpenses(DateTime? date) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWeeklyExpenses,
          [date],
        ),
        returnValue:
            _i4.Future<List<_i2.ExpenseEntity>>.value(<_i2.ExpenseEntity>[]),
      ) as _i4.Future<List<_i2.ExpenseEntity>>);

  @override
  _i4.Future<List<_i2.ExpenseEntity>> getMonthlyExpenses(DateTime? date) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMonthlyExpenses,
          [date],
        ),
        returnValue:
            _i4.Future<List<_i2.ExpenseEntity>>.value(<_i2.ExpenseEntity>[]),
      ) as _i4.Future<List<_i2.ExpenseEntity>>);
}