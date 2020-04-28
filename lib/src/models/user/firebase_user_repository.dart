import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/service_locator.dart';
import 'package:eighttime/src/entities/user_entity.dart';
import 'package:eighttime/src/models/user/user.dart';
import 'package:eighttime/src/models/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository extends UserRepository {
  CollectionReference usersCollection = Firestore.instance.collection('users');
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseUserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);

    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    addNewUser(User(currentUser.displayName, currentUser.email,
        currentUser.photoUrl.replaceAll("=s96-c", "=s1080-c"),
        useFingerprint: true, documentUid: currentUser.uid));

    var repository = injector.get<FirebaseActivitiesRepository>();
    await repository.setCollectionReference();

    var activitiesCount = await repository.activitiesCount();

    if (activitiesCount <= 0) {
      List<Activity> activities = List();

      activities.add(Activity("Work", IconEnum.work, ColorEnum.green, 0));

      activities.forEach((item) => repository.addNewActivity(item));
    }

    return _firebaseAuth.currentUser();
  }

  @override
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<User> getUser() async {
    final currentUser = await _firebaseAuth.currentUser();
    return User.fromEntity(
        UserEntity.fromSnapshot(
            await usersCollection.document(currentUser.uid).get()));
  }

  @override
  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  @override
  Future<void> addNewUser(User user) {
    return usersCollection.document(user.documentUid).setData(
        user.toEntity().toDocument());
  }

  @override
  Future<void> updateUser(User update) {
    return usersCollection
        .document(update.documentUid)
        .updateData(update.toEntity().toDocument());
  }
}
