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
      stream: FirebaseFirestore.instance.collection("Users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var nameList = [];
          var phoneList = [];
          final searchName = FirebaseFirestore.instance
              .collection("Users")
              .where("name", isGreaterThanOrEqualTo: query)
              .where("name", isLessThanOrEqualTo: query + '~');

          final searchPhone = FirebaseFirestore.instance
              .collection("Users")
              .where("phone", isGreaterThanOrEqualTo: query)
              .where("phone", isLessThanOrEqualTo: query + '~');

          searchName.get().then((querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              nameList.add({
                "email": doc.id,
                "phone": doc["phone"],
                "name": doc["name"],
                "photo_url": doc["photo_url"]
              });
            });
          });

          searchPhone.get().then((querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              phoneList.add({
                "email": doc.id,
                "phone": doc["phone"],
                "name": doc["name"],
                "photo_url": doc["photo_url"]
              });
            });
          });
          return Column(
            children: [
              ListView.builder(
                itemCount: nameList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.insert_drive_file_rounded),
                      title: RichText(
                        text: TextSpan(
                          text: nameList[index]["name"],
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () async {
                        await createDocument(nameList[index]);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ShowPDFScreen(
                        //       filename: mapList[index]["file_name"],
                        //       url: mapList[index]["url"],
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: phoneList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.insert_drive_file_rounded),
                      title: RichText(
                        text: TextSpan(
                          text: phoneList[index]["name"],
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () async {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ShowPDFScreen(
                        //       filename: mapList[index]["file_name"],
                        //       url: mapList[index]["url"],
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  );
                },
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

    await authUserRef.get().then((docSnapshot) {
      if (!docSnapshot.exists) {
        authUserRef
            .set({
              "name": user["name"],
              "email": user["email"],
              "phone": user["phone"],
              "photo_url": user["photo_url"]
            })
            .then((value) => print("User's Document Added"))
            .catchError((error) =>
                print("Failed to add user: $error")); // create the document

        userRef
            .set({
          "name": authUser.displayName,
          "email": authUser.email,
          "phone": authUser.phone,
          "photo_url": user["photo_url"]
        })
            .then((value) => print("User's Document Added"))
            .catchError((error) =>
            print("Failed to add user: $error"));
      }
    });


  }
}
