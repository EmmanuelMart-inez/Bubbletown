import 'dart:async';
import 'dart:convert';

import 'package:bubbletown_v1/models/login_form.dart';
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

Future<LogInFormResponseModel> postLoginSocialNetwork(
    String socialNetwork, LogInFormModel formdata) async {
  // set up POST request arguments
  String url = 'https://bubbletown.me/registro/$socialNetwork';
  Map<String, String> headers = {"Content-type": "application/json"};

  // make POST request
  try {
    if (formdata == null) {
      final response = await http.post(url, headers: headers);
      // check the status code for the result
      if (response.statusCode == 200) {
        print("200 lOGIN");
        return LogInFormResponseModel.fromJson(json.decode(response.body));
      }
    } else {
      String jsonformdata = logInFormModelToJson(formdata);
      final response =
          await http.post(url, headers: headers, body: jsonformdata);
      // check the status code for the result
      if (response.statusCode == 200) {
        print("200 REGISTRO");
        return LogInFormResponseModel.fromJson(json.decode(response.body));
      }
    }
  } catch (e) {
    print(e);
  }
  return LogInFormResponseModel(id: "null");
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
