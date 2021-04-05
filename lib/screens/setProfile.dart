import 'package:baatein/utils/inputWithIcon.dart';
import 'package:baatein/authentication/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetProfile extends StatefulWidget {
  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("Users");

  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String photoUrl = "noprofile.png";

  String userName;

  List avatars = [
    "avatar1.jpg",
    "avatar2.jpg",
    "avatar3.jpg",
    "avatar4.jpg",
    "avatar5.jpg",
    "avatar6.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthService>(context).currentUser();
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

              var userRef = FirebaseFirestore.instance.collection("Users");
              await firebaseAuth.currentUser.updateProfile(displayName: nameController.text ,photoURL: photoUrl);
              // Update authUser's photoUrl
              await userRef.doc(authUser.email).update({
                "photo_url": photoUrl,
              });

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
          padding: const EdgeInsets.all(10.0),
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
                  // backgroundImage: _pickedImage == null
                  //     ? AssetImage("assets/images/noprofile.png")
                  //     : FileImage(File(_pickedImage.path))
                  backgroundImage: AssetImage("assets/images/" + photoUrl),
                ),
              ),
              Form(
                key: formKey,
                child: InputWithIcon(
                  btnIcon: Icons.account_circle_rounded,
                  hintText: authUser.displayName,
                  myController: nameController,
                  keyboardType: TextInputType.name,
                  validateFunc: (value) async {
                    var docRef = await FirebaseFirestore.instance.collection("Users").doc("allusers").get();
                    var docData = docRef.data();
                    if(docData["names"].contains)
                    if (value.isEmpty) return 'Name Required';
                    return null;
                  },
                ),
              ),
              Center(
                child: Text(
                  "AVATARS",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 1,
                      fontSize: 12,
                      height: 5),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: List.generate(avatars.length, (index) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          photoUrl = avatars[index];
                        });
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
            ],
          ),
        ),
      ),
    );
  }
}
