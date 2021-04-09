import 'package:baatein/utils/inputWithIcon.dart';
import 'package:baatein/authentication/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class SetProfile extends StatefulWidget {
  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("Users");
  TextEditingController nameController = TextEditingController();
  String photoUrl;
  double _progress = 0;

  List avatars = [
    "avatar1.jpg",
    "avatar2.jpg",
    "avatar3.jpg",
    "avatar4.jpg",
    "avatar5.jpg",
    "avatar6.jpg",
  ];

  void startTimer() {
    new Timer.periodic(
      Duration(milliseconds: 70),
      (Timer timer) => setState(
        () {
          if (_progress == 1) {
            timer.cancel();
          } else {
            _progress += 0.2;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthService>(context).currentUser();
    var userRef = FirebaseFirestore.instance.collection("Users");
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color(0xFFB0C2637),
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              await firebaseAuth.currentUser.updateProfile(photoURL: photoUrl);
              // // Update authUser's photoUrl
              // await userRef.doc(authUser.email).update({
              //   "photo_url": photoUrl,
              // });

              // Update authUser's photoUrl for others
              await userRef
                  .doc(authUser.email)
                  .collection("Chats")
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) async {
                  await userRef
                      .doc(doc.id)
                      .collection("Chats")
                      .doc(authUser.email)
                      .update({
                    "photo_url": photoUrl,
                  });
                });
              });
              Navigator.popAndPushNamed(context, "/home");
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  radius: 100.0,
                  backgroundImage:
                      AssetImage("assets/images/" + authUser.photoUrl),
                  // backgroundImage: AssetImage("assets/images/noprofile.png"),
                ),
              ),
              Text(
                authUser.displayName ?? "username",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1,
                    fontSize: 18,
                    height: 2),
              ),
              SizedBox(height: 20,),
              LinearProgressIndicator(
                minHeight: 1,
                backgroundColor: Colors.black12,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black54),
                value: _progress,
              ),
              SizedBox(height: 15,),
              Center(
                child: Text(
                  "CHOOSE AN AVATAR",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 1,
                      fontSize: 12,
                      height: 3),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 25,
                  children: List.generate(avatars.length, (index) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          _progress = 0;
                          photoUrl = avatars[index];
                        });
                        startTimer();
                        await firebaseAuth.currentUser
                            .updateProfile(photoURL: photoUrl);
                        // Update authUser's photoUrl
                        await userRef.doc(authUser.email).update({
                          "photo_url": photoUrl,
                        });
                        setState(() {
                          _progress = 0;
                        });
                        setState(() {});
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundImage:
                              AssetImage("assets/images/" + avatars[index]),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _progress = 0;
                    photoUrl = "noprofile.png";
                  });
                  startTimer();
                  await firebaseAuth.currentUser
                      .updateProfile(photoURL: photoUrl);
                  // Update authUser's photoUrl
                  await userRef.doc(authUser.email).update({
                    "photo_url": photoUrl,
                  });
                  setState(() {
                    _progress = 0;
                  });
                  setState(() {});
                },
                child: Center(
                  child: Text(
                    "OR REMOVE AVATAR",
                    style: TextStyle(
                      color: Colors.red,
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
