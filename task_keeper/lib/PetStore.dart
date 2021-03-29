import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Tasks.dart';
import 'Pet.dart';

class PetStore extends StatelessWidget {
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
                }
            ),
          ],
        ),
      ),
    );
  }
}