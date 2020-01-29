import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/Storage/globals.dart';
import 'package:bubbletown_v1/Storage/user.dart';
import 'package:bubbletown_v1/models/participante_model.dart';
import 'package:http/http.dart' as http;

Future<ParticipanteModel> fetchParticipante(String a) async {
  String idParticipante = await readTokenData();
  if (idParticipante == null && (obid == "null" || obid == null)) {
    throw Exception(
        'No se encontro en memoria local ni de ejecución el token del participante');
  }
  // Usar id en la memoria local (preferencias de usuario) o el auxiliar en memoria de ejecución
  if (idParticipante == "null" || idParticipante == null) {
    idParticipante = obid;
  }
  final response =
      await http.get('https://bubbletown.me/participante/$idParticipante');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return ParticipanteModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}