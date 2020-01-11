import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/models/notificaciones_model.dart';
import 'package:http/http.dart' as http;

Future<NotificacionesModel> fetchNotificaciones(String a) async {
  final response =
      await http.get('http://142.93.197.44/notificaciones/$a');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return NotificacionesModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}