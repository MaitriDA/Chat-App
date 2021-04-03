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

  Future completeTask(uid, isComplete) async {
    await UsersCollection
        .doc(firebaseAuth.currentUser.email)
        .collection("To-Do")
        .doc(uid)
        .update({"task_completion": !isComplete});
  }

  Future updateTask(uid, title, description) async {
    await UsersCollection
        .doc(firebaseAuth.currentUser.email)
        .collection("To-Do")
        .doc(uid)
        .update({
      "task_title": title,
      "task_description": description,});
  }

  Future removeTodo(uid) async {
    await UsersCollection
        .doc(firebaseAuth.currentUser.email)
        .collection("To-Do")
        .doc(uid)
        .delete();
  }


}