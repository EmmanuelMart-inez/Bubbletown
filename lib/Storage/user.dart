import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> readTokenData() async {
  final prefs = await SharedPreferences.getInstance()
      .catchError((onError) => print("$onError"));
  try {
    // Try reading data from the counter key. If it doesn't exist, return 0.
    // prefs.setString('bubbletownToken', 'Hola Mundo').catchError((onError) => print("$onError"));
    final participanteId = prefs.getString('bubbletownToken');
    print(participanteId);
  } catch (e) {
    print(e);
  }
  // Si es igual a 0, realiza una llamada al API para registrarte y guardar la clave
  // TODO: Si no se logra guardar -> simplemente no guardar el token pero aun así iniciar sesión
}
