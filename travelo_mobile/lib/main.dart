import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/login.dart';
import 'package:travelo_mobile/pages/navpages/bookmarks_page.dart';
import 'package:travelo_mobile/pages/navpages/home_page.dart';
import 'package:travelo_mobile/pages/navpages/main_page.dart';
import 'package:travelo_mobile/pages/navpages/notification_page.dart';
import 'package:travelo_mobile/pages/navpages/profile_page.dart';
import 'package:travelo_mobile/pages/navpages/trips_page.dart';
import 'package:travelo_mobile/pages/register.dart';
import 'package:travelo_mobile/pages/register_step2.dart';
import 'package:travelo_mobile/pages/profile/settings.dart';
import 'package:travelo_mobile/pages/welcome.dart';
import 'package:travelo_mobile/providers/destination_provider.dart';
import 'package:travelo_mobile/providers/reservation_provider.dart';
import 'package:travelo_mobile/providers/trip_provider.dart';
import 'package:travelo_mobile/providers/tripitem_provider.dart';
import 'package:travelo_mobile/providers/user_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

final storage = const FlutterSecureStorage();
final LocalStorage localStorage = new LocalStorage('localstorage.json');
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
        ChangeNotifierProvider(create: (_) => TripItemProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFFffffff)),
        initialRoute: "/welcome",
        routes: {
          "/": (context) => MainPage(),
          "/welcome": (context) => WelcomePage(),
          "/login": (context) => LoginPage(),
          "/register": (context) => RegisterPage(),
          "/register2": (context) => RegisterPageStep2(),
          "/trips": (context) => TripsPage(),
          "/bookmarks": (context) => BookmarksPage(),
          "/notifications": (context) => NotificationsPage(),
          "/settings": (context) => Settings(),
          "/profile": (context) => ProfilePage(),
        },
      ),
    );
  }
}
