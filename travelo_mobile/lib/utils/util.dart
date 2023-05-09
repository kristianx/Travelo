import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// class Authorization {
//   static String? email;
//   static String? password;
// }

bool doesAssetExist(String assetPath) {
  try {
    rootBundle.load(assetPath);
    return true;
  } catch (_) {
    return false;
  }
}

Future<File?> pickImage() async {
  final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (myfile != null) {
    return File(myfile.path);
  }
  return null;
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');
  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}
