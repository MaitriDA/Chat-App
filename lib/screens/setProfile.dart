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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add a Profile Picture",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Image.asset(
              "assets/images/profile.png",
              width: MediaQuery.of(context).size.width * 0.8,
            ),

            // Get Image from Gallery
            GestureDetector(
              onTap: () {
                _loadPicker(ImageSource.gallery);
                // Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFB1E4155), width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.all(20),
                child: Center(
                    child: Text(
                  "Gallery",
                  style: TextStyle(color: Color(0xFFB1E4155), fontSize: 16),
                )),
              ),
            ),

            // Get Image from Camera
            GestureDetector(
              onTap: () {
                _loadPicker(ImageSource.camera);
                // Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
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
                  "Camera",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
              ),
            ),

            //To home screen
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
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
                      "Home Screen",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
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
