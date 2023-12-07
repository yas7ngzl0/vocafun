import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  factory DBHelper() => _instance;

  DBHelper.internal();

  Database? _db; // Değişiklik burada, nullable olarak tanımlandı

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'your_database.db');

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE words (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        word TEXT,
        meaning TEXT
      )
    ''');
  }

  Future<int> insertWord(String word, String meaning) async {
    var client = await db;
    return client.insert(
      'words',
      {'word': word, 'meaning': meaning},
    );
  }

  Future<int> deleteWord(String word) async {
    var client = await db;
    return client.delete(
      'words',
      where: 'word = ?',
      whereArgs: [word],
    );
  }

  Future<List<Map<String, dynamic>>> getWords() async {
    var client = await db;
    return client.query('words');
  }
}
