import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';



class Utility {

  static const String KEY = "IMAGE_KEY";

  static Future<String> getimagefromsomewhere() async {
    final SharedPreferences = await SharedPreferences.getInstance();
    return prefs.getString(KEY) ?? null;
  }

  static Future<bool> saveimagetosomehwere(String value) async {
    final SharedPreferences = await SharedPreferences.getInstance();
    return prefs.getString(KEY, value);
  }

  static imagefrombas64(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List datafrombase64(String base64String) {
    return base64Decode(base64String);
  }

  static String  datafromstring(Uint8List data) {
    return base64Encode(data);
  }
}