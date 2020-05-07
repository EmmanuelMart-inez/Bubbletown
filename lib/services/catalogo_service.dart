import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/models/catalogo_model.dart';
import 'package:http/http.dart' as http;
import '../Storage/globals.dart';

Future<Catalogomodel> fetchCatalogo(String a) async {
  final response =
      await http.get('$apiURL/catalogo/$a');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Catalogomodel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}