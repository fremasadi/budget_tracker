import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'categories.db');
    return await openDatabase(
      path,
      version: 2, // Increment the version if you modify the schema
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          iconIndex INTEGER NOT NULL,
          colorValue INTEGER NOT NULL
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle database upgrades if schema changes
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        name TEXT,
        iconIndex INTEGER,
        colorValue INTEGER
      )
    ''');
  }

  Future<int> insertCategory(Map<String, dynamic> category) async {
    Database db = await database;
    return await db.insert('categories', category);
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    Database db = await database;
    return await db.query('categories');
  }
}
