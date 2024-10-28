import 'dart:async';

import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' as firebase_auth_mocks;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.mocks.dart';
import '../util/riverpod_utils.dart';

void main() {
  group('Auth Service Google Sign In should', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUserCredential mockUserCredential;
    late MockGoogleSignIn mockGoogleSignIn;
    late MockGoogleSignInAccount mockGoogleSignInAccount;
    late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      mockGoogleSignIn = MockGoogleSignIn();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    });
    test('successfully log user in with google', () async {
      // Given
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleSignInAccount);
      when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer((_) async => mockUserCredential);
      when(mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(mockGoogleSignInAuthentication.accessToken).thenReturn('accessToken');
      when(mockGoogleSignInAuthentication.idToken).thenReturn('idToken');

      final container = createContainer(overrides: [
        authService.overrideWith((ref) => AuthService(ref, googleSignIn: mockGoogleSignIn)),
        firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
      ]);

      // When
      await container.read(authService).google();

      // Then
      verify(mockGoogleSignIn.signIn()).called(1);
      verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
      verify(mockGoogleSignInAccount.authentication).called(1);
      verify(mockGoogleSignInAuthentication.accessToken).called(1);
      verify(mockGoogleSignInAuthentication.idToken).called(1);
    });
  });

  group('Auth Service Register should', () {
    late firebase_auth_mocks.MockFirebaseAuth mockAuth;
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
    late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;

    setUp(() {
      mockAuth = firebase_auth_mocks.MockFirebaseAuth();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      mockCollectionReference = MockCollectionReference();
    });

    test('successfully register user', () async {
      // Given
      const displayName = 'testuser';
      final container = createContainer(overrides: [
        firebaseAuthProvider.overrideWithValue(mockAuth),
        firebaseFirestoreProvider.overrideWithValue(mockFirebaseFirestore),
      ]);

      when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.set({"username": displayName})).thenAnswer((_) async {});

      // When
      await container.read(authService).register(username: displayName, email: 'test@test.com', password: 'Password1!');

      // Then
      expect(mockAuth.currentUser?.displayName, displayName);
      expect(mockAuth.authStateChanges(), emitsInOrder([null, isA<User>()]));
      expect(mockAuth.userChanges(), emitsInOrder([null, isA<User>()]));
      verify(mockFirebaseFirestore.collection('users')).called(1);
      verify(mockCollectionReference.doc(mockAuth.currentUser?.uid)).called(1);
      verify(mockDocumentReference.set({"username": displayName})).called(1);
    });
    // TODO: Write test when logic exists
    test('return specific exception on failure', () {});
  });

  group('Auth Service Login should', () {
    late firebase_auth_mocks.MockFirebaseAuth mockAuth;

    setUp(() => mockAuth = firebase_auth_mocks.MockFirebaseAuth());

    test('successfully login user', () async {
      // Given
      final container = createContainer(overrides: [firebaseAuthProvider.overrideWithValue(mockAuth)]);

      // When
      await container.read(authService).login(email: 'test@test.com', password: 'Password1!');

      // Then
      expect(mockAuth.authStateChanges(), emitsInOrder([null, isA<User>()]));
      expect(mockAuth.userChanges(), emitsInOrder([null, isA<User>()]));
    });
  });

  group('Auth Service logout should', () {
    late firebase_auth_mocks.MockFirebaseAuth mockAuth;

    setUp(() => mockAuth = firebase_auth_mocks.MockFirebaseAuth());

    test('successfully logout user', () async {
      // Given
      final container = createContainer(overrides: [firebaseAuthProvider.overrideWithValue(mockAuth)]);

      // When
      await container.read(authService).login(email: 'test@test.com', password: 'Password1!');
      await container.read(authService).logout();

      // Then
      expect(mockAuth.authStateChanges(), emitsInOrder([null, isA<User>(), null]));
      expect(mockAuth.userChanges(), emitsInOrder([null, isA<User>(), null]));
    });
  });

  group('Auth Service resetPassword should', () {
    late MockFirebaseAuth mockAuth;

    setUp(() => mockAuth = MockFirebaseAuth());

    test('successfully send password reset email', () async {
      // Given
      const email = 'test@test.com';
      when(mockAuth.sendPasswordResetEmail(email: email)).thenAnswer((_) async {});
      final container = createContainer(overrides: [firebaseAuthProvider.overrideWithValue(mockAuth)]);

      // When
      await container.read(authService).resetPassword(email: email);

      // Then
      verify(mockAuth.sendPasswordResetEmail(email: email)).called(1);
    });
  });

  group('Auth Service AuthStatusChanges Should', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;
    late ProviderContainer container;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();
      container = createContainer(overrides: [
        firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
      ]);
    });
    test('emits user state changes', () async {
      // Given
      final controller = StreamController<User?>();

      when(mockFirebaseAuth.authStateChanges()).thenAnswer((_) {
        return controller.stream;
      });

      // Listen to the provider directly
      final authState = container.read(authStateChangesProvider);

      // Then: Expect the initial state to be null
      expect(authState, isA<AsyncValue<User?>>());
      expect(authState.value, isNull);

      // When: Simulate user signing in
      controller.add(mockUser);
      // Allow some time for the state to update
      await Future.delayed(const Duration(milliseconds: 100));

      // Then: Expect user when signed in
      final updatedAuthState = container.read(authStateChangesProvider);
      expect(updatedAuthState, isA<AsyncValue<User?>>());
      expect(updatedAuthState.value, mockUser);

      // When: Simulate user signing out
      controller.add(null);
      // Allow some time for the state to update
      await Future.delayed(const Duration(milliseconds: 100));

      // Then: Expect null when signed out
      final finalAuthState = container.read(authStateChangesProvider);
      expect(finalAuthState, isA<AsyncValue<User?>>());
      expect(finalAuthState.value, isNull);

      // Close the stream controller
      await controller.close();
    });
  });
}
