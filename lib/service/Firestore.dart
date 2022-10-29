import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab10/service/auth.dart';

FirebaseFirestore instance = FirebaseFirestore.instance;
AuthService _auth = AuthService();





// delete(id) {
//   instance.collection("UsersData").doc(id).delete();
// }

update( id, rule) {
  instance.collection("UsersData").doc(id).update({
    
    'role': rule,
  });
}


