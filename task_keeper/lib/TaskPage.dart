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
  String _listDesc = "";

  FocusNode _titleFocus;
  FocusNode _descFocus;
  FocusNode _taskFocus;

  bool _contentVisible = false;

  @override
  void initState(){

    if(widget.list != null) {
      // Set visibility to true
      _contentVisible = true;

      _listTitle = widget.list.title;
      _listDesc = widget.list.description;
      _listID = widget.list.id;
    }

    _titleFocus = FocusNode();
    _descFocus = FocusNode();
    _taskFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose(){

    _titleFocus.dispose();
    _descFocus.dispose();
    _taskFocus.dispose();
    super.dispose();
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
                          focusNode: _titleFocus,
                          onSubmitted: (value) async{
                            // Check if field is null
                            if(value != ""){
                              // Check if list is null
                              if(widget.list == null) {
                                TaskList newList = TaskList(title: value);
                                _listID = await _dbTool.insertList(newList);
                                setState(() {
                                  _contentVisible = true;
                                  _listTitle = value;
                                });
                              } else {
                                await _dbTool.updateListTitle(_listID, value);
                              }

                              _descFocus.requestFocus();
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
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 12.0,
                    ),
                    child: TextField(
                      focusNode: _descFocus,
                      onSubmitted: (value) {
                        if(value != ""){
                          if(_listID != 0){
                            _dbTool.updateListDesc(_listID, value);
                          }
                        }
                        _taskFocus.requestFocus();
                      },
                      controller: TextEditingController()..text = _listDesc,
                      decoration: InputDecoration(
                        hintText: "Enter Description for this list ...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: FutureBuilder(
                    initialData: [],
                    future: _dbTool.getTask(_listID),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async{
                                if(snapshot.data[index].isDone == 0){
                                  await _dbTool.updateTaskComplete(snapshot.data[index].id, 1);
                                } else {
                                  await _dbTool.updateTaskComplete(snapshot.data[index].id, 0);
                                }
                                setState(() {});
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
                ),
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
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
                                focusNode: _taskFocus,
                                controller: TextEditingController()..text = "",
                                onSubmitted: (value) async{
                                  // Check if field is null
                                  if(value != ""){
                                    // Check if list is null
                                    if(_listID != 0) {
                                      ToDo newToDo = ToDo(
                                        title: value,
                                        isDone: 0,
                                        taskID: _listID,
                                      );
                                      await _dbTool.insertTask(newToDo);
                                      setState(() {});
                                      _taskFocus.requestFocus();
                                    } else {
                                      print("Error creating task item");
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
                      ),
                )
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(_listID != 0){
            await _dbTool.deleteList(_listID);
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.blueGrey[900],
      ),
    );
  }
}
