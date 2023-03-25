import 'package:firebase_auth/firebase_auth.dart';
import 'package:thinkcreative_technologies/Services/authentication/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserClass? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    print('user.uid: ${user.uid}');
    print('user.email: ${user.email}');
    print('user.displayName: ${user.displayName}');
    print('user.photoURL: ${user.photoURL}');
    print('phonenumber: ${user.phoneNumber}');
    print('user.providerId: ${user.providerData.first.providerId}');
    print('user.isAnonymous: ${user.isAnonymous}');
    print('user.emailVerified: ${user.emailVerified}');
    return UserClass(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        phonenumber: user.phoneNumber,
        provider: user.providerData.first.providerId,
        isanomously: user.isAnonymous,
        isverified: user.emailVerified);
  }

  @override
  Stream<UserClass?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserClass?> signInAnonymously() async {
    final UserCredential authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<UserClass?> currentUser() async {
    final User? user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  void dispose() {}
}
