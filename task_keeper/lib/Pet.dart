import 'package:flutter/material.dart';
import 'package:task_keeper/PetChart.dart';
import 'Tasks.dart';
import 'PetStore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:task_keeper/PetDataModel.dart';
import 'package:flutter/material.dart';

class Pet extends StatelessWidget {
  final List<PetDataModel> data = [
    PetDataModel(
      title: "Hunger",
      value: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    PetDataModel(
      title: "Thirst",
      value: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    PetDataModel(
      title: "Happiness",
      value: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
  ];



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
          ],
        ),
      ),

      body: Center(
        child: PetChart(data: data),
      ),
    );
  }
}