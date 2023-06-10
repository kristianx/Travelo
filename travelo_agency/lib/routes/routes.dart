import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelo_agency/models/trip.dart';
import 'package:travelo_agency/pages/dashboard.dart';
import 'package:travelo_agency/pages/new_offer.dart';
import 'package:travelo_agency/pages/offer.dart';
import 'package:travelo_agency/pages/offers.dart';
import 'package:travelo_agency/pages/profile.dart';

import '../pages/login.dart';
import '../pages/register.dart';
import '../pages/templates/ScaffoldWithNavBar.dart';
import '../pages/welcome.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class MyRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/welcome',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      // GoRoute(
      //   path: '/dashboard',
      //   builder: (context, state) => const DashboardPage(),
      // ),
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state, child) {
            return NoTransitionPage(
                child: ScaffoldWithNavBar(
              location: state.location,
              child: child,
            ));
          },
          routes: [
            GoRoute(
              path: '/dashboard',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: DashboardPage(),
                );
              },
            ),
            GoRoute(
              path: '/offers',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: OffersPage(),
                );
              },
            ),
            GoRoute(
              path: '/offers/add',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: NewOfferPage(),
                );
              },
            ),
            GoRoute(
              name: 'Single Offer Page',
              path: '/offer',
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) {
                Trip trip = state.extra as Trip;
                return OfferPage(
                  trip: trip,
                );
              },
            ),
            GoRoute(
              path: '/profile',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: ProfilePage(),
                );
              },
            ),
          ])
    ],
  );
}
