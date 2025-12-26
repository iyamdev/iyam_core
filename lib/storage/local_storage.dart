import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static final LocalStorage instance = LocalStorage._();

  // ==============================
  // CORE
  // ==============================

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  // ==============================
  // STRING
  // ==============================

  Future<void> writeString(
    String key,
    String value,
  ) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  Future<String?> readString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key);
  }

  // ==============================
  // BOOLEAN
  // ==============================

  Future<void> writeBool(
    String key,
    bool value,
  ) async {
    final prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  Future<bool?> readBool(String key) async {
    final prefs = await _prefs;
    return prefs.getBool(key);
  }

  // ==============================
  // INTEGER
  // ==============================

  Future<void> writeInt(
    String key,
    int value,
  ) async {
    final prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  Future<int?> readInt(String key) async {
    final prefs = await _prefs;
    return prefs.getInt(key);
  }

  // ==============================
  // DOUBLE
  // ==============================

  Future<void> writeDouble(
    String key,
    double value,
  ) async {
    final prefs = await _prefs;
    await prefs.setDouble(key, value);
  }

  Future<double?> readDouble(String key) async {
    final prefs = await _prefs;
    return prefs.getDouble(key);
  }

  // ==============================
  // LIST STRING
  // ==============================

  Future<void> writeStringList(
    String key,
    List<String> value,
  ) async {
    final prefs = await _prefs;
    await prefs.setStringList(key, value);
  }

  Future<List<String>?> readStringList(
    String key,
  ) async {
    final prefs = await _prefs;
    return prefs.getStringList(key);
  }

  // ==============================
  // JSON (MAP)
  // ==============================

  Future<void> writeJson(
    String key,
    Map<String, dynamic> value,
  ) async {
    final prefs = await _prefs;
    await prefs.setString(
      key,
      jsonEncode(value),
    );
  }

  Future<Map<String, dynamic>?> readJson(
    String key,
  ) async {
    final prefs = await _prefs;
    final value = prefs.getString(key);
    if (value == null) return null;

    try {
      return jsonDecode(value) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  // ==============================
  // JSON LIST
  // ==============================

  Future<void> writeJsonList(
    String key,
    List<Map<String, dynamic>> list,
  ) async {
    final prefs = await _prefs;
    await prefs.setString(
      key,
      jsonEncode(list),
    );
  }

  Future<List<Map<String, dynamic>>?> readJsonList(String key) async {
    final prefs = await _prefs;
    final value = prefs.getString(key);
    if (value == null) return null;

    try {
      final decoded = jsonDecode(value) as List;
      return decoded
          .map(
            (e) => e as Map<String, dynamic>,
          )
          .toList();
    } catch (_) {
      return null;
    }
  }

  // ==============================
// GENERIC LIST (JSON MAP)
// ==============================

  Future<void> writeList(
    String key,
    List<Map<String, dynamic>> list,
  ) async {
    final prefs = await _prefs;
    await prefs.setString(
      key,
      jsonEncode(list),
    );
  }

  Future<List<Map<String, dynamic>>> readList(
    String key,
  ) async {
    final prefs = await _prefs;
    final value = prefs.getString(key);
    if (value == null) return [];

    try {
      final decoded = jsonDecode(value) as List;
      return decoded
          .map(
            (e) => Map<String, dynamic>.from(e),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> writeListGeneric<T>(
    String key,
    List<T> list,
    Map<String, dynamic> Function(T) toJson,
  ) async {
    final prefs = await _prefs;
    await prefs.setString(
      key,
      jsonEncode(list.map(toJson).toList()),
    );
  }

  Future<List<T>> readListGeneric<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final prefs = await _prefs;
    final value = prefs.getString(key);
    if (value == null) return [];

    try {
      final decoded = jsonDecode(value) as List;
      return decoded
          .map(
            (e) => fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ==============================
  // REMOVE / CLEAR
  // ==============================

  Future<void> remove(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  Future<void> clear() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  // ==============================
  // UTIL
  // ==============================

  Future<bool> contains(String key) async {
    final prefs = await _prefs;
    return prefs.containsKey(key);
  }
}
