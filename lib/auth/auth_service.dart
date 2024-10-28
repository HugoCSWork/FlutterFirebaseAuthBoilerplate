import 'package:auth_boilerplate/auth/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authService = AutoDisposeProvider((ref) => AuthService(ref));

abstract class IAuthService {
  Future<void> login({required String email, required String password});
  Future<void> register({required String username, required String email, required String password});
  Future<void> resetPassword({required String email});
  Future<void> logout();
  Future<void> google();
}

class AuthService implements IAuthService {
  final Ref _ref;
  final GoogleSignIn _googleSignIn;

  AuthService(this._ref, {GoogleSignIn? googleSignIn}) : _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<void> google() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential =
        GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await _ref.read(firebaseAuthProvider).signInWithCredential(credential);
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await _ref.read(firebaseAuthProvider).signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> register({required String username, required String email, required String password}) async {
    final userCredential =
        await _ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(username);
    await _ref.read(firebaseAuthProvider).currentUser?.reload();
    await _ref.read(firebaseFirestoreCurrentUserProvider).set({"username": username});
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _ref.read(firebaseAuthProvider).sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> logout() async {
    await _ref.read(firebaseAuthProvider).signOut();
  }
}
