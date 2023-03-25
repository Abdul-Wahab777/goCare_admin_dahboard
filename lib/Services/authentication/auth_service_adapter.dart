import 'dart:async';
import 'package:thinkcreative_technologies/Services/authentication/auth_service.dart';
import 'package:thinkcreative_technologies/Services/authentication/firebase_auth_service.dart';
import 'package:flutter/foundation.dart';

enum AuthServiceType { firebase, mock }

class AuthServiceAdapter implements AuthService {
  AuthServiceAdapter({required AuthServiceType initialAuthServiceType})
      : authServiceTypeNotifier =
            ValueNotifier<AuthServiceType>(initialAuthServiceType) {
    _setup();
  }
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  // Value notifier used to switch between [FirebaseAuthService] and [MockAuthService]
  final ValueNotifier<AuthServiceType> authServiceTypeNotifier;
  AuthServiceType get authServiceType => authServiceTypeNotifier.value;
  AuthService get authService => _firebaseAuthService;

  StreamSubscription<UserClass?>? _firebaseAuthSubscription;
  StreamSubscription<UserClass>? _mockAuthSubscription;

  void _setup() {
    _firebaseAuthSubscription =
        _firebaseAuthService.onAuthStateChanged.listen((UserClass? user) {
      if (authServiceType == AuthServiceType.firebase) {
        _onAuthStateChangedController.add(user);
      }
    }, onError: (dynamic error) {
      if (authServiceType == AuthServiceType.firebase) {
        _onAuthStateChangedController.addError(error);
      }
    });
  }

  @override
  void dispose() {
    _firebaseAuthSubscription?.cancel();
    _mockAuthSubscription?.cancel();
    _onAuthStateChangedController.close();
    authServiceTypeNotifier.dispose();
  }

  final StreamController<UserClass?> _onAuthStateChangedController =
      StreamController<UserClass?>.broadcast();
  @override
  Stream<UserClass?> get onAuthStateChanged =>
      _onAuthStateChangedController.stream;

  @override
  Future<UserClass?> currentUser() => authService.currentUser();

  @override
  Future<UserClass?> signInAnonymously() => authService.signInAnonymously();
  @override
  Future<void> signOut() => authService.signOut();
}
