import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/providers/agency_provider.dart';
import 'package:travelo_mobile/providers/destination_provider.dart';
import 'package:travelo_mobile/providers/reservation_provider.dart';
import 'package:travelo_mobile/providers/trip_provider.dart';
import 'package:travelo_mobile/providers/tripitem_provider.dart';
import 'package:travelo_mobile/providers/user_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:travelo_mobile/routes/routes.dart';

// const storage = FlutterSecureStorage();
final LocalStorage localStorage = LocalStorage('localstorage.json');
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
        ChangeNotifierProvider(create: (_) => AgencyProvider()),
        ChangeNotifierProvider(create: (_) => TripItemProvider())
      ],
      child: MaterialApp.router(
        routerConfig: MyRouter.router,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFFffffff)),
      ),
    );
  }
}
