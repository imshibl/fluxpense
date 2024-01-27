import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

final getExpenseTimeFrameProvider =
    FutureProvider<List<ExpenseEntity>>((ref) async {
  final useCase = ref.read(expenseUseCaseProvider);
  final timeFrame = ref.watch(timeFrameSortTypeProvider);

  if (timeFrame == TimeFrameSortType.weekly) {
    return useCase.getWeeklyExpenses(DateTime.now());
  } else if (timeFrame == TimeFrameSortType.monthly) {
    return useCase.getMonthlyExpenses(DateTime.now());
  }
  return useCase.getAllExpenses();
});

enum TimeFrameSortType {
  weekly,
  monthly,
  allTime,
}

final timeFrameSortTypeProvider = StateProvider<TimeFrameSortType>(
  // We return the default sort type, here name.
  (ref) => TimeFrameSortType.weekly,
);
