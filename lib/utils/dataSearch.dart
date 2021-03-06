import 'package:baatein/screens/chat_screen.dart';
import 'package:baatein/screens/homePage.dart';
import 'package:baatein/utils/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchUsers extends SearchDelegate {
  final UserCredentials authUser;
  SearchUsers({this.authUser});
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc("allusers")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data.data();
          List names = doc["names"];
          List phones = doc["phones"];
          List emails = doc["emails"];
          List photo_urls = doc["photo_urls"];
          final List namesList = [];
          final List phonesList = [];
          List nameList = [];
          List phoneList = [];
          if (query.isNotEmpty) {
            nameList = names
                .where((element) =>
                    element.contains(RegExp(query, caseSensitive: false)))
                .toList();
            phoneList = phones
                .where((element) =>
                    element.contains(RegExp(query, caseSensitive: false)))
                .toList();
          }

          for (int i = 0; i < phoneList.length; i++) {
            if (emails[phones.indexOf(phoneList[i])] != authUser.email)
              phonesList.add(phones.indexOf(phoneList[i]));
          }

          for (int i = 0; i < nameList.length; i++) {
            if (emails[names.indexOf(nameList[i])] != authUser.email)
              namesList.add(names.indexOf(nameList[i]));
          }

          return Column(
            children: [
              phonesList.isEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: namesList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                              leading: Icon(Icons.star_border_purple500_sharp, color: Colors.black87, size: 30,),
                              title: RichText(
                                text: TextSpan(
                                  text: names[namesList[index]],
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text("Lets get talking!",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              onTap: () async {
                                var user = {
                                  "name": names[namesList[index]],
                                  "email": emails[namesList[index]],
                                  "photo_url": photo_urls[namesList[index]],
                                };
                                await createDocument(user);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: phonesList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(photo_urls[phonesList[index]]),
                              ),
                              title: RichText(
                                text: TextSpan(
                                  text: names[phonesList[index]],
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text("Tap to add user",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              onTap: () async {
                                var user = {
                                  "name": names[phonesList[index]],
                                  "email": emails[phonesList[index]],
                                  "photo_url": photo_urls[phonesList[index]],
                                };
                                await createDocument(user);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        }
        if (snapshot.hasError) {
          return Center(
              child: Text(
            "OOPS!\n Some error occured\nCheck your internet connection speed\nSorry for the inconvenience :(",
            textAlign: TextAlign.center,
          ));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  createDocument(Map<String, dynamic> user) async {
    final authUserRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(authUser.email)
        .collection("Chats")
        .doc(user["email"]);

    final userRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user["email"])
        .collection("Chats")
        .doc(authUser.email);

    return await authUserRef.get().then((docSnapshot) {
      if (!docSnapshot.exists) {
        authUserRef
            .set({
              "name": user["name"],
              "email": user["email"],
              // "phone": user["phone"],
              "photo_url": user["photo_url"],
              "chats": [
                {
                  "message": "hello from baatein team",
                  "sender": user["email"],
                  "timestamp": DateTime.now(),
                },
                {
                  "message": "you can start chatting here",
                  "sender": authUser.email,
                  "timestamp": DateTime.now(),
                },
              ]
            })
            .then((value) => print("User's Document Added"))
            .catchError((error) =>
                print("Failed to add user: $error")); // create the document

        userRef
            .set({
              "name": authUser.displayName,
              "email": authUser.email,
              // "phone": authPhone,
              "photo_url": user["photo_url"],
              "chats": [
                {
                  "message": "hello from baatein team",
                  "sender": user["email"],
                  "timestamp": DateTime.now(),
                },
                {
                  "message": "you can start chatting here",
                  "sender": authUser.email,
                  "timestamp": DateTime.now(),
                },
              ]
            })
            .then((value) => print("User's Document Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
  }
}
