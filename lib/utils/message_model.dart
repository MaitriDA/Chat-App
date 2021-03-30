import 'package:baatein/utils/user.dart';

class Message {
  final String sender;
  final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;
  final String senderName;
  Message({
    this.sender,
    this.senderName,
    this.time,
    this.text,
    this.unread,
  });
}

// EXAMPLE CHATS ON HOME SCREEN
// List<Message> chats = [
//   Message(
//     sender: abhay,
//     time: '2:30 PM',
//     text: 'Eggjacktly',
//     unread: true,
//   ),
//   Message(
//     sender: maitri,
//     time: '4:30 PM',
//     text: 'Hey, how\'s it going? What did you do today? lorem ipsum dolcet',
//     unread: true,
//   ),
//   Message(
//     sender: ruchika,
//     time: '3:30 PM',
//     text: 'WOW!',
//     unread: false,
//   ),
//   Message(
//     sender: xyz,
//     time: '5:30 PM',
//     text: 'Hey dude!.',
//     unread: false,
//   ),
// ];
//
// // EXAMPLE MESSAGES IN CHAT SCREEN
// List<Message> messages = [
//   Message(
//     sender: xyz,
//     time: '5:30 PM',
//     text: 'Hey dude!',
//     unread: true,
//   ),
//   Message(
//     sender: currentUser,
//     time: '4:30 PM',
//     text:
//     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
//     unread: true,
//   ),
//   Message(
//     sender: xyz,
//     time: '3:45 PM',
//     text: 'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
//     unread: true,
//   ),
//   Message(
//     sender: xyz,
//     time: '3:15 PM',
//     text:
//     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
//     unread: true,
//   ),
//   Message(
//     sender: currentUser,
//     time: '3:00 PM',
//     text: 'Lorem ipsum dolor sit amet',
//     unread: true,
//   ),
//   Message(
//     sender: currentUser,
//     time: '2:30 PM',
//     text: 'Lorem ipsum dolor sit amet, consectetur adipiscing ',
//     unread: true,
//   ),
//   Message(
//     sender: currentUser,
//     time: '2:30 PM',
//     text: 'Yes!',
//     unread: true,
//   ),
//   Message(
//     sender: xyz,
//     time: '2:00 PM',
//     text: 'Lorem ipsum dolor sit amet, sed do eiusmod tempor incididunt ut',
//     unread: true,
//   ),
// ];
