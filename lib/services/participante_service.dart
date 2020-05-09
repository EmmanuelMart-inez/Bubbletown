import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/Storage/globals.dart';
import 'package:bubbletown_v1/Storage/user.dart';
import 'package:bubbletown_v1/models/participante_model.dart';
import 'package:http/http.dart' as http;

import 'package:bubbletown_v1/models/signup_model.dart';
import '../Storage/globals.dart';

Future<ParticipanteModel> fetchParticipante() async {
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
      await http.get('$apiURL/participante/$idParticipante');
  print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return ParticipanteModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<int> patchParticipante(String formdata) async {
  String idParticipante = await readTokenData();
  if (idParticipante == null && (obid == "null" || obid == null)) {
    throw Exception(
        'No se encontro en memoria local ni de ejecución el token del participante');
  }
  // Usar id en la memoria local (preferencias de usuario) o el auxiliar en memoria de ejecución
  if (idParticipante == "null" || idParticipante == null) {
    idParticipante = obid;
  }

  // set up POST request arguments
  String url = '$apiURL/participante/$idParticipante';
  Map<String, String> headers = {"Content-type": "application/json"};
  // String jsonformdata = signUpFormModelToJson(formdata);
  // make POST request
  try {
    final response = await http.patch(url, headers: headers, body: formdata);
    // check the status code for the result
    if (response.statusCode == 200) {
      print("200 ok Participante actualizado");
      return 200;
    } else {
      print("${response.statusCode}");
    }
  } catch (e) {
    print(e);
  }
  return 0;
}