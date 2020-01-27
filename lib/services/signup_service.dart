import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/models/signup_model.dart';
import 'package:http/http.dart' as http;

// Future<EncuestaModel> fetchEncuesta(String a) async {
//   final response =
//       await http.get('https://bubbletown.me/encuesta/5e296c4202ffbe39077087e3');

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
//   String url = 'https://bubbletown.me/controlencuestas/$idEncuestaParticipante';
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
  String url = 'https://bubbletown.me/participante';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonformdata = signUpFormModelToJson(formdata);
  // make POST request
  try {
    final response = await http.post(url, headers: headers, body: jsonformdata);
    // check the status code for the result
    if (response.statusCode == 200) {
      return SignUpFormResponseModel.fromJson(json.decode(response.body));
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