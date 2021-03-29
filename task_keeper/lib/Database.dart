import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/List.dart';
import 'models/ToDo.dart';
import 'models/PetData.dart';

class DatabaseTool {

  Future<Database> database() async{
    return openDatabase(
        join(await getDatabasesPath(), 'taskKeeper.db'),

        onCreate: (db, version) async {
          await db.execute("CREATE TABLE list(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
          await db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, taskID INTEGER, isDone INTEGER)");
          await db.execute("CREATE TABLE pet(id INTEGER PRIMARY KEY, hunger INTEGER, thirst INTEGER, happiness INTEGER)");
          return db;
        },
        version: 1,
    );
  }

  // To Do List Table
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

  // Task Item Table
  Future<void> insertTask(ToDo task) async{
    Database _db = await database();
    await _db.insert('todo', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
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

  // PetData Table
  Future<void> initHunger() async{
    final petData = PetData(
      id: 0,
      hunger: 20,
      thirst: 20,
      happiness: 20,
    );

    Database _db = await database();
    await _db.insert('pet', petData.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value){
    });
  }

  Future<void> updateHunger(int value) async {
    Database _db = await database();
    List<Map<String, dynamic>> petDataMap = await _db.query("pet");
    int hunger = petDataMap[0]['hunger'] + value;
    await _db.rawUpdate("UPDATE pet SET hunger = '$hunger'");
  }

  Future<void> updateThirst(int value) async {
    Database _db = await database();
    List<Map<String, dynamic>> petDataMap = await _db.query("pet");
    int thirst = petDataMap[0]['thirst'] + value;
    await _db.rawUpdate("UPDATE pet SET thirst = '$thirst'");
  }

  Future<void> updateHappiness(int value) async {
    Database _db = await database();
    List<Map<String, dynamic>> petDataMap = await _db.query("pet");
    int happiness = petDataMap[0]['happiness'] + value;
    await _db.rawUpdate("UPDATE pet SET happiness = '$happiness'");
  }

  Future<int> getHunger() async {
    Database _db = await database();
    List<Map<String, dynamic>> petDataMap = await _db.query("pet");
    return petDataMap[0]['hunger'];
  }

  Future<int> getThirst() async {
    Database _db = await database();
    List<Map<String, dynamic>> petDataMap = await _db.query("pet");
    return petDataMap[0]['thirst'];
  }

  Future<int> getHappiness() async {
    Database _db = await database();
    List<Map<String, dynamic>> petDataMap = await _db.query("pet");
    return petDataMap[0]['happiness'];
  }
}