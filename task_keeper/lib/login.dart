import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_keeper/Tasks.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;

  Future<void> _createUser() async {
    try {
      UserCredential userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } on FirebaseAuthException catch (e){
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _loginUser() async {
    try {
      UserCredential userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } on FirebaseAuthException catch (e){
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          right: 16.0,
          left: 16.0,
        ),
        child: Column (

          children: [
            Image(
              image: AssetImage("Images/TKLogo.png"),
            ),
            TextField(
              onChanged: (value){
                _email = value;
              },
              decoration: InputDecoration(
                hintText: "Enter Email..."
              ),
            ),

            TextField(
              onChanged: (value){
                _password = value;
              },
              decoration: InputDecoration(
                hintText: "Enter Password..."
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    right: 4.0,
                  ),
                  child: FlatButton(
                    child: Text("Login"),
                    onPressed: _loginUser,
                    color: Color(0xFFEF476F),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 4.0,
                  ),
                  child: FlatButton(
                    child: Text("Create Account"),
                    onPressed: _createUser,
                    color: Color(0xFFEF476F),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

