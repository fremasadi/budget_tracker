class Category {
  final int? id;
  final String name;
  final int color;
  final int icon;

  Category({this.id, required this.name, required this.color, required this.icon});

  // Konversi dari Map ke Category
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      color: map['color'],
      icon: map['icon'],
    );
  }

  // Konversi dari Category ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'icon': icon,
    };
  }
}
