import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  var check_box_state = Icons.check_box_outline_blank_sharp;
  var check_text_state = null;

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
                                height: 50,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
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
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: GestureDetector(
                      onTap: () {
                        if (check_box_state ==
                            Icons.check_box_outline_blank_sharp) {
                          setState(() {
                            check_box_state = Icons.check_box_sharp;
                            check_text_state = TextDecoration.lineThrough;
                          });
                        } else {
                          setState(() {
                            check_box_state =
                                Icons.check_box_outline_blank_sharp;
                            check_text_state = null;
                          });
                        }
                        ;
                      },
                      child: Icon(
                        check_box_state,
                        size: 22,
                        color: Colors.black87,
                      )),
                  title: Text(
                    "Todo title",
                    style: TextStyle(
                        decoration: check_text_state,
                        fontWeight: FontWeight.w500),
                  ),
                );
              }),
        ));
  }
}
