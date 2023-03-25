import 'dart:async';

import 'package:thinkcreative_technologies/Services/authentication/auth_service.dart';
import 'package:flutter/foundation.dart';

class SignInManager {
  SignInManager({required this.auth, required this.isLoading});
  final AuthService auth;
  final ValueNotifier<bool> isLoading;

  Future<UserClass?> _signIn(Future<UserClass?> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<UserClass?> signInAnonymously() async {
    return await _signIn(auth.signInAnonymously);
  }
}
