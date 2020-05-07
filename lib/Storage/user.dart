import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> readTokenData() async {
  final prefs = await SharedPreferences.getInstance()
      .catchError((onError) => print("$onError"));
  try {
    // Try reading data from the counter key. If it doesn't exist, return 0.
    // prefs.setString('bubbletownToken', '5e2f27a9db5584c6403a62c2').catchError((onError) => print("$onError"));
    final participanteId = prefs.getString('bubbletownToken');
    print("readTokenData : $participanteId");
    return participanteId;
  } catch (e) {
    // print(e);
  }
  // Si es igual a 0, realiza una llamada al API para registrarte y guardar la clave
  // TODO: Si no se logra guardar -> simplemente no guardar el token pero aun así iniciar sesión
}

Future<String> setNewTokenData(String idParticipante) async {
  final prefs = await SharedPreferences.getInstance()
      .catchError((onError) => print("$onError"));
  try {
    // Try reading data from the counter key. If it doesn't exist, return 0.
    if (idParticipante != null && idParticipante != "null") if (await prefs
        .setString('bubbletownToken', '$idParticipante')
        .catchError((onError) => print("$onError")))
      return prefs.getString('bubbletownToken');
  } catch (e) {
    print(e);
  }
}

Future<String> setPreference(String key, String value) async {
  final prefs = await SharedPreferences.getInstance()
      .catchError((onError) => print("$onError"));
  try {
    if (await prefs
        .setString('$key', '$value')
        .catchError((onError) => print("$onError"))) return '1';
  } catch (e) {
    print(e);
  }
  return '0';
}

Future<String> readPreference(String key) async {
  final prefs = await SharedPreferences.getInstance()
      .catchError((onError) => '0');
  try {
    // Try reading data from the counter key. If it doesn't exist, return 0.
    final value = prefs.getString('$key');
    print("value : $value");
    return value;
  } catch (e) {
    return '0';
  }
}
