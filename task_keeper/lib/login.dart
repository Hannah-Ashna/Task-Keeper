import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_keeper/Tasks.dart';
import 'package:task_keeper/Database.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

void showAlertDialog(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert:'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Accept'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class _LoginState extends State<Login> {
  String _email;
  String _password;

  Future<void> _createUser() async {
    try {
      showAlertDialog(context, "Creating user ...");
      UserCredential userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      );
      // Initialise Game Components - Inventory and Pet Details
      DatabaseTool _dbTool = DatabaseTool();
      _dbTool.initPetData();
      _dbTool.initInventory();


    } on FirebaseAuthException catch (e){
      showAlertDialog(context, "Error!\n$e");
    } catch (e) {
      showAlertDialog(context, "Error! Account could not be created");
    }
  }

  Future<void> _loginUser() async {
    try {
      showAlertDialog(context, "Logging in ...");
      UserCredential userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
      // Initialise Game Components - Inventory and Pet Details
      DatabaseTool _dbTool = DatabaseTool();
      _dbTool.initPetData();
      _dbTool.initInventory();

      var newDate = DateTime.now();
      await _dbTool.setLoginData(newDate.toString());


    } on FirebaseAuthException catch (e){
      showAlertDialog(context, "Error! Invalid Credentials");
    } catch (e) {
      showAlertDialog(context, "Error! Invalid Credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SingleChildScrollView(
        child: Padding(
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
                obscureText: true,
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
      ),
    );
  }
}

