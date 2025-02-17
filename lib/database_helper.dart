import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Get the database path and join it with the database name
    final dbPath = await getDatabasesPath();
    final pathToDb = join(dbPath, 'users.db');


    // Open the database with the specified version, onCreate and onUpgrade callbacks
    _database = await openDatabase(
      pathToDb,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _database!;
  }

  // Method to create the database schema
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

  // Method to handle schema upgrades when the version changes
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE users ADD COLUMN isFavourite INTEGER DEFAULT 0");
    }
  }

  // Method to insert a user into the database
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  // Method to fetch all users from the database
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  // Method to update a user's 'isFavourite' field
  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  // Method to delete a user from the database
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Method to insert or update a user based on their email address
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