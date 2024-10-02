class Transaction {
  final int id;
  final String type;
  final int categoryId;
  final double amount;
  final DateTime date;
  final String categoryName;
  final String categoryColor;

  Transaction({
    required this.id,
    required this.type,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.categoryName,
    required this.categoryColor,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int? ?? 0,
      type: map['type'] as String? ?? '',
      categoryId: map['category_id'] as int? ?? 0,
      amount: map['amount'] as double? ?? 0.0,
      date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
      categoryName: map['category_name'] as String? ?? '',
      categoryColor: map['category_color']?.toString() ?? '',
    );
  }
}
