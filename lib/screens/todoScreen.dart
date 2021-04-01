import 'package:baatein/authentication/authService.dart';
import 'package:baatein/utils/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baatein/utils/todo_model.dart';
import 'package:baatein/authentication/todo-services.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference UsersCollection = FirebaseFirestore.instance.collection("Users");
  bool isComplete = false;
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                height: 30,
                              ),
                              TextFormField(
                                controller: taskDescriptionController,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
                                    hintText: "Task Description",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100)),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (taskTitleController.text.isNotEmpty) {
                                      await ToDoDatabaseService()
                                          .createTodo(taskTitleController.text, taskDescriptionController.text, isComplete);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text("Done"),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    primary: Theme.of(context).primaryColor,
                                  )),
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "BACK",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        letterSpacing: 1,
                                        fontSize: 12),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width,
                              )
                            ],
                          ));
                }),
          ],
        ),
        body: StreamBuilder<List<Todo>>(
            stream: ToDoDatabaseService().listTodos(),
            builder: (BuildContext context, snapshot) {
              List<Todo> todos = snapshot.data;
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(25),
                color: Color(0xFFBFEEFEC),
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                        ),
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            isComplete = !isComplete;
                          });
                        },
                        leading: isComplete
                            ? Icon(
                                Icons.check_box_outlined,
                                size: 22,
                                color: Colors.black87,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 22,
                                color: Colors.black87,
                              ),
                        title: Text(
                          todos[index].task_title,
                          style: isComplete
                              ? TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w500)
                              : TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                      todos[index].task_description,
                          style: TextStyle(fontWeight: FontWeight.w500),),
                        trailing: GestureDetector(
                          onTap: () async{
                            await ToDoDatabaseService().removeTodo(todos[index].task_title, todos[index].task_description, todos[index].isComplete);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 22,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }),
              );
            }));
  }
}
