import 'package:firebase_auth/firebase_auth.dart';

/// Authentication service that enables support for signing up/registering
/// with email/password, or anonomously as a guest account.
///
/// If signing in/registering fails, an `AuthenticationException` is thrown,
/// which captures the reason behind the exception.
///
/// This version uses `Firebase` as an authenticator.
///
/// See the official documentation for:
///
///  * [Registration and signing in with email/password](https://firebase.google.com/docs/auth/flutter/password-auth)
///  * [Logging in anonymously](https://firebase.google.com/docs/auth/flutter/anonymous-auth)
///
/// The service provdes methods for accessing a steam on the user credentials.
///
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential _userCredential;

  /// Set up a `Stream` that notifies our `AuthWrapper` or other components
  /// when the user successfully logs in/out of their account.
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<User?> signInAnonomous() async {
    // Code is intitally created by the Firebase team and modified to use
    // logging instead of print statements.
    // See: https://firebase.google.com/docs/auth/flutter/anonymous-auth
    // Visitied on: 07/11/23
    try {
      _userCredential = await _auth.signInAnonymously();
      return _userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          throw const AuthenticationException(
              AuthenticationExceptionReason.unknown);
        default:
          throw const AuthenticationException(
              AuthenticationExceptionReason.unknown);
      }
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String emailAddress, String password) async {
    // Code is intitally created by the Firebase team and modified to use
    // logging instead of print statements.
    // See: https://firebase.google.com/docs/auth/flutter/password-auth
    // Visitied on: 07/11/23
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return _userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const AuthenticationException(
            AuthenticationExceptionReason.userNotFound);
      } else if (e.code == 'wrong-password') {
        throw const AuthenticationException(
            AuthenticationExceptionReason.wrongPassword);
      } else {
        throw const AuthenticationException(
            AuthenticationExceptionReason.unknown);
      }
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String emailAddress, String password) async {
    // Code is intitally created by the Firebase team and modified to use
    // logging instead of print statements.
    // See: https://firebase.google.com/docs/auth/flutter/password-auth
    // Visitied on: 07/11/23
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return _userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const AuthenticationException(
            AuthenticationExceptionReason.weakPassword);
      } else if (e.code == 'email-already-in-use') {
        throw const AuthenticationException(
            AuthenticationExceptionReason.emailAlreadyInUse);
      } else {
        throw const AuthenticationException(
            AuthenticationExceptionReason.unknown);
      }
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw const AuthenticationException(
          AuthenticationExceptionReason.unknown);
    }
  }
}

/// A simple, throwable, Authentication Exception.
class AuthenticationException implements Exception {
  final AuthenticationExceptionReason? reason;

  const AuthenticationException([this.reason]);
}

/// An `AuthenticationException` enum for the reason of failure.
///
/// If it `unknown`, it could typically be from a server backend failure;
/// therefore, it could be outside the user's control.
enum AuthenticationExceptionReason {
  weakPassword,
  emailAlreadyInUse,
  userNotFound,
  wrongPassword,
  unknown
}
