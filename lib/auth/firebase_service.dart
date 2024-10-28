import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider((_) => FirebaseAuth.instance);

final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);

final firebaseFirestoreCurrentUserProvider = Provider((ref) =>
    ref.read(firebaseFirestoreProvider).collection('users').doc(ref.read(firebaseAuthProvider).currentUser?.uid));

final authStateChangesProvider = StreamProvider<User?>((ref) => ref.read(firebaseAuthProvider).authStateChanges());
