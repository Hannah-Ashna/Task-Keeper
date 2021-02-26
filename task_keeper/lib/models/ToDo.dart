class ToDo{
  final int id;
  final String title;
  final int taskID;
  final int isDone;

  // Class Constructor
  ToDo({this.id, this.title, this.taskID, this.isDone});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'isDone': isDone,
      'taskID' : taskID,
    };
  }
}