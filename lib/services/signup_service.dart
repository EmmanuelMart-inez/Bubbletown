import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/models/signup_model.dart';
import 'package:http/http.dart' as http;
import '../Storage/globals.dart';

// Future<EncuestaModel> fetchEncuesta(String a) async {
//   final response =
//       await http.get('$apiURL/encuesta/5e296c4202ffbe39077087e3');

//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON.
//     return EncuestaModel.fromJson(json.decode(response.body));
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to load post');
//   }
// }

// Future<int> patchEncuesta(String jsondata, String idEncuestaParticipante) async {
//   // set up POST request arguments
//   String url = '$apiURL/controlencuestas/$idEncuestaParticipante';
//   Map<String, String> headers = {"Content-type": "application/json"};
//     // String json = '{"title": "Hello", "body": "body text", "userId": 1}';
//   // make POST request
//   final response = await http.patch(url, headers: headers, body: jsondata);
//   // check the status code for the result
//     return response.statusCode;
// }

Future<SignUpFormResponseModel> postParticipante(
    SignUpFormModel formdata) async {
  // set up POST request arguments
  String url = '$apiURL/participante';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonformdata = signUpFormModelToJson(formdata);
  // make POST request
  try {
    final response = await http.post(url, headers: headers, body: jsonformdata);
    // check the status code for the result
    if (response.statusCode == 200) {
      print("200 ok");
      // if(newTarjetaPuntos.statusCode == 200 && newTarjetaSellos.statusCode == 200)
      final participante =
          SignUpFormResponseModel.fromJson(json.decode(response.body));
      final newTarjetaSellos = await http
          .post('$apiURL/tarjetasellos/${participante.objectId.id}');
      if (newTarjetaSellos.statusCode == 200) print("200 ok sellos");
      final newTarjetaPuntos = await http
          .post('$apiURL/tarjetapuntos/${participante.objectId.id}');
      if (newTarjetaPuntos.statusCode == 200) print("200 ok puntos");
      if (newTarjetaPuntos.statusCode == 200 &&
          newTarjetaSellos.statusCode == 200) return participante;
    }
  } catch (e) {
    print(e);
  }
  return SignUpFormResponseModel(message: "null");
}

String changeImageFormatToUpper(String st) {
  String start;
  String format;
  String newString;
  if (st.substring(st.length - 3).compareTo('PNG') > 0) {
    format = "PNG";
    start = st.substring(0, st.length - 3);
    newString = '$start$format';
    print(newString);
    return newString;
  } else
    return st;
}
