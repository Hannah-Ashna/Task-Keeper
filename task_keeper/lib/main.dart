import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Center(child: Text("Task Keeper")),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Center(
          child: Image(
            image: NetworkImage("https://raw.githubusercontent.com/Hannah-Ashna/Garfield-Spigot-Plugin/main/Screenshots/octogarf.png"),
          ),
        ),
      ),
    ),
  );
}
