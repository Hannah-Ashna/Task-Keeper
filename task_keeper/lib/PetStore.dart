import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Database.dart';
import 'Tasks.dart';
import 'Pet.dart';
import 'main.dart';

class PetStore extends StatefulWidget {
  @override
  _MyPetStore createState() => _MyPetStore();
}

class _MyPetStore extends State<PetStore> {

  DatabaseTool _dbTool = DatabaseTool();
  int money;


  @override
  void initState() {
    updateMoney();
    super.initState();
  }

  void updateMoney() async {
    money = await _dbTool.getMoney();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xff26547C),
        title: Text("Pet Store",
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
                  // Do Nothing - Stay Put
                  Navigator.pop(context);
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => LandingPage()),
                  );
                }
            ),
          ],
        ),
      ),

      body: Center (
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 15.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton.icon(
                    onPressed: () async {
                      money = await _dbTool.getMoney();
                      setState(() {});
                    },
                    icon: Icon(Icons.attach_money, color: Colors.black),
                    label: Text(money.toString(),
                        style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff06D6A0))),
                  ),
                ),
              ),
            ),
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
                      _dbTool.updateFood(2, context);
                      money = await _dbTool.getMoney();
                      setState(() {});
                    },
                  ),
                  FlatButton(
                    height: 60,
                    minWidth: 115,
                    child: Text("WATER"),
                    color: Colors.black87,
                    onPressed: () async {
                      _dbTool.updateWater(2, context);
                      money = await _dbTool.getMoney();
                      setState(() {});
                    },
                  ),
                  FlatButton(
                    height: 60,
                    minWidth: 115,
                    child: Text("TOYS"),
                    color: Colors.black87,
                    onPressed: () async {
                      _dbTool.updateToys(4, context);
                      money = await _dbTool.getMoney();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}