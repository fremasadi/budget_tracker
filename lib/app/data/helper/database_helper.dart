import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/category.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'budget_tracker.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            color INTEGER,
            icon INTEGER
          );
          ''',
        );

        await db.execute(
          '''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            category_id INTEGER,
            amount REAL,
            date TEXT,
            FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
          );
          ''',
        );
      },
    );
  }

  Future<int> insertCategory(Category category) async {
    final db = await database;
    final id = await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  Future<void> updateCategory(Category category) async {
    final db = await database;
    await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<void> deleteCategory(int id) async {
    final db = await database;
    await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> saveTransaction(
      String type, int categoryId, double amount, DateTime date) async {
    final db = await database;
    await db.insert('transactions', {
      'type': type,
      'category_id': categoryId,
      'amount': amount,
      'date': date.toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getTransactionsWithCategories() async {
    final db = await database;
    return await db.rawQuery('''
    SELECT transactions.id, transactions.type, transactions.amount, transactions.date,
           categories.name AS category_name, categories.color AS category_color
    FROM transactions
    JOIN categories ON transactions.category_id = categories.id
  ''');
  }

  Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
