import 'package:fluxpense/domain/enitity/expense_entity.dart';

class ExpenseModel {
  final int? id;
  final double amount;
  final String description;
  final String date;
  final String category;

  ExpenseModel({
    this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'description': description,
      'date': date,
      'category': category,
    };
  }

  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      amount: entity.amount,
      description: entity.description,
      date: entity.date,
      category: entity.category,
    );
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      amount: amount,
      description: description,
      date: date,
      category: category,
    );
  }
}
