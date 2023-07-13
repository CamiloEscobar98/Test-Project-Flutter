// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:test_project_flutter/models/user.dart';
import 'package:path/path.dart';

class UserService {
  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'example_database.db');
    final dbExists = await databaseExists(path);
    final Database db;
    if (dbExists == false) {
      print('La base de datos no existe.');
      db = await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name VARCHAR, email VARCHAR, date VARCHAR)',
        );
      });
    } else {
      print('La base de datos existe');

      db = await openDatabase(path);
    }
    final result = await db.query('users');
    print('Usuarios: $result');
    return db;
  }

  Future<List<User>> getAllUsers() async {
    final database = await _getDatabase();
    final userList = await database.query('users');
    return userList.map((user) => User.fromMap(user)).toList();
  }

  Future<User> addUser(User user) async {
    final database = await _getDatabase();
    user.id = await database.insert('users', user.toMap());
    return user;
    // conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateUser(User user) async {
    final database = await _getDatabase();
    return await database.update('users', user.toMap(),
        where: 'email = ?', whereArgs: [user.email]);
  }

  Future<int> deleteUser(int id) async {
    final database = await _getDatabase();
    return await database.delete('users', where: 'email = ?', whereArgs: [id]);
  }

  Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'example_database.db');
    final database = await openDatabase(path);
    return database;
  }
}
