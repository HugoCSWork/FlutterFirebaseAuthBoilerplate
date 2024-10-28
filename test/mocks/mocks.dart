import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  AuthService,
  FirebaseAuth,
  FirebaseFirestore,
  DocumentReference<Map<String, dynamic>>,
  CollectionReference<Map<String, dynamic>>,
  UserCredential,
  User,
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  FirebaseOptions,
  AsyncValue,
])
class Mocks {}

class StateListener extends Mock {
  void call(dynamic previous, dynamic value);
}
