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

  Future removeTodo(int i) async {
    await UsersCollection.doc(firebaseAuth.currentUser.email).update({"to-do":FieldValue.arrayRemove(["to-do"[i]],)});
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          isComplete: e.data()["task_completion"],
          task_title: e.data()["task_title"],
          task_description: e.data()["task_description"],
          task_time: e.data()["task_time"],
        );
      }).toList();
    } else {
      return null;
    }
  }

  Stream<List<Todo>> listTodos() {
    return UsersCollection.snapshots().map(todoFromFirestore);
  }
}