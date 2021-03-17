import 'package:baatein/utils/user.dart';

class Message {
  final UserCredentials sender;
  final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: abhay,
    time: '2:30 PM',
    text: 'Eggjacktly',
    unread: true,
  ),
  Message(
    sender: maitri,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today? lorem ipsum dolcet',
    unread: true,
  ),
  Message(
    sender: ruchika,
    time: '3:30 PM',
    text: 'WOW!',
    unread: false,
  ),
  Message(
    sender: xyz,
    time: '5:30 PM',
    text: 'Hey dude!.',
    unread: false,
  ),
];