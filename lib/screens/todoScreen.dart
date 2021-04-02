import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baatein/utils/todo_model.dart';
import 'package:baatein/authentication/todo-services.dart';
import 'package:flutter/widgets.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference UsersCollection =
      FirebaseFirestore.instance.collection("Users");
  bool isComplete = false;
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

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
                                    var title = taskTitleController.text;
                                    var descript =
                                        taskDescriptionController.text;
                                    if (taskTitleController.text.isNotEmpty) {
                                      await ToDoDatabaseService().createTodo(
                                          title, descript, isComplete);
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").doc(firebaseAuth.currentUser.email).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                  var docRef = snapshot.data;
                  var todos = docRef["to-do"];
                return ListView.builder(
                  reverse: true,
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final Todo todo = Todo(
                          task_title: todos[index]["task_title"],
                          task_description: todos[index]["task_description"],
                          task_time: todos[index]["task_time"]
                              .toDate()
                              .toString(),
                          isComplete: todos[index]["task_completion"]);
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
                                      vertical: 20, horizontal: 30),
                                  backgroundColor: Colors.grey.shade100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Center(
                                    child: Text(
                                      todo.task_title,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          letterSpacing: 1,
                                          fontSize: 20),
                                    ),
                                  ),
                                  children: [
                                    Divider(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                Center(
                                  child: Text(
                                    todo.task_description,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black54
                                    ),
                                  ),
                                ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        todo.task_time,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
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
                                      width: MediaQuery.of(context).size.width*0.5,
                                    )
                                  ],
                                ));
                          },
                          // leading: isComplete
                          //     ? Icon(
                          //         Icons.check_box_outlined,
                          //         size: 22,
                          //         color: Colors.black87,
                          //       )
                          //     : Icon(
                          //         Icons.check_box_outline_blank,
                          //         size: 22,
                          //         color: Colors.black87,
                          //       ),
                            leading: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.check_box_outline_blank),
                            ),
                          title: Text(
                            todo.task_title??'default value',
                            style: isComplete
                                ? TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w500)
                                : TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            todo.task_description??'default value',
                            style: TextStyle(fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          trailing: IconButton(
                            onPressed: ()async{
                              try {
                                await ToDoDatabaseService().removeTodo(
                                    todo.task_title, todo.task_description, todo.isComplete, todo.task_time);
                                print('delete successful');
                              }catch(e){
                                print('error in deletion');
                              }
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              size: 22,
                              color: Colors.black87,),
                          )
                        ),
                      );
                    });
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Please check your internet connection"),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
