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
      // Assuming id is always present and is an int
      type: map['type'] as String? ?? '',
      // Convert type to String
      categoryId: map['category_id'] as int? ?? 0,
      // Convert category_id to int
      amount: map['amount'] as double? ?? 0.0,
      // Convert amount to double
      date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
      // Convert date to DateTime
      categoryName: map['category_name'] as String? ?? '',
      // Convert category_name to String
      categoryColor: map['category_color']?.toString() ??
          '', // Ensure category_color is converted to String
    );
  }
}
