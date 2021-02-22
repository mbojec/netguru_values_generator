import 'package:quotes_generator/models/quote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  static Database _database;

  DatabaseHelper._internal();

  Future<void> init() async {
    _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'quotes_database.db'),
      onCreate: (Database db, int version) {
        return db.execute(
          // ignore: lines_longer_than_80_chars
          'CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT NOT NULL, is_favorite INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insert(Quote value) async {
    await _database.insert(
      'quotes',
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Quote>> values() async {
    final List<Map<String, dynamic>> maps = await _database.query('quotes');
    return List<Quote>.generate(maps.length, (int i) {
      return Quote.fromMap(maps[i]);
    });
  }

  Future<List<Quote>> favoriteValues() async {
    final List<Map<String, dynamic>> maps = await _database
        .query('quotes', where: 'is_favorite = ?', whereArgs: <int>[1]);
    return List<Quote>.generate(maps.length, (int i) {
      return Quote.fromMap(maps[i]);
    });
  }

  Future<void> update(Quote value) async {
    await _database.update('quotes', value.toMap(),
        where: 'id = ?', whereArgs: <int>[value.id]);
  }
}
