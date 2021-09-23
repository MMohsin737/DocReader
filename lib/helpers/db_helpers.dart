import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'docs.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            ' CREATE TABLE recent_docs(id TEXT PRIMARY KEY, docpath TEXT) ');
      },
    );
  }

  static Future<int> insert({String table, Map<String, dynamic> data}) async {
    final db = await DBHelper.database();
    int res = await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    print('resDBinsert: $res');
    return res;
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT * FROM $table ORDER BY docpath DESC');
  }

  static Future<int> removeItem({String table, String id}) async {
    final db = await DBHelper.database();
    int result = await db.delete(table, where: 'id = \"$id\"', whereArgs: []);
    return result;
  }
}
