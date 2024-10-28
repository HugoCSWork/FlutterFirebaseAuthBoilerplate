import 'package:auth_boilerplate/app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension WidgetTesterExtensions on WidgetTester {
  Future<void> pumpWidgetProvider({
    List<Override> overrides = const [],
    List<ProviderObserver> observers = const [],
    List<NavigatorObserver> navigatorObservers = const [],
    required Widget child,
  }) async {
    view.physicalSize = const Size(3000, 3000);
    view.devicePixelRatio = 1.0;
    addTearDown(view.resetPhysicalSize);

    return await pumpWidget(
      ProviderScope(
        overrides: overrides,
        observers: observers,
        child: MaterialApp(
          home: child,
          navigatorObservers: navigatorObservers,
        ),
      ),
    );
  }

  Future<void> pumpFormWidget(Widget child, {AutovalidateMode? autovalidateMode}) async {
    final key = GlobalKey<FormState>();
    await pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          autovalidateMode: autovalidateMode ?? AutovalidateMode.always,
          key: key,
          child: Column(
            children: [
              child,
              TextButton(
                key: const Key('form_button'),
                onPressed: () => key.currentState?.validate(),
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> pumpWidgetProviderWithRoutes({
    List<Override> overrides = const [],
    List<ProviderObserver> observers = const [],
    List<NavigatorObserver> navigatorObservers = const [],
    required String initialRoute,
  }) async {
    view.physicalSize = const Size(3000, 3000);
    view.devicePixelRatio = 1.0;
    addTearDown(view.resetPhysicalSize);

    return await pumpWidget(
      ProviderScope(
        overrides: overrides,
        observers: observers,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            routes: Routes.list,
            initialLocation: initialRoute,
          ),
        ),
      ),
    );
  }

  Future<void> pumpWidgetProviderWithExistingRouter({
    List<Override> overrides = const [],
    List<ProviderObserver> observers = const [],
    List<NavigatorObserver> navigatorObservers = const [],
  }) async {
    view.physicalSize = const Size(3000, 3000);
    view.devicePixelRatio = 1.0;
    addTearDown(view.resetPhysicalSize);

    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        observers: observers,
        child: Consumer(
          builder: (context, ref, _) {
            final router = ref.watch(routerProvider);
            return MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              routeInformationProvider: router.routeInformationProvider,
            );
          },
        ),
      ),
    );
    await pumpAndSettle();
  }
}
