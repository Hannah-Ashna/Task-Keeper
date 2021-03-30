import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/List.dart';
import 'models/ToDo.dart';
import 'models/PetData.dart';
import 'models/Inventory.dart';

class DatabaseTool {

  // Setup and init the Database
  Future<Database> database() async{
    return openDatabase(
        join(await getDatabasesPath(), 'taskKeeper.db'),

        onCreate: (db, version) async {
          await db.execute("CREATE TABLE list(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
          await db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, taskID INTEGER, isDone INTEGER)");
          await db.execute("CREATE TABLE pet(id INTEGER PRIMARY KEY, hunger INTEGER, thirst INTEGER, happiness INTEGER)");
          await db.execute("CREATE TABLE inventory(id INTEGER PRIMARY KEY, money INTEGER, food INTEGER, water INTEGER, toys INTEGER)");
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

    if (isDone == 1) {
      List<Map<String, dynamic>> inventoryMap = await _db.query("inventory");
      int money = inventoryMap[0]['money'] + 10;
      await _db.rawUpdate("UPDATE inventory SET money = '$money'");
    }

    else {
      List<Map<String, dynamic>> inventoryMap = await _db.query("inventory");
      int money = inventoryMap[0]['money'] - 10;
      await _db.rawUpdate("UPDATE inventory SET money = '$money'");
    }
  }

  // PetData Table
  Future<void> initPetData() async{
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

  Future<void> updateHunger(int value, BuildContext context) async {
    Database _db = await database();
    List<Map<String, dynamic>> inventoryMap = await _db.query("inventory");
    if (inventoryMap[0]['food'] > 0) {
      // Update User's Inventory
      int food = inventoryMap[0]['food'] - 1;
      await _db.rawUpdate("UPDATE inventory SET food = '$food'");

      // Update Pet Data
      List<Map<String, dynamic>> petDataMap = await _db.query("pet");
      int hunger = petDataMap[0]['hunger'] + value;
      await _db.rawUpdate("UPDATE pet SET hunger = '$hunger'");
    }

    else {
      _showMyDialog(context, "You've run out of food! You must purchase more ...");
    }
  }

  Future<void> updateThirst(int value, BuildContext context) async {
    Database _db = await database();
    List<Map<String, dynamic>> inventoryMap = await _db.query("inventory");
    if (inventoryMap[0]['water'] > 0) {
      // Update User's Inventory
      int water = inventoryMap[0]['water'] - 1;
      await _db.rawUpdate("UPDATE inventory SET water = '$water'");

      // Update Pet Data
      List<Map<String, dynamic>> petDataMap = await _db.query("pet");
      int thirst = petDataMap[0]['thirst'] + value;
      await _db.rawUpdate("UPDATE pet SET thirst = '$thirst'");
    }

    else {
      _showMyDialog(context, "You've run out of water! You must purchase more ...");
    }
  }

  Future<void> updateHappiness(int value, BuildContext context) async {
    Database _db = await database();
    List<Map<String, dynamic>> inventoryMap = await _db.query("inventory");
    if (inventoryMap[0]['toys'] > 0) {
      // Update User's Inventory
      int toys = inventoryMap[0]['toys'] - 1;
      await _db.rawUpdate("UPDATE inventory SET toys = '$toys'");

      // Update Pet Data
      List<Map<String, dynamic>> petDataMap = await _db.query("pet");
      int happiness = petDataMap[0]['happiness'] + value;
      await _db.rawUpdate("UPDATE pet SET happiness = '$happiness'");
    }

    else {
      _showMyDialog(context, "You've run out of toys! You must purchase more ...");
    }
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

  // Inventory Table
  Future<void> initInventory() async {
    final inventory = Inventory(
      id: 0,
      money: 10,
      food: 5,
      water: 5,
      toys : 5,
    );

    Database _db = await database();
    await _db.insert('inventory', inventory.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value){
    });
  }

  Future<void> updateFood (int cost, BuildContext context) async {
    Database _db = await database();
    List<Map<String, dynamic>> inventoryMap = await _db.query("inventory");
    if (inventoryMap[0]['money'] >= cost){
      int money = inventoryMap[0]['money'] - cost;
      int food = inventoryMap[0]['food'] + 1;
      await _db.rawUpdate("UPDATE inventory SET money = '$money'");
      await _db.rawUpdate("UPDATE inventory SET food = '$food'");
    }

    else {
      _showMyDialog(context, "Oh no! You've run out of money ... it's time to get more tasks done.");
    }
  }

  Future<void> updateWater (int cost, BuildContext context) async {
    Database _db = await database();
    List<Map<String, dynamic>> inventoryMap = await _db.query("inventory");
    if (inventoryMap[0]['money'] >= cost){
      int money = inventoryMap[0]['money'] - cost;
      int water = inventoryMap[0]['water'] + 1;
      await _db.rawUpdate("UPDATE inventory SET money = '$money'");
      await _db.rawUpdate("UPDATE inventory SET water = '$water'");
    }

    else {
      _showMyDialog(context, "Oh no! You've run out of money ... it's time to get more tasks done.");
    }
  }

  Future<void> updateToys (int cost, BuildContext context) async {
    Database _db = await database();
    List<Map<String, dynamic>> inventoryMap = await _db.query("inventory");
    if (inventoryMap[0]['money'] >= cost){
      int money = inventoryMap[0]['money'] - cost;
      int toys = inventoryMap[0]['toys'] + 1;
      await _db.rawUpdate("UPDATE inventory SET money = '$money'");
      await _db.rawUpdate("UPDATE inventory SET toys = '$toys'");
    }

    else {
      _showMyDialog(context, "Oh no! You've run out of money ... it's time to get more tasks done.");
    }
  }

  Future<void> getMoney () async {
    Database _db = await database();
    List<Map<String, dynamic>> petDataMap = await _db.query("inventory");
    return petDataMap[0]['money'];
  }

  Future<void> _showMyDialog(BuildContext context, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}