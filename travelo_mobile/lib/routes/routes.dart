import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelo_mobile/pages/agency.dart';
import 'package:travelo_mobile/pages/login.dart';
import 'package:travelo_mobile/pages/navpages/bookmarks_page.dart';
import 'package:travelo_mobile/pages/navpages/profile_page.dart';
import 'package:travelo_mobile/pages/navpages/trips_page.dart';
import 'package:travelo_mobile/pages/profile/change_password.dart';
import 'package:travelo_mobile/pages/profile/edit_profile.dart';

import 'package:travelo_mobile/pages/profile/trip_invoices.dart';
import 'package:travelo_mobile/pages/register.dart';
import 'package:travelo_mobile/pages/trip.dart';
import 'package:travelo_mobile/pages/welcome.dart';
import '../model/user.dart';
import '../pages/ScaffoldWithNavBar.dart';
import '../pages/destination.dart';
import '../pages/navpages/home_page.dart';
import 'package:travelo_mobile/model/trip.dart' as trip_model;

import 'errorPageBuilder.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class MyRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/welcome',
    navigatorKey: _rootNavigatorKey,
    errorBuilder: errorPageBuilder,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return CupertinoPage(
              key: state.pageKey,
              child: ScaffoldWithNavBar(
                key: state.pageKey,
                location: state.location,
                child: child,
              ));
        },
        routes: [
          GoRoute(
            path: '/home',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/bookmarks',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const BookmarksPage(),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/trips',
            pageBuilder: (context, state) {
              return const CupertinoPage(
                child: TripsPage(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/profile',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: ProfilePage(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/edit-profile',
            name: 'EditProfile',
            builder: (context, state) {
              User user = state.extra as User;
              return EditProfile(user: user);
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/invoices',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: TripInvoices(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/Change-password',
            name: 'ChangePassword',
            builder: (context, state) {
              User user = state.extra as User;
              return ChangePassword(user: user);
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/destination',
            name: 'Destination',
            builder: (context, state) => DestinationPage(
                city: state.queryParameters['city'] as String,
                cityImage: state.queryParameters['cityImage'] as String,
                numberOfTrips: state.queryParameters['numberOfTrips'] as String,
                countryName: state.queryParameters['countryName'] as String),
            // pageBuilder: (context, state) {
            //   return MaterialPage(
            //     child: DestinationPage(
            //       city: state.params['city'],
            //       cityImage: '',
            //       countryName: '',
            //       numberOfTrips: '',
            //     ),
            //   );
            // },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/trip',
            name: 'Trip',
            builder: (context, state) {
              trip_model.Trip trip = state.extra as trip_model.Trip;
              bool bookmarked =
                  state.queryParameters['bookmarked'] == 'true' ? true : false;
              return Trip(
                trip: trip,
                bookmarked: bookmarked,
              );
            },
          ),
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/agency',
              name: 'Agency',
              builder: (context, state) {
                int agencyId = state.extra as int;
                return AgencyPage(
                  agencyId: agencyId,
                );
              })
        ],
      ),
      GoRoute(
        path: '/welcome',
        // builder: (context, state) => const WelcomePage(),
        pageBuilder: (context, state) {
          return CupertinoPage(
            key: state.pageKey,
            child: WelcomePage(
              key: state.pageKey,
            ),
          );
        },
      ),
      GoRoute(
        name: 'Login',
        path: '/login',
        // builder: (context, state) => const LoginPage(),
        pageBuilder: (context, state) {
          return CupertinoPage(
            key: state.pageKey,
            child: LoginPage(
              key: state.pageKey,
            ),
          );
        },
      ),
      GoRoute(
        path: '/register',
        // builder: (context, state) => const RegisterPage(),
        pageBuilder: (context, state) {
          return CupertinoPage(
            key: state.pageKey,
            child: RegisterPage(
              key: state.pageKey,
            ),
          );
        },
      ),
    ],
  );
}
