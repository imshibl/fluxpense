class ExpenseEntity {
  final int? id;
  final double amount;
  final String description;
  final String date;
  final String category;

  ExpenseEntity({
    this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
  });
}
