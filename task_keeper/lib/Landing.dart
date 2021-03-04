import 'package:flutter/material.dart';
import 'package:task_keeper/Tasks.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: new Column(
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage("Images/TKLogo.png"),
              ),
            ),

            Container(
              child: ElevatedButton(
                child: Text("Start",
                  style: TextStyle(
                      fontFamily: 'Aleo',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => Tasks()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}