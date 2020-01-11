import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/models/premios_model.dart';
import 'package:http/http.dart' as http;

Future<PremiosModel> fetchPremios() async {
  final response =
      await http.get('http://142.93.197.44/premios/5e141e35bca2e7cee96804e7');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return PremiosModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}