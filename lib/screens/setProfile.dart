import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:baatein/utils/user.dart';

class SetProfile extends StatefulWidget {
  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference UsersCollection = FirebaseFirestore.instance.collection("Users");
  File _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void customImageOptions() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            height: 170.0,
            color: Color(0xFF737373),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text(
                      'choose from camera',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    onTap: () {
                      _loadPicker(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.filter_frames),
                    title: Text(
                      'choose from gallery',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    onTap: () {
                      _loadPicker(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.close),
                    title: Text(
                      'remove profile picture',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    onTap: () {
                      setState(() {
                        _pickedImage = null;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                backgroundImage:NetworkImage(firebaseAuth.currentUser.photoURL),
              ),
            ),
            Column(
              children: [
                Center(
                  child: Text("AVATARS",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 1,
                        fontSize: 12,
                    height: 5),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async{
                            await UsersCollection.doc(firebaseAuth.currentUser.email)
                                .update({"photo_url":"https://firebasestorage.googleapis.com/v0/b/baatein-85a8d.appspot.com/o/avatars%2Favatars%2Favatar1.jpg?alt=media&token=e7479dc7-bfbc-46c6-83d6-94ba6d6b3a47"});
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
                              AssetImage("assets/images/avatar1.jpg"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            await UsersCollection.doc(firebaseAuth.currentUser.email)
                                .update({"photo_url":"https://firebasestorage.googleapis.com/v0/b/baatein-85a8d.appspot.com/o/avatars%2Favatars%2Favatar2.jpg?alt=media&token=85e84669-5a56-4673-a746-3c1659056d59"});
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
                              AssetImage("assets/images/avatar2.jpg"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            await UsersCollection.doc(firebaseAuth.currentUser.email)
                                .update({"photo_url":"https://firebasestorage.googleapis.com/v0/b/baatein-85a8d.appspot.com/o/avatars%2Favatars%2Favatar3.jpg?alt=media&token=2e8a8841-ad0a-4654-80bd-18d3d5627f26"});
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
                              AssetImage("assets/images/avatar3.jpg"),
                            ),
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async{
                            await UsersCollection.doc(firebaseAuth.currentUser.email)
                                .update({"photo_url":"https://firebasestorage.googleapis.com/v0/b/baatein-85a8d.appspot.com/o/avatars%2Favatars%2Favatar4.jpg?alt=media&token=638d4a9f-b8c1-4806-845e-2cd81eb04903"});
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
                              AssetImage("assets/images/avatar4.jpg"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            await UsersCollection.doc(firebaseAuth.currentUser.email)
                                .update({"photo_url":"https://firebasestorage.googleapis.com/v0/b/baatein-85a8d.appspot.com/o/avatars%2Favatars%2Favatar5.jpg?alt=media&token=b9615579-25e0-46a5-9fe6-2527520d0fd0"});
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
                              AssetImage("assets/images/avatar5.jpg"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            await UsersCollection.doc(firebaseAuth.currentUser.email)
                                .update({"photo_url":"https://firebasestorage.googleapis.com/v0/b/baatein-85a8d.appspot.com/o/avatars%2Favatars%2Favatar6.jpg?alt=media&token=05292b20-7266-4e08-8286-9e343081fa09"});
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
                              AssetImage("assets/images/avatar6.jpg"),
                            ),
                          ),
                        ),
                      ]),
                ),
                TextButton(onPressed: () => customImageOptions(),
                    child: Text("OR CHOOSE CUSTOM IMAGE",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          letterSpacing: 1,
                          fontSize: 12),))
              ],
            ),


          ],
        ),
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: source,
    );
    if (pickedFile != null) {
      _cropImage(pickedFile);
    }
  }

  _cropImage(PickedFile pickedFile) async {
    File croppedImage = await ImageCropper.cropImage(
        maxHeight: 512,
        maxWidth: 512,
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (croppedImage != null) {
      setState(() {
        _pickedImage = croppedImage;
      });
    } else {
      showDialog(
        builder: (builder) => AlertDialog(
          title: Text("Error"),
          content: Text("We were unable to get the image."),
          elevation: 5,
        ),
        context: null,
      );
    }
  }
}
