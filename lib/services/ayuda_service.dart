import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/models/ayuda_model.dart';
import 'package:http/http.dart' as http;

Future<AyudaModel> fetchAyuda() async {
  final response =
      await http.get('http://142.93.197.44/ayuda');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return AyudaModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}