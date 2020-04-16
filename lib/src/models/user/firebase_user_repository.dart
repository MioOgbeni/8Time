import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/src/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository {
  CollectionReference usersCollection = Firestore.instance.collection('users');
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseUserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);

    FirebaseUser user = await _firebaseAuth.currentUser();

    FirebaseActivitiesRepository activitiesRepository =
        FirebaseActivitiesRepository(userUid: user.uid);

    var activitiesCount = await activitiesRepository.activitiesCount();

    if (activitiesCount <= 0) {
      List<Activity> activities = List();

      activities.add(Activity("Work", IconEnum.work, ColorEnum.green, 0));
      activities
          .add(Activity("End work", IconEnum.exitToApp, ColorEnum.red, 1));

      activities.forEach((item) => activitiesRepository.addNewActivity(item));
    }

    return _firebaseAuth.currentUser();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<User> getUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    return (User(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        mail: firebaseUser.email,
        photoUrl: firebaseUser.photoUrl.replaceAll("=s96-c", "=s1080-c")));
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }
}
