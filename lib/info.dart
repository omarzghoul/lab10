import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lab10/service/auth.dart';

class Info_screen extends StatelessWidget {
  Info_screen({super.key});

  Stream<QuerySnapshot> getStream() async* {
    yield* FirebaseFirestore.instance
        .collection("UsersData")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  CollectionReference getdata =
      FirebaseFirestore.instance.collection("UsersData");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getStream(),
              builder: (context, snapshot) {
                return Center(
                  child: Column(
                    children: [
                      Text(snapshot.data!.docs[0]["username"]),
                      Text(snapshot.data!.docs[0]["email"]),
                      Text(snapshot.data!.docs[0]["role"]),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
