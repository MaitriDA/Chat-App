import 'package:baatein/authentication/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baatein/utils/message_model.dart';
import 'setProfile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthService>(context).getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color(0xFFB0C2637),
        title: Text('Chats'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
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
                            backgroundImage: authUser.currentUser().photoUrl==null?AssetImage("assets/images/noprofile.png"):NetworkImage(authUser.currentUser().photoUrl),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: Text(authUser.currentUser().displayName,
                          style: TextStyle(
                            letterSpacing: 2,
                          ),),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: (){Navigator.push (
                            context,
                            MaterialPageRoute(builder: (context) => SetProfile()),
                          );},
                          leading: Icon(Icons.person),
                          title: Text('My Profile',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black54
                            ),),
                        ),
                        ListTile(
                          leading: Icon(Icons.star_border),
                          title: Text('Personal Space',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black54
                            ),),
                        ),
                        ListTile(
                          leading: Icon(Icons.color_lens_outlined),
                          title: Text('Theme',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black54
                            ),),
                        ),
                        // ListTile(
                        //   leading: Icon(Icons.screen_share_outlined),
                        //   title: Text('Our Web App',
                        //       style: TextStyle(
                        //           letterSpacing: 1,
                        //           color: Colors.black54
                        //       )),
                        // ),
                        ListTile(
                          leading: Icon(Icons.privacy_tip_outlined),
                          title: Text('About Us',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black54
                            ),),
                        ),
                        ListTile(
                          onTap: () {
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
                          leading: Icon(Icons.logout),
                          title: Text('Log Out',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black54
                            ),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (BuildContext context, int index){
          return Divider(
            height: 3,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final Message chat = chats[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                          )
                        ]
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(chat.sender.photoUrl),
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    padding: EdgeInsets.only(left: 20,),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(chat.sender.displayName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,),
                                chat.sender.isOnline ?
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent[700],
                                  ),
                                )
                                    :
                                Container(child: null,)
                              ],
                            ),
                            Text(chat.time,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            chat.text,
                            style: chat.unread ? TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ) :
                            TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                ]
            ),
          );
        },),
    );
  }
}