import 'package:sqflite/sqflite.dart';
import 'package:test_project_flutter/models/user.dart';
import 'package:path/path.dart';

class UserService {
  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');
    final database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT)',
      );
    });
    return database;
  }

  Future<List<User>> getAllUsers() async {
    final database = await _getDatabase();
    final userList = await database.query('users');
    return userList.map((user) => User.fromMap(user)).toList();
  }

  Future<void> addUser(User user) async {
    final database = await _getDatabase();
    await database.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(User user) async {
    final database = await _getDatabase();
    await database
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteUser(int id) async {
    final database = await _getDatabase();
    await database.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');
    final database = await openDatabase(path);
    return database;
  }
}
