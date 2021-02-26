import 'package:flutter/material.dart';
import 'package:task_keeper/Widgets.dart';
import 'package:task_keeper/Database.dart';
import 'models/List.dart';
import 'models/ToDo.dart';

class TaskPage extends StatefulWidget{
  final TaskList list;
  TaskPage({@required this.list});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseTool _dbTool = DatabaseTool();

  int _listID = 0;
  String _listTitle = "";

  @override
  void initState(){

    if(widget.list != null){
      _listTitle = widget.list.title;
      _listID = widget.list.id;
    }
    super.initState();
  }

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

                            // Check if field is null
                            if(value != ""){
                              // Check if list is null
                              if(widget.list == null) {
                                DatabaseTool _dbTool = DatabaseTool();
                                TaskList newList = TaskList(title: value);
                                await _dbTool.insertList(newList);
                              } else {
                                // Update the existing ask
                              }
                            }
                          },
                          controller: TextEditingController()..text = _listTitle,
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
                FutureBuilder(
                  initialData: [],
                  future: _dbTool.getTask(_listID),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              // Switch the the to do
                            },
                            child: ToDoWidget(
                              text: snapshot.data[index].title,
                              isDone: snapshot.data[index].isDone == 0 ? false : true,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30.0,
                            height: 30.0,
                            margin: EdgeInsets.only(
                              right: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              onSubmitted: (value) async{
                                // Check if field is null
                                if(value != ""){
                                  // Check if list is null
                                  if(widget.list != null) {
                                    ToDo newToDo = ToDo(
                                      title: value,
                                      isDone: 0,
                                      taskID: widget.list.id,
                                    );
                                    await _dbTool.insertTask(newToDo);
                                    setState(() {});
                                    print("creating to do");
                                  } else {
                                    // Update the existing ask
                                    print("noo");
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter to-do item ...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

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
