import 'dart:async';
import 'package:meta/meta.dart';

@immutable
class UserClass {
  const UserClass({
    required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.phonenumber,
    this.isanomously,
    this.isverified,
    this.provider,
  });

  final String uid;
  final String? email;
  final String? photoUrl;
  final String? displayName;
  final String? phonenumber;
  final bool? isverified;
  final bool? isanomously;
  final String? provider;
}

abstract class AuthService {
  Future<UserClass?> currentUser();
  Future<UserClass?> signInAnonymously();

  Future<void> signOut();
  Stream<UserClass?> get onAuthStateChanged;
  void dispose();
}
