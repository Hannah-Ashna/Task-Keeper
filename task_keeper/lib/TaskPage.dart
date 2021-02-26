import 'package:flutter/material.dart';
import 'package:task_keeper/Widgets.dart';
import 'package:task_keeper/Database.dart';
import 'models/List.dart';

class TaskPage extends StatefulWidget{
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top:  24.0,
                    bottom: 24.0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async{
                            print("Field Value: $value");

                            if(value != ""){
                              DatabaseTool _dbTool = DatabaseTool();
                              TaskList newList = TaskList(
                                title: value,
                              );

                              await _dbTool.insertList(newList);

                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Task List Title",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: TextField(
                    onSubmitted: (value) {
                      print("Field Value: $value");
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Description for this list ...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                    ),
                  ),
                ),
                ToDoWidget(
                  text: "Create your first task",
                  isDone: false,
                ),
                ToDoWidget(
                  text: "Create your second task",
                  isDone: true,
                ),
                ToDoWidget(
                  isDone: false,
                ),
                ToDoWidget(
                  isDone: true,
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) => TaskPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey[900],
      ),
    );
  }
}
