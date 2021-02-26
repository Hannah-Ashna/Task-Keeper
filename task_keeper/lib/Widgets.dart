import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title, desc;
  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        top: 16.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFFFCF9),
        borderRadius:BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding (
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              desc ?? "No Description ...",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToDoWidget extends StatelessWidget{
  final String text;
  final bool isDone;
  ToDoWidget({this.text, @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 24.0,
        left: 24.0,
        bottom: 10.0,
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
              color: isDone ? Colors.grey : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: isDone? null : Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: isDone ? Icon(Icons.check) : null,
          ),
          Flexible(
            child: Text(
                text ?? "(Unnamed Task)",
                style: TextStyle(
                  color: isDone ? Colors.black : Colors.grey[600],
                  fontSize: 16.0,
                  fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                ),
            ),
          ),
        ],
      ),
    );
  }
}

// Removes the Glow effect whenever a user tries to scroll
class NoGlow extends ScrollBehavior{
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection){
    return child;
  }
}