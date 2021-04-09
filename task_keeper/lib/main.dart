import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_keeper/Tasks.dart';
import 'package:task_keeper/login.dart';
import 'dart:core';


void main() async{
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }

  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          setState(() => _message = message["notification"]["title"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }

  // This is the Root of the Application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Scaffold (
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        if(snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;

                if (user == null) {
                  // User Status - not Logged in
                  return Login();

                } else {
                  // User Status - is Logged in
                  return Tasks();
                }
              }

              return Scaffold (
                body: Center (
                  child: Text("Connecting to the app ..."),
                ),
              );
            }
          );
        }

        return Scaffold (
          body: Center (
            child: Text("Connecting to the app ..."),
          ),
        );
      },
    );
  }
}



