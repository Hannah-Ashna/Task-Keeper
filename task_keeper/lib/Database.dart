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

  Future<int> insertList(TaskList list) async{
    int listID = 0;
    Database _db = await database();
    await _db.insert('list', list.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value){
      listID = value;
    });
    return listID;
  }

  Future<void> updateListTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE list SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateListDesc(int id, String desc) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE list SET description = '$desc' WHERE id = '$id'");
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

  Future<void> deleteList(int id) async {
    Database _db = await database();
    await _db.rawUpdate("DELETE FROM list WHERE id = '$id'");
    await _db.rawUpdate("DELETE FROM todo WHERE taskID = '$id'");
  }

  Future<List<ToDo>> getTask(int listID) async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.rawQuery("SELECT * FROM todo WHERE taskID = $listID");
    return List.generate(taskMap.length, (index) {
      return ToDo(id: taskMap[index]['id'], title: taskMap[index]['title'], taskID: taskMap[index]['taskID'], isDone: taskMap[index]['isDone']);
    });
  }

  Future<void> updateTaskComplete(int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  }
}