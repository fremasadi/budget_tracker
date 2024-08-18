class Category {
  final int? id; // id bisa null saat pembuatan
  final String name;
  final int color;
  final int icon;

  Category({
    this.id, // id bisa null saat pembuatan
    required this.name,
    required this.color,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // id bisa null
      'name': name,
      'color': color,
      'icon': icon,
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      color: map['color'],
      icon: map['icon'],
    );
  }
}
