import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/enitity/expense_entity.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

//Provider to get expenses based on time frame(weekly, monthly, all time)
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

//Expense Time Frame Enums
enum TimeFrameSortType {
  weekly,
  monthly,
  allTime,
}

//Expense Time Frame Selection Provider
final timeFrameSortTypeProvider = StateProvider<TimeFrameSortType>(
  (ref) => TimeFrameSortType.weekly,
);
