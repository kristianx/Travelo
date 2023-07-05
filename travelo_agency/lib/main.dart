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

  static const _blackPrimaryValue = 0xffEAAD5F;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor mycolor = const MaterialColor(
      _blackPrimaryValue,
      <int, Color>{
        50: Color(0xFFe0e0e0),
        100: Color(0xFFb3b3b3),
        200: Color(0xFF808080),
        300: Color(0xFF4d4d4d),
        400: Color(0xFF262626),
        500: Color(_blackPrimaryValue),
        600: Color(0xFF000000),
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      },
    );
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
            primarySwatch: mycolor,
            scaffoldBackgroundColor: const Color(0xFFffffff)),
      ),
    );
  }
}
