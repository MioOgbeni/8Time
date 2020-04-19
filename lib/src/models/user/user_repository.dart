import 'package:eighttime/src/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<FirebaseUser> signInWithGoogle();

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<User> getUser();

  Future<String> getUserId();

  Future<void> addNewUser(User user);

  Future<void> updateUser(User user);
}
