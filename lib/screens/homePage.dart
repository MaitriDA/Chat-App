import 'package:baatein/authentication/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  HomePage({this.imageFile});
  final File imageFile;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthService>(context).getCurrentUser();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.file(widget.imageFile),
            ElevatedButton(
              child: Text(
                "Logout",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),

              onPressed: () {
                try {
                  authUser.signOutUser();
                  print("SignOut Successful!");
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (Route<dynamic> route) => false);
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
                            padding:
                            const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
            ),
          ],
        ),
      ),
    );
  }
}
