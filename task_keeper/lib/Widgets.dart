import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title, desc;
  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        top: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
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
              desc ?? "Hello User! Welcome to Task Keeper; ready to be productive?",
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