import 'package:baatein/authentication/authService.dart';
import 'package:baatein/utils/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:baatein/utils/message_model.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String user;
  final String userEmail;
  final String photoUrl;

  ChatScreen({this.user, this.photoUrl, this.userEmail});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  _chatBubble(UserCredentials authUser, Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                // color: Theme.of(context).primaryColor,
                color: Color(0xFFFEEFEC),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(authUser.photoUrl),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(widget.photoUrl),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea(UserCredentials authUser) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              var message = messageController.text;
              setState(() {
                messageController.clear();
              });
              if (message != "") {
                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(authUser.email)
                    .collection("Chats")
                    .doc(widget.userEmail)
                    .update({
                  "chats": FieldValue.arrayUnion([
                    {
                      "message": message,
                      "sender": authUser.email,
                      "timestamp": DateTime.now(),
                    }
                  ])
                });
                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(widget.userEmail)
                    .collection("Chats")
                    .doc(authUser.email)
                    .update({
                  "chats": FieldValue.arrayUnion([
                    {
                      "message": message,
                      "sender": authUser.email,
                      "timestamp": DateTime.now(),
                    }
                  ])
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthService>(context).currentUser();
    String prevUserId;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.user,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(text: '\n'),
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(authUser.email)
                  .collection("Chats")
                  .doc(widget.userEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var docRef = snapshot.data;
                  var messages = docRef["chats"];
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Message message = Message(
                            sender: messages[index]["sender"],
                            text: messages[index]["message"],
                            time: messages[index]["timestamp"]
                                .toDate()
                                .toString(),
                            unread: false);
                        final bool isMe =
                            messages[index]["sender"] == authUser.email;
                        final bool isSameUser =
                            prevUserId == messages[index]["sender"];
                        prevUserId = messages[index]["sender"];
                        return _chatBubble( authUser, message, isMe, isSameUser);
                      },
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          _sendMessageArea(authUser),
        ],
      ),
    );
  }
}
