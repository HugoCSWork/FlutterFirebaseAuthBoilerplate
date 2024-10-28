import 'package:auth_boilerplate/firebase_options.dart';
import 'package:auth_boilerplate/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension CofigurationRobots on WidgetTester {
  Future<void> pumpApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore.instance.settings =
        const Settings(host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

    await pumpWidget(const ProviderScope(child: MyApp()));
    await pumpAndSettle(const Duration(seconds: 1));
  }
}
