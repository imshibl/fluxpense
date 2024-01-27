import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/domain/usecases/expense_use_case.dart';

//Provider to get overall expenses in type double
final getOverallExpenseProvider = FutureProvider<double>((ref) {
  final useCase = ref.read(expenseUseCaseProvider);
  return useCase.getOverAllExpense();
});
