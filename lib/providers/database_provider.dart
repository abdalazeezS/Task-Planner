import 'package:Task_Planner/models/sub_task.dart';
import 'package:Task_Planner/models/task.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider extends ChangeNotifier {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  static Database? _db;

  Future<Database?> get database async {
    if (_db == null) {
      _db = await initializeDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'tasks.db');
    Database db = await openDatabase(path, onCreate: _onCreate, version: 1);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      date TEXT NOT NULL,
      isFinished INTEGER NOT NULL,
      priority TEXT NOT NULL,
      category TEXT NOT NULL,
      description TEXT,
      subTasks TEXT
    )
    ''');
  }

  Future<int> addTask(Task task) async {
    Database? myDb = await database;
    var res = await myDb!.insert('tasks', task.toMap());
    // print('===========================================${res}');
    return res;
  }

  Future<List<Task>> getTasks() async {
    Database? myDb = await database;
    List<Map<String, Object?>> res = await myDb!.rawQuery(
      'SELECT * FROM tasks WHERE isFinished=0',
    );
    List<Task> tasks = [];
    res.forEach((element) {
      tasks.add(Task.fromMap(element));
    });
    return tasks;
  }

  Future<List<Task>> getCompletedTasks() async {
    Database? myDb = await database;
    List<Map<String, Object?>> res = await myDb!.rawQuery(
      'SELECT * FROM tasks WHERE isFinished=1',
    );
    List<Task> tasks = [];
    res.forEach((element) {
      tasks.add(Task.fromMap(element));
    });
    return tasks;
  }

  Future<String?> getSubTasks(Task task) async {
    Database? myDb = await database;
    List<Map<String, Object?>> res = await myDb!.rawQuery(
      'SELECT * FROM tasks WHERE id=${task.id}',
    );
    // print("getSubTaskResult========================${res}");
    var subTasksAsString = res[0]['subTasks'];
    if (subTasksAsString == null)
      return '';
    else
      return subTasksAsString as String;
  }

  updateTask(Task task) async {
    final db = await database;
    var res = await db
        ?.update('tasks', task.toMap(), where: 'id=?', whereArgs: [task.id]);
    print('update res =================================${res}');
    notifyListeners();
    return res;
  }

  removeTask(int id) async {
    final db = await database;
    return await db?.delete('tasks', where: 'id=?', whereArgs: [id]);
  }

  Future removeAll() async {
    final db = await database;
    return await db?.delete('tasks');
  }
}
