import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:travelo_agency/providers/accomodation_provider.dart';
import 'package:travelo_agency/providers/agency_provider.dart';
import 'package:travelo_agency/providers/city_provider.dart';
import 'package:travelo_agency/providers/reservation_provider.dart';
import 'package:travelo_agency/providers/tripItemProvider.dart';
import 'package:travelo_agency/providers/trip_provider.dart';
import 'package:travelo_agency/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final LocalStorage localStorage = LocalStorage('localstorage.json');
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
        ChangeNotifierProvider(create: (_) => AgencyProvider()),
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
        ChangeNotifierProvider(create: (_) => CityProvider()),
        ChangeNotifierProvider(create: (_) => AccomodationProvider()),
        ChangeNotifierProvider(create: (_) => TripItemProvider()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        routerConfig: MyRouter.router,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFFffffff)),
      ),
    );
  }
}
