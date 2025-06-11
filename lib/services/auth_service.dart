import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userId;
  bool _isAuthenticated = false;

  String? get userId => _userId;
  bool get isAuthenticated => _isAuthenticated;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _userId = user?.uid;
      _isAuthenticated = user != null;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
