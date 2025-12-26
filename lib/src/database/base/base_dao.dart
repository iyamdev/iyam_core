import 'package:sqflite/sqflite.dart';

abstract class BaseDao<T> {
  String get tableName;

  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T entity);

  // ==============================
  // CRUD
  // ==============================

  Future<int> insert(Database db, T entity) {
    return db.insert(
      tableName,
      toMap(entity),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(
    Database db,
    T entity, {
    required String where,
    required List<Object?> whereArgs,
  }) {
    return db.update(
      tableName,
      toMap(entity),
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(
    Database db, {
    required String where,
    required List<Object?> whereArgs,
  }) {
    return db.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<List<T>> findAll(Database db) async {
    final result = await db.query(tableName);
    return result.map(fromMap).toList();
  }

  Future<T?> findById(
    Database db,
    Object id,
  ) async {
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? fromMap(result.first) : null;
  }
}
