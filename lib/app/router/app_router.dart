import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_qr_screen.dart';
import '../../features/category/screens/category_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/main/widgets/secure_tab_shell.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/reader/screens/document_reader_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/transactions/screens/transaction_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login-qr',
        builder: (context, state) => const LoginQrScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return SecureTabShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main/transactions',
                builder: (context, state) => const TransactionScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main/category',
                builder: (context, state) => const CategoryScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/reader/:docId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final docId = state.pathParameters['docId']!;
          return DocumentReaderScreen(documentId: docId);
        },
      ),
    ],
  );
}
