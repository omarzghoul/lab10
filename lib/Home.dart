import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lab10/info.dart';
import 'package:lab10/service/Firestore.dart';
import 'package:lab10/service/auth.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedRadio = "";
  bool a = true;

  Color col() {
    if (FirebaseAuth.instance.currentUser!.email.toString().contains("red"))
      return Colors.red;
    else if (FirebaseAuth.instance.currentUser!.email
        .toString()
        .contains("green")) return Colors.green;
    if (FirebaseAuth.instance.currentUser!.email.toString().contains("blue"))
      return Colors.blue;

    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col(),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile(
              value: "admin",
              title: Text("admin"),
              groupValue: selectedRadio,
              onChanged: (value) async {
                QuerySnapshot snap = await FirebaseFirestore.instance
                    .collection("UsersData")
                    .where("email",
                        isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .get();

                update(snap.docs[0].id, "admin");

                setState(() {
                  selectedRadio = value.toString();
                });
              },
            ),
            RadioListTile(
              value: "user",
              title: Text("user"),
              groupValue: selectedRadio,
              onChanged: (value) async {
                QuerySnapshot snap = await FirebaseFirestore.instance
                    .collection("UsersData")
                    .where("email",
                        isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .get();

                update(snap.docs[0].id, "user");
                setState(() {
                  selectedRadio = value.toString();
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Info_screen(),
                      ));
                },
                child: Text("Next"))
          ],
        ),
      ),
    );
  }
}
