import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/models/encuesta_model.dart';
import 'package:http/http.dart' as http;

Future<EncuestaModel> fetchEncuesta(String a) async {
  final response =
      await http.get('https://bubbletown.me/encuesta/5e296c4202ffbe39077087e3');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return EncuestaModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


Future<int> patchEncuesta(String jsondata, String idEncuestaParticipante) async {
  // set up POST request arguments
  String url = 'https://bubbletown.me/controlencuestas/$idEncuestaParticipante';
  Map<String, String> headers = {"Content-type": "application/json"};
    // String json = '{"title": "Hello", "body": "body text", "userId": 1}';
  // make POST request
  final response = await http.patch(url, headers: headers, body: jsondata);
  // check the status code for the result
    return response.statusCode;
}
  

// int postEncuesta(String ) async {
//   // set up POST request arguments
//   String url = 'https://jsonplaceholder.typicode.com/posts';
//   Map<String, String> headers = {"Content-type": "application/json"};
//   String json = '{"title": "Hello", "body": "body text", "userId": 1}';
//   // make POST request
//   Response response = await post(url, headers: headers, body: json);
//   // check the status code for the result
//   int statusCode = response.statusCode;
//   // this API passes back the id of the new item added to the body
//   String body = response.body;
//   // {
//   //   "title": "Hello",
//   //   "body": "body text",
//   //   "userId": 1,
//   //   "id": 101
//   // }
// }