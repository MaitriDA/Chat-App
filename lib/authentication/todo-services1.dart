import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:baatein/utils/todo_model.dart';

class TodoService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference UsersCollection = FirebaseFirestore.instance.collection("Users");

  Future createNewTodo(String title, String description) async {
    return await UsersCollection
        .doc(firebaseAuth.currentUser.email)
        .collection("To-Do")
        .add({
      "task_title": title,
      "task_description": description,
      "task_time": DateTime.now(),
      "task_completion": false,
    });
  }

  Future completeTask(uid) async {
    await UsersCollection
        .doc(firebaseAuth.currentUser.email)
        .collection("To-Do")
        .doc(uid)
        .update({"task_completion": true});
  }

  Future removeTodo(uid) async {
    await UsersCollection
        .doc(firebaseAuth.currentUser.email)
        .collection("To-Do")
        .doc(uid)
        .delete();
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          isComplete: e.data()["task_completion"],
          task_title: e.data()["task_title"],
          task_description: e.data()["task_description"],
          task_time: e.data()["task_time"],
          task_uid: e.id,
        );
      }).toList();
    } else {
      return null;
    }
  }

  Stream<List<Todo>> listTodos() {
    return UsersCollection
        .doc(firebaseAuth.currentUser.email)
        .collection("To-Do")
        .snapshots()
        .map(todoFromFirestore);
  }
}