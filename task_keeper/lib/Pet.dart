import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_keeper/PetChart.dart';
import 'Tasks.dart';
import 'PetStore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:task_keeper/PetDataModel.dart';
import 'Database.dart';


class Pet extends StatefulWidget {
  @override
  _MyPetState createState() => _MyPetState();
}

class _MyPetState extends State<Pet> {

  DatabaseTool _dbTool = DatabaseTool();
  List<PetDataModel> data = [
    PetDataModel(
      title: "Hunger",
      value: 0,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
    PetDataModel(
      title: "Thirst",
      value: 0,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
    PetDataModel(
      title: "Happiness",
      value: 0,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
    ];


  bool _isVisible = false;
  bool _isAwake = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xff26547C),
        title: Text("My Pet",
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => Tasks()),
                );
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
                // Do Nothing - Stay Put
                Navigator.pop(context);
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

      body: Center(
        child: new Column (
          children: <Widget>[

            // Display only when Pet is Asleep
            Visibility(
              visible: !_isAwake,
              child: Container(
                margin: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 25,
                  right: 5,
                ),
                child: Image.asset("Images/KevinSleep.gif", width: 250, height: 250),
              ),
            ),

            Visibility(
              visible: !_isVisible,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: new ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FlatButton(
                            height: 60,
                            minWidth: 115,
                            child: Text("Wake up Kevin!"),
                            color: Colors.black87,
                            onPressed: () async {
                              data[0].value = await _dbTool.getHunger();
                              data[1].value = await _dbTool.getThirst();
                              data[2].value = await _dbTool.getHappiness();
                              _isVisible = !_isVisible;
                              _isAwake = !_isAwake;
                              setState(() {});
                            },
                          ),],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Display only when Pet is Awake
            Visibility(
            visible: _isAwake,
              child: Container(
                margin: EdgeInsets.all(15),
                child: Image.asset("Images/KevinAwake.gif", width: 250, height: 250),
              ),
            ),

            Visibility(
              visible: _isVisible,
              child: Container(
                child: PetChart(data: data),
              ),
            ),

            Visibility(
              visible: _isVisible,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: new ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FlatButton(
                            height: 60,
                            minWidth: 115,
                            child: Text("FOOD"),
                            color: Colors.black87,
                            onPressed: () async {
                              await _dbTool.updateHunger(5);
                              data[0].value = await _dbTool.getHunger();
                              setState(() {});
                            },
                          ),
                          FlatButton(
                            height: 60,
                            minWidth: 115,
                            child: Text("WATER"),
                            color: Colors.black87,
                            onPressed: () async {
                              await _dbTool.updateThirst(5);
                              data[1].value = await _dbTool.getThirst();
                              setState(() {});
                            },
                          ),
                          FlatButton(
                            height: 60,
                            minWidth: 115,
                            child: Text("TOYS"),
                            color: Colors.black87,
                            onPressed: () async {
                              await _dbTool.updateHappiness(5);
                              data[2].value = await _dbTool.getHappiness();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}