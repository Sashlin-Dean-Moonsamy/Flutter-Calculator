import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/calculation.dart';

class DBHelper {
  static Database? _database;

  // Singleton pattern to get the instance of the database
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    // Get the application documents directory
    final directory = await getApplicationDocumentsDirectory();
    print(directory);
    final path = join(directory.path, 'calculator_history.db');

    // Open the database
    _database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expression TEXT,
        result TEXT,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      );
      ''');
    });
    return _database!;
  }

  // Insert a new calculation history entry
  Future<void> insertCalculation(Calculation calculation) async {
    final db = await getDatabase();
    await db.insert(
      'history',
      calculation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all calculation history and return as a List of HistoryModel
  Future<List<Calculation>> getHistory() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('history', orderBy: 'timestamp DESC');
    return result.map((entry) => Calculation.fromMap(entry)).toList();
  }

  // Clear all calculation history
  Future<int> clearHistory() async {
    final db = await getDatabase();
    return await db.delete('history');
  }
}
