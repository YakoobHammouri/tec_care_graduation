import 'package:firebase_auth/firebase_auth.dart';

class FirebaseResponse {
  final String message;
  final bool success;
  final UserCredential? credential;

  FirebaseResponse(this.message, this.credential, {this.success = true});
}
