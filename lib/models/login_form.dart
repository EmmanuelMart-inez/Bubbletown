// To parse this JSON data, do
//
//     final signUpFormModel = signUpFormModelFromJson(jsonString);

import 'dart:convert';

LogInFormModel logInFormModelFromJson(String str) => LogInFormModel.fromJson(json.decode(str));

String logInFormModelToJson(LogInFormModel data) => json.encode(data.toJson());

class LogInFormModel {
    String email;
    String password;

    LogInFormModel({
        this.email,
        this.password,
    });

    factory LogInFormModel.fromJson(Map<String, dynamic> json) => LogInFormModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}

LogInFormResponseModel logInFormResponseModelFromJson(String str) => LogInFormResponseModel.fromJson(json.decode(str));

String logInFormResponseModelToJson(LogInFormResponseModel data) => json.encode(data.toJson());

class LogInFormResponseModel {
    String id;

    LogInFormResponseModel({
        this.id,
    });

    factory LogInFormResponseModel.fromJson(Map<String, dynamic> json) => LogInFormResponseModel(
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
    };
}
