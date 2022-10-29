import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lab10/Home.dart';
import 'package:lab10/loginScreens/Log_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
// login  with email and password
  Future logInWithEmailAndPassword(
      String email, String password, context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sorry there is an error")));
    }
  }

  

  // signUp with email and password
  Future signUpWithEmailAndPassword(
      String email, String password, context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sorry there is an error")));
    }
  }

//signUp With UserName Email And Password
  Future signUpWithUserNameEmailAndPassword(
      String email, String password, String userName, context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore.instance
          .collection("UsersData")
          .add({"username": userName, "email": email, "role": "user"});
      Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sorry there is an error")));
    }
  }

  
}
