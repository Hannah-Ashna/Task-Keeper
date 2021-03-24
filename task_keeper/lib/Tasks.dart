import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_keeper/Widgets.dart';
import 'package:task_keeper/TaskPage.dart';
import 'package:task_keeper/Database.dart';
import 'Pet.dart';
import 'PetStore.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State <Tasks> {
  @override
  Widget build(BuildContext context) {

    DatabaseTool _dbTool = DatabaseTool();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xff26547C),
        title: Text("Tasks",
          style: TextStyle(
            fontFamily: 'Aleo',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.white
          ),
        ),
      ),

      // Hamburger Menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Images/TKLogo.png"),
                    fit: BoxFit.cover
                ),
              ),
            ),

            ListTile(
              title: Text('Tasks',
                style: TextStyle(
                    fontFamily: 'Aleo',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black
                ),
              ),
              onTap: () {
                // Do Nothing - Stay Put
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text('My Pet',
                style: TextStyle(
                    fontFamily: 'Aleo',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => Pet()),
                );
              },
            ),

            ListTile(
                title: Text('Pet Store',
                  style: TextStyle(
                      fontFamily: 'Aleo',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => PetStore()),
                  );
                }
            ),

            ListTile(
                title: Text('Sign Out',
                  style: TextStyle(
                      fontFamily: 'Aleo',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black
                  ),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                }
            ),
          ],
        ),
      ),

      // The Actual To-do list content
      body: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            bottom: 16.0,
            left: 15.0,
            right: 15.0,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbTool.getList(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlow(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TaskPage(
                                      list: snapshot.data[index],
                                    )),
                                  ).then((value){setState(() {});});
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                  desc: snapshot.data[index].description,
                                ),
                              );
                              },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // The options menu
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) => TaskPage(list: null)),
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFEF476F),
      ),
    );
  }
}