import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grad_project/helpers/helpers.dart';
import 'package:grad_project/models/firebase_response.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FbAuthController with Helpers {
  static FbAuthController? _instance;

  FbAuthController._();

  factory FbAuthController() {
    return _instance ??= FbAuthController._();
  }

/*
* 1. CreateAccount
* 2. Sing in
* 3. Forget password
* 4. Sign out
* 5. Get User
* */
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // ...
          } else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      }
    }

    return user;
  }

  static Future<void> signOutGoogle({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }

  Future<FirebaseResponse> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(name);
      await credential.user!.sendEmailVerification();
      await _firebaseAuth.signOut();
      return FirebaseResponse(
          "Account registered successfully, Verify your email, please!",
          credential,
          success: true);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(e.message ?? "", null, success: false);
    }
  }

  Future<FirebaseResponse> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      bool emailVerified = credential.user!.emailVerified;
      if (!emailVerified) {
        _firebaseAuth.signOut();
        credential.user!.sendEmailVerification();
      }
      return FirebaseResponse(
          emailVerified
              ? "Logged in successfully"
              : "Failed to login, Verify your email, please!",
          credential,
          success: emailVerified);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(e.message ?? "", null, success: false);
    }
  }

  Future<FirebaseResponse> forgetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return FirebaseResponse("Password reset email sent successfully!", null,
          success: true);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(e.message ?? "", null, success: false);
    }
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  User get user => _firebaseAuth.currentUser!;

  bool get loggedIn => _firebaseAuth.currentUser != null;
}
