import 'package:meta/meta.dart';

class UserCredentials {
  UserCredentials({
    @required this.uid,
    this.id,
    this.email,
    this.photoUrl,
    this.displayName,
    this.isOnline,

  });

  final String uid;
  final int id;
  final String email;
  final String photoUrl;
  final String displayName;
  final bool isOnline;
}

// YOU - current user
final UserCredentials currentUser = UserCredentials(
  id: 0,
  displayName: 'Asavari Ambavane',
  photoUrl: 'assets/images/avatar.jpg',
  isOnline: true,
);

// USERS
final UserCredentials abhay = UserCredentials(
  id: 1,
  displayName: 'Abhay',
  photoUrl: 'assets/images/avatar.jpg',
  isOnline: true,
);
final UserCredentials ruchika = UserCredentials(
  id: 2,
  displayName: 'Ruchika',
  photoUrl: 'assets/images/avatar4.png',
  isOnline: true,
);
final UserCredentials maitri = UserCredentials(
  id: 3,
  displayName: 'Maitri',
  photoUrl: 'assets/images/avatar4.png',
  isOnline: false,
);
final UserCredentials xyz = UserCredentials(
  id: 4,
  displayName: 'xyz',
  photoUrl: 'assets/images/avatar3.png',
  isOnline: false,
);

