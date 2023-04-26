import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class DatabaseHelper {
  static const dbName = 'mad_assignment.db';
  static const dbTable = 'posts_table';
  static const dbVersion = 1;
  static const colId = 'id';
  static const colPost = 'post';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _createDb);
  }

  Future _createDb(Database db, int newVersion) async {
    await db.execute("""
        CREATE TABLE $dbTable (
          $colId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colPost TEXT NOT NULL
         )
      """);
  }

  Future<int> insertPost(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(dbTable, row);
  }

  Future<List<Map<String, dynamic>>> queryPosts() async {
    Database? db = await instance.database;
    return await db.query(dbTable);
  }

  Future updatePost(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = int.parse(row[colId]);
    return await db.update(dbTable, row, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> deletePost(int id) async {
    Database? db = await instance.database;
    return await db.delete(dbTable, where: '$colId = ?', whereArgs: [id]);
  }
}
