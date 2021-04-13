import 'package:baatein/authentication/authService.dart';
import 'package:baatein/screens/aboutUs.dart';
import 'package:baatein/screens/todo-screen1.dart';
import 'package:baatein/utils/dataSearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:baatein/utils/message_model.dart';
import 'setProfile.dart';
import 'package:baatein/screens/chat_screen.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({this.imageFile});
  final File imageFile;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    final authUser = Provider.of<AuthService>(context).getCurrentUser();
    final user = Provider.of<AuthService>(context).currentUser();
    print(authUser.currentUser().photoUrl);
    print(authUser.currentUser().displayName);
    print(authUser.currentUser().email);

    // if(authUser.currentUser().photoUrl == null || authUser.currentUser().displayName == null){
    //   authUser.currentUser().photoUrl = "noprofile.png";
    //   authUser.currentUser().displayName = "You";
    // }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          backgroundColor: Color(0xFFB0C2637),
          title: Text('Chats'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: SearchUsers(authUser: user));
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                            radius: 70.0,
                            backgroundImage: AssetImage("assets/images/" + authUser.currentUser().photoUrl ?? "noprofile.png"),
                          // backgroundImage: AssetImage("assets/images/noprofile.png"),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: Text(
                          authUser.currentUser().displayName ?? "username",
                          style: TextStyle(
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SetProfile()),
                            );
                          },
                          leading: Icon(Icons.person),
                          title: Text(
                            'My Profile',
                            style: TextStyle(
                                letterSpacing: 1, color: Colors.black54),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ToDoList1()),
                            );
                          },
                          leading: Icon(Icons.star_border),
                          title: Text(
                            'What To-Do?',
                            style: TextStyle(
                                letterSpacing: 1, color: Colors.black54),
                          ),
                        ),
                        // ListTile(
                        //   leading: Icon(Icons.screen_share_outlined),
                        //   title: Text('Our Web App',
                        //       style: TextStyle(
                        //           letterSpacing: 1,
                        //           color: Colors.black54
                        //       )),
                        // ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUs()),
                            );
                          },
                          leading: Icon(Icons.privacy_tip_outlined),
                          title: Text(
                            'About Us',
                            style: TextStyle(
                                letterSpacing: 1, color: Colors.black54),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            try {
                              authUser.signOutUser();
                              print("SignOut Successful!");
                              Navigator.pushNamedAndRemoveUntil(context, "/",
                                  (Route<dynamic> route) => false);
                            } catch (e) {
                              print(e);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Logout Error"),
                                    content: Text(
                                        "Some error occured!\nYou are still Signed In"),
                                    actions: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 10),
                                        child: TextButton(
                                          child: Text("Try Again"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          leading: Icon(Icons.logout),
                          title: Text(
                            'Log Out',
                            style: TextStyle(
                                letterSpacing: 1, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(user.email)
                .collection("Chats")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Fetching the data
                final List<DocumentSnapshot> documents = snapshot.data.docs;

                var usersList = documents.map((doc) {
                  var lastMessage;
                  if (doc["chats"] == []) {
                    lastMessage = "";
                  } else {
                    lastMessage = doc["chats"][doc["chats"].length - 1];
                  }
                  return {
                    "name": doc["name"],
                    "email": doc.id,
                    "last_message": lastMessage,
                    "photo_url": doc["photo_url"]
                  };
                }).toList();
                return ListView.separated(
                  itemCount: usersList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 3,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var time;
                    var text;
                    if (usersList[index]["last_message"] == "") {
                      text = "";
                    } else {
                      var timestamp = usersList[index]["last_message"]
                              ["timestamp"]
                          .toDate()
                          .toString();
                      final DateTime docDateTime = DateTime.parse(timestamp);
                      time = DateFormat("dd MMM HH:mm").format(docDateTime);
                      var message = usersList[index]["last_message"]["message"]
                          .toString();
                      text = message;
                    }
                    final Message chat = Message(
                      sender: usersList[index]["email"],
                      time: time,
                      text: text,
                      senderName: usersList[index]["name"],
                      unread: false,
                    );
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              user: usersList[index]["name"],
                              userEmail: usersList[index]["email"],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Container(
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                            )
                          ]),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("assets/images/" + usersList[index]["photo_url"]),
                            // backgroundImage:
                            //     NetworkImage(usersList[index]["photo_url"]),
                          ),
                        ),
                        title: Text(
                          chat.senderName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          chat.text,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        trailing: Text(
                          chat.time,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.black54,
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
