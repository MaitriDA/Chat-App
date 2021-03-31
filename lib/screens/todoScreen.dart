import 'package:baatein/authentication/authService.dart';
import 'package:baatein/utils/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
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
                                    final authServiceProvider =
                                    Provider.of<AuthService>(context, listen: false);
                                    final authService = authServiceProvider.getCurrentUser();
                                    var task_tilte = taskTitleController.text;
                                    var task_description = taskDescriptionController.text;
                                    setState(() {
                                      taskTitleController.clear();
                                      taskDescriptionController.clear();
                                    });
                                    if (task_tilte != "") {
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(authService.currentUser().email)
                                          .update({
                                        "to-do": FieldValue.arrayUnion([
                                          {
                                            "task_tilte": task_tilte,
                                            "task_description": task_description,
                                            "task_time": DateTime.now(),
                                            "task_completion": isComplete,
                                          }
                                        ])
                                      });
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(25),
          color: Color(0xFFBFEEFEC),
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
              shrinkWrap: true,
              itemCount: 5,
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
                    "Todo title",
                    style: isComplete
                        ? TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w500)
                        : TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              }),
        ));
  }
}
