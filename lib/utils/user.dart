import 'package:meta/meta.dart';

class UserCredentials {
  UserCredentials({
    @required this.uid,
    this.id,
    this.email,
    this.photoUrl,
    this.displayName,
    this.todo,
  });

  final String uid;
  final int id;
  final String email;
  final String photoUrl;
  final String displayName;
  final List todo;
}

