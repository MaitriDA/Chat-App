import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baatein/utils/todo_model.dart';

class ToDoDatabaseService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference UsersCollection = FirebaseFirestore.instance.collection("Users");

  Future createTodo(String title, String description, bool isComplete) async {
    return await UsersCollection.doc(firebaseAuth.currentUser.email).update({
      "to-do": FieldValue.arrayUnion([
        {
          "task_title": title,
          "task_description": description,
          "task_time": DateTime.now(),
          "task_completion": isComplete
        }
      ])
    });
  }

  // Future completeTask(uid) async {
  //   await UsersCollection.doc(firebaseAuth.currentUser.email).update({"to-do":FieldValue.});
  // }

  Future removeTodo(String title, String description, bool isComplete, String task_time) async {
    await UsersCollection.doc(firebaseAuth.currentUser.email).update({
      "to-do": FieldValue.arrayRemove([
        {
          "task_title": title,
          "task_description": description,
          "task_time": task_time,
          "task_completion": isComplete
        }
      ])
    });
  }
}