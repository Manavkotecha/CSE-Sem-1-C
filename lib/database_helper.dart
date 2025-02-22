import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static Database? _tempDatabase;

  DatabaseHelper._init();

  // Main Database Getter
  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final pathToDb = join(dbPath, 'users.db');

    _database = await openDatabase(
      pathToDb,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _database!;
  }

  // Temporary Database Getter
  Future<Database> get tempDatabase async {
    if (_tempDatabase != null) return _tempDatabase!;

    final directory = await getApplicationDocumentsDirectory();
    final pathToTempDb = join(directory.path, 'temp_users.db');

    _tempDatabase = await openDatabase(
      pathToTempDb,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE temp_users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
    return _tempDatabase!;
  }

  // Method to Create the Main Database Schema
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        mobile TEXT,
        dob TEXT,
        city TEXT,
        gender TEXT,
        hobbies TEXT,
        password TEXT,
        isFavourite INTEGER DEFAULT 0
      )
    ''');
  }

  // Method to Handle Schema Upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE users ADD COLUMN isFavourite INTEGER DEFAULT 0");
    }
  }

  // Method to Insert Temporary User
  Future<int> insertTempUser(Map<String, dynamic> user) async {
    final db = await instance.tempDatabase;
    return await db.insert('temp_users', user);
  }

  // Method to Fetch Temporary User
  Future<List<Map<String, dynamic>>> fetchTempUser(String email, String password) async {
    final db = await instance.tempDatabase;
    return await db.query(
      'temp_users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
  }

  // Method to Insert User into Main Database
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  // Method to Fetch All Users from Main Database
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  // Method to Update User
  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  // Method to Delete User
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Method to Insert or Update User Based on Email
  Future<void> insertOrUpdateUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> existingUsers = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [user['email']],
    );

    if (existingUsers.isNotEmpty) {
      await db.update('users', user, where: 'email = ?', whereArgs: [user['email']]);
    } else {
      await db.insert('users', user);
    }
  }
}
