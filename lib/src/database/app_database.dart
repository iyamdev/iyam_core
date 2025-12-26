import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._();

  static const _databaseName = 'iyam_app.db';
  static const _databaseVersion = 1;

  static Database? _database;

  // ==============================
  // SINGLETON INSTANCE
  // ==============================

  static Future<Database> get instance async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // ==============================
  // INITIALIZATION
  // ==============================

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  // ==============================
  // CONFIGURATION
  // ==============================

  static Future<void> _onConfigure(Database db) async {
    // Enable foreign key support
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // ==============================
  // CREATE TABLES
  // ==============================

  static Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    // ==============================
    // EXAMPLE TABLE (CACHE USER)
    // ==============================

    await db.execute('''
      CREATE TABLE user_cache (
        id INTEGER PRIMARY KEY,
        data TEXT NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // ==============================
    // OFFLINE QUEUE
    // ==============================

    await db.execute('''
      CREATE TABLE offline_queue (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        method TEXT NOT NULL,
        path TEXT NOT NULL,
        body TEXT,
        created_at INTEGER NOT NULL
      )
    ''');
  }

  // ==============================
  // MIGRATION
  // ==============================

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // contoh migrasi versi 2
      // await db.execute('ALTER TABLE user_cache ADD COLUMN extra TEXT');
    }
  }

  // ==============================
  // UTILITIES
  // ==============================

  static Future<void> clearAll() async {
    final db = await instance;
    await db.delete('user_cache');
    await db.delete('offline_queue');
  }

  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
