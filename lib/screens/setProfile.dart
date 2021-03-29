import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'homePage.dart';
import 'dart:io';

class SetProfile extends StatefulWidget {
  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
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
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFB1E4155),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.all(20),
                child: Center(
                    child: Text(
                  "Gallery",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
              ),
            ),

            // Get Image from Camera
            GestureDetector(
              onTap: () {
                _loadPicker(ImageSource.camera);
              },
              child: Container(
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
            )
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
      _cropImageAndGoToHome(pickedFile);
    }
  }

  _cropImageAndGoToHome(PickedFile pickedFile) async {
    File croppedImage = await ImageCropper.cropImage(
        maxHeight: 512,
        maxWidth: 512,
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (croppedImage != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomePage(
                  imageFile: croppedImage,
                )),
        ModalRoute.withName('/home'),
      );
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
