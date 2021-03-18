import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SetProfile extends StatefulWidget {
  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  File _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "My Profile",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
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
                backgroundImage: _pickedImage==null?AssetImage("assets/images/profile.png"):FileImage(File(_pickedImage.path))
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage("assets/images/avatar.jpg"),
                    ),
                  ),
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage("assets/images/avatar2.jpg"),
                    ),
                  ),
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage("assets/images/avatar3.png"),
                    ),
                  ),
                ]
            ),

            // Get Image from Gallery
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _loadPicker(ImageSource.gallery);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFB1E4155), width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                        child: Center(
                            child: Text(
                          "Gallery",
                          style: TextStyle(color: Color(0xFFB1E4155), fontSize: 16),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _loadPicker(ImageSource.camera);
                        // Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFB1E4155), width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                        child: Center(
                            child: Text(
                              "Camera",
                              style: TextStyle(color: Color(0xFFB1E4155), fontSize: 16),
                            )),
                      ),
                    ),
                  ],
                ),
                //To home screen
                GestureDetector(
                  onTap: () {
                    Navigator.pop (context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFB1E4155),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                )
              ],
            ),
            // Get Image from Camera

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
        context: context,
        builder: (builder) => AlertDialog(
          title: Text("Error"),
          content: Text("We were unable to get the image."),
          elevation: 5,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Try Again"),
            )
          ],
        ),
      );
    }
  }
}
