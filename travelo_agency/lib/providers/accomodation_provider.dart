import 'dart:convert';
import 'dart:io';

import '../models/accomodation.dart';
import 'base_provider.dart';

class AccomodationProvider extends BaseProvider<Accomodation> {
  AccomodationProvider() : super("Accomodation");

  Future<bool> uploadImage(int accId, File file) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.post(
        Uri.parse("https://127.0.0.1:7100/Accomodation/UpdateImage"),
        body: jsonEncode(<String, dynamic>{
          "accomodationId": accId,
          "image": base64Encode(file.readAsBytesSync())
        }),
        headers: headers);

    if (response!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> facilitiesUpdate(int accId, List<String> facilities) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.post(
        Uri.parse("https://127.0.0.1:7100/Accomodation/UpdateFacilities"),
        body: jsonEncode(<String, dynamic>{
          "accomodationId": accId,
          "facilities": facilities
        }),
        headers: headers);

    if (response!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Accomodation fromJson(data) {
    return Accomodation.fromJson(data);
  }
}
