import 'package:baatein/utils/user.dart';
import 'firebaseAuthService.dart';

abstract class AuthService {
  FirebaseAuthService getCurrentUser();
  Stream<UserCredentials> get onAuthStateChanged;
  Future<UserCredentials> createUser(String email, String password,String displayName);
  Future<UserCredentials> signInWithEmailPassword(
      String email, String password);
  Future<UserCredentials> signInWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future signOutUser();
  UserCredentials currentUser();
  void dispose();
}
