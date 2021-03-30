import 'package:cloud_firestore/cloud_firestore.dart';
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
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {}
          ),
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
                  backgroundImage: _pickedImage == null
                      ? AssetImage("assets/images/noprofile.png")
                      : FileImage(File(_pickedImage.path))),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
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
                ]),
            GestureDetector(
              onTap: () {
                _loadPicker(ImageSource.gallery);
              },
              child: GestureDetector(
                onTap: () => customImageOptions(),
                child: Container(
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFB1E4155), width: 2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                  child: Center(
                      child: Text(
                        "Choose custom image",
                        style: TextStyle(
                            color: Color(0xFFB1E4155), fontSize: 16),
                      )),
                ),
              ),
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
        builder: (builder) =>
            AlertDialog(
              title: Text("Error"),
              content: Text("We were unable to get the image."),
              elevation: 5,
            ),
        context: null,
      );
    }
  }
}