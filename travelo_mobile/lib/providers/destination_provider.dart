import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/destination.dart';
import 'base_provider.dart';

class DestinationProvider extends BaseProvider<Destination> {
  DestinationProvider() : super("GetDestinations");

  @override
  Destination fromJson(data) {
    // TODO: implement fromJson
    return Destination.fromJson(data);
  }
}
