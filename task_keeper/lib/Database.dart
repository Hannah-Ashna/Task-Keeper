import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/List.dart';
import 'models/ToDo.dart';

class DatabaseTool {

  Future<Database> database() async{
    return openDatabase(
        join(await getDatabasesPath(), 'toDo.db'),

        onCreate: (db, version) async {
          await db.execute("CREATE TABLE list(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
          await db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, taskID INTEGER, isDone INTEGER)");

          return db;
        },
        version: 1,
    );
  }

  Future<void> insertList(TaskList list) async{
    Database _db = await database();
    await _db.insert('list', list.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTask(ToDo task) async{
    Database _db = await database();
    await _db.insert('todo', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaskList>> getList() async {
    Database _db = await database();
    List<Map<String, dynamic>> listMap = await _db.query('list');
    return List.generate(listMap.length, (index) {
      return TaskList(id: listMap[index]['id'], title: listMap[index]['title'], description: listMap[index]['description']);
    });
  }

  Future<List<ToDo>> getTask(int listID) async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.rawQuery("SELECT * FROM todo WHERE taskID = $listID");
    return List.generate(taskMap.length, (index) {
      return ToDo(id: taskMap[index]['id'], title: taskMap[index]['title'], taskID: taskMap[index]['taskID'], isDone: taskMap[index]['isDone']);
    });
  }
}