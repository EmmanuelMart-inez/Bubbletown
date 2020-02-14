import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bubbletown_v1/models/login_form.dart';
import 'package:bubbletown_v1/models/signup_model.dart';
import 'package:http/http.dart' as http;

Future<LogInFormResponseModel> postLogin(LogInFormModel formdata) async {
  // set up POST request arguments
  String url = 'https://bubbletown.me/autenticacion';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonformdata = logInFormModelToJson(formdata);
  // make POST request
  try {
    final response = await http.post(url, headers: headers, body: jsonformdata);
    // check the status code for the result
    if (response.statusCode == 200) {
      print("200 ok");
      return LogInFormResponseModel.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }
  return LogInFormResponseModel(id: "null");
}

Future<LogInFormResponseModel> postRegistroSocialNetwork(String socialNetwork,
    SignUpFormModel formdata, LogInFormModel formsocial) async {
  // set up POST request arguments
  String url = 'https://bubbletown.me/registro/$socialNetwork';
  Map<String, String> headers = {"Content-type": "application/json"};

  // make POST request
  try {
    String jsonformdata;
    if (socialNetwork == 'google')
      jsonformdata =
        '{"${socialNetwork}_id":"${formsocial.password}", "email":"${formsocial.email}", "nombre": "${formdata.nombre.split(" ")[0]}", "paterno": "${formdata.nombre.split(" ")[1]}", "sexo": "${formdata.sexo}", "password": "socialBTWNpass7", "foto": "${formdata.foto}"}';
    if (socialNetwork == 'facebook')
      jsonformdata =
        '{"${socialNetwork}_id":"${formsocial.password}", "email":"${formsocial.email}", "nombre": "${formdata.nombre}", "paterno": "${formdata.paterno}", "sexo": "${formdata.sexo}", "password": "socialBTWNpass7", "foto": "${formdata.foto}"}';
    print(jsonformdata);
    final response = await http.post(url, headers: headers, body: jsonformdata);
    // check the status code for the result
    if (response.statusCode == 200) {
      print("200 REGISTRO");
      final participante =
          SignUpFormResponseModel.fromJson(json.decode(response.body));
      final newTarjetaSellos = await http.post(
          'https://bubbletown.me/tarjetasellos/${participante.objectId.id}');
      if (newTarjetaSellos.statusCode == 200) print("200 ok sellos");
      final newTarjetaPuntos = await http.post(
          'https://bubbletown.me/tarjetapuntos/${participante.objectId.id}');
      if (newTarjetaPuntos.statusCode == 200) print("200 ok puntos");
      if (newTarjetaPuntos.statusCode == 200 &&
          newTarjetaSellos.statusCode == 200) {
        return LogInFormResponseModel(id: participante.objectId.id);
      }
    } else if (response.statusCode == 404) {
      final participante =
          SignUpFormResponseModel.fromJson(json.decode(response.body));
      print("Ya existe este usuario en el registro de participantes");
      print(response.body);
      return LogInFormResponseModel(id: participante.objectId.id);
    } else
      print("no se pudo enviar el registro");
  } catch (e) {
    print(e);
  }
  return LogInFormResponseModel(id: "null");
}

Future<LogInFormResponseModel> postLoginSocialNetwork(
    String socialNetwork, LogInFormModel formdata) async {
  // set up POST request arguments
  String url = 'https://bubbletown.me/autenticacion/$socialNetwork';
  Map<String, String> headers = {"Content-type": "application/json"};

  // make POST request
  try {
    String jsonformdata =
        '{"id":"${formdata.password}", "email":"${formdata.email}"}';
    print(jsonformdata);
    final response = await http.post(url, headers: headers, body: jsonformdata);
    // check the status code for the result
    if (response.statusCode == 200) {
      print("200 LOGIN");
      return LogInFormResponseModel.fromJson(json.decode(response.body));
    } else
      print("No se pudo autenticar al usuario, favor de registrarse");
  } catch (e) {
    print(e);
  }
  return LogInFormResponseModel(id: "null");
}

// Future<LogInFormResponseModel> postLoginSocialNetwork(
//     String socialNetwork, LogInFormModel formdata) async {
//   // set up POST request arguments
//   String url = 'https://bubbletown.me/registro/$socialNetwork';
//   Map<String, String> headers = {"Content-type": "application/json"};

//   // make POST request
//   try {
//     if (formdata == null) {
//       final response = await http.post(url, headers: headers);
//       // check the status code for the result
//       if (response.statusCode == 200) {
//         print("200 lOGIN");
//         return LogInFormResponseModel.fromJson(json.decode(response.body));
//       }
//     } else {
//       String jsonformdata = '{"${socialNetwork}_id":"${formdata.password}", "email":"${formdata.email}"}';
//       print(jsonformdata);
//       final response =
//           await http.post(url, headers: headers, body: jsonformdata);
//       // check the status code for the result
//       if (response.statusCode == 200) {
//         print("200 REGISTRO");
//         return LogInFormResponseModel.fromJson(json.decode(response.body));
//       }else
//         print("no se pudo enviar el registro");
//     }
//   } catch (e) {
//     print(e);
//   }
//   return LogInFormResponseModel(id: "null");
// }

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
