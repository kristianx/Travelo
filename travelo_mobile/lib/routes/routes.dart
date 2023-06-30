import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelo_mobile/pages/agency.dart';
import 'package:travelo_mobile/pages/login.dart';
import 'package:travelo_mobile/pages/navpages/bookmarks_page.dart';
import 'package:travelo_mobile/pages/navpages/notification_page.dart';
import 'package:travelo_mobile/pages/navpages/profile_page.dart';
import 'package:travelo_mobile/pages/navpages/trips_page.dart';
import 'package:travelo_mobile/pages/new_payment_method.dart';
import 'package:travelo_mobile/pages/payment_settings.dart';
import 'package:travelo_mobile/pages/profile/change_password.dart';
import 'package:travelo_mobile/pages/profile/edit_profile.dart';
import 'package:travelo_mobile/pages/profile/settings.dart';
import 'package:travelo_mobile/pages/profile/trip_invoices.dart';
import 'package:travelo_mobile/pages/register.dart';
import 'package:travelo_mobile/pages/register_step2.dart';
import 'package:travelo_mobile/pages/trip.dart';
import 'package:travelo_mobile/pages/welcome.dart';
import '../model/user.dart';
import '../pages/ScaffoldWithNavBar.dart';
import '../pages/destination.dart';
import '../pages/navpages/home_page.dart';
import 'package:travelo_mobile/model/trip.dart' as trip_model;

import 'errorPageBuilder.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class MyRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/welcome',
    navigatorKey: _rootNavigatorKey,
    errorBuilder: errorPageBuilder,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return MaterialPage(
              child: ScaffoldWithNavBar(
            location: state.location,
            child: child,
          ));
        },
        routes: [
          GoRoute(
            path: '/home',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: HomePage(),
              );
            },
          ),
          GoRoute(
            path: '/bookmarks',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: BookmarksPage(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/trips',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: TripsPage(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/notifications',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: NotificationsPage(),
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
            path: '/payment',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: PaymentSettings(),
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
            path: '/new-payment-method',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: NewPaymentMethod(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/settings',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: Settings(),
              );
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
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: WelcomePage(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginPage(),
          );
        },
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: RegisterPage(),
          );
        },
      ),
      GoRoute(
        path: '/register2',
        builder: (context, state) => const RegisterPageStep2(),
      ),
    ],
  );
}
