import 'package:flutter/material.dart';
import 'package:gelato/presentation/pages/gelatoRegister.dart';
import 'package:gelato/presentation/pages/login.dart';
import 'package:gelato/presentation/pages/menu.dart';
import 'package:gelato/presentation/pages/register.dart';
import 'package:go_router/go_router.dart';

import '../pages/mainList.dart';
import '../pages/profile.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/menu',
        name: 'menu',
        builder: (context, state) => const MenuPage(),
        routes: [
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: '/main-list',
            name: 'mainList',
            builder: (context, state) => GelatoListPage(),
            routes: [
              GoRoute(
                name: 'gelato-register',
                path: '/gelato-register',
                builder: (context, state) {
                  final value = state.extra as Map<String, dynamic>;
                  final isEdit = value['isEdit'] ?? false;
                  final docId = value['docId'] ?? '';
                  return GelatoRegister(isEdit: isEdit, docId: docId);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
