import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baatein/utils/todo_model.dart';
import 'package:baatein/authentication/todo-services1.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class ToDoList1 extends StatefulWidget {
  @override
  _ToDoListState1 createState() => _ToDoListState1();
}

class _ToDoListState1 extends State<ToDoList1> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("Users");
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController editTitle = TextEditingController();
  TextEditingController editDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBFEEFEC),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color(0xFFB0C2637),
        title: Text(
          "What To-Do?",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => new SimpleDialog(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          backgroundColor: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Center(
                            child: Text(
                              "Add To-Do",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 1,
                                  fontSize: 20),
                            ),
                          ),
                          children: [
                            Divider(),
                            TextFormField(
                              maxLength: 15,
                              controller: taskTitleController,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  hintText: "Task Title",
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              maxLength: 25,
                              controller: taskDescriptionController,
                              textCapitalization: TextCapitalization.sentences,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                              decoration: InputDecoration(
                                  hintText: "Task Description",
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w100)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  var title = taskTitleController.text;
                                  var descript = taskDescriptionController.text;
                                  if (taskTitleController.text.isNotEmpty) {
                                    await TodoService()
                                        .createNewTodo(title, descript);
                                    setState(() {
                                      taskTitleController.clear();
                                      taskDescriptionController.clear();
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text("Done"),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Theme.of(context).primaryColor,
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width,
                            )
                          ],
                        ));
              }),
        ],
      ),
      body: StreamBuilder(

          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(firebaseAuth.currentUser.email)
              .collection("To-Do").orderBy("task_time")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Fetching the data
              List<DocumentSnapshot> documents = snapshot.data.docs;

              var todos = documents.map((doc) {
                return Todo(
                  isComplete: doc["task_completion"],
                  task_title: doc["task_title"],
                  task_description: doc["task_description"],
                  task_time: doc["task_time"].toDate().toString(),
                  task_uid: doc.id,
                );
              }).toList();

              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final DateTime docDateTime = DateTime.parse(todos[index].task_time);
                  var time = DateFormat("dd MMM HH:mm").format(docDateTime);
                  return Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => new SimpleDialog(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                backgroundColor: Colors.grey.shade100,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(
                                  "Edit To-do",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      letterSpacing: 1,
                                      fontSize: 20),
                                ),
                                children: [
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Title: '),
                                      Text(todos[index].task_title,
                                        overflow: TextOverflow.visible,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Desc: '),
                                      Text(todos[index].task_description,
                                      overflow: TextOverflow.visible,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Created on: '),
                                      Text(time),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    maxLength: 15,
                                    controller: editTitle,
                                    textCapitalization: TextCapitalization.words,
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                        hintText: "New Title",
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w200)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    maxLength: 25,
                                    controller: editDescription,
                                    textCapitalization: TextCapitalization.sentences,
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                        hintText: "New Description",
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w100)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        var newTitle = editTitle.text;
                                        var newDescript = editDescription.text;
                                        if (editTitle.text.isNotEmpty) {
                                          await TodoService().updateTask(todos[index].task_uid, newTitle, newDescript);
                                          setState(() {
                                            editTitle.clear();
                                            editDescription.clear();
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text("Edit"),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        primary: Theme.of(context).primaryColor,
                                      )),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                  )
                                ],
                              ));
                        },
                        leading: IconButton(
                          onPressed: () {
                            TodoService().completeTask(todos[index].task_uid, todos[index].isComplete);
                          },
                          icon: todos[index].isComplete
                              ? Icon(
                                  Icons.check_box_outlined,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                ),
                        ),
                        title: Text(
                          todos[index].task_title,
                          style: todos[index].isComplete
                              ? TextStyle(decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w500)
                              : TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: todos[index].task_description!=""? Text(
                          todos[index].task_description,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ):Container(child: null,),
                        trailing: IconButton(
                          onPressed: () async {
                            try {
                              await TodoService()
                                  .removeTodo(todos[index].task_uid);
                              print('delete successful');
                            } catch (e) {
                              print('error in deletion');
                            }
                          },
                          icon: Icon(
                            Icons.delete_outline,
                          ),
                        )),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Please check your internet connection"),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
