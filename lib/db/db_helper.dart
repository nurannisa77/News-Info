import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _database;
  static final DbHelper instance = DbHelper._();

  DbHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'bookmark_database.db');
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Bookmarks(
            link TEXT PRIMARY KEY,
            title TEXT,
            pubDate TEXT,
            description TEXT,
            thumbnail TEXT
          )
        ''');
      },
    );

    print('Database berhasil dibuat!');
    return db;
  }

  Future<void> insertBookmark(Map<String, dynamic> bookmark) async {
    final db = await database;
    await db.insert(
      'Bookmarks',
      bookmark..['pubDate'] = bookmark['pubDate'].toString(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBookmark(String link) async {
    final db = await database;
    await db.delete(
      'Bookmarks',
      where: 'link = ?',
      whereArgs: [link],
    );
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final db = await database;
    return await db.query('Bookmarks');
  }
}
