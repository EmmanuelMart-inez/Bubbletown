// To parse this JSON data, do
//
//     final signUpFormModel = signUpFormModelFromJson(jsonString);

import 'dart:convert';

SignUpFormModel signUpFormModelFromJson(String str) => SignUpFormModel.fromJson(json.decode(str));

String signUpFormModelToJson(SignUpFormModel data) => json.encode(data.toJson());

class SignUpFormModel {
    String nombre;
    String paterno;
    String sexo;
    String password;
    String email;
    DateTime fechaNacimiento;
    String foto;

    SignUpFormModel({
        this.nombre,
        this.paterno,
        this.sexo,
        this.password,
        this.email,
        this.fechaNacimiento,
        this.foto,
    });

    factory SignUpFormModel.fromJson(Map<String, dynamic> json) => SignUpFormModel(
        nombre: json["nombre"],
        paterno: json["paterno"],
        sexo: json["sexo"],
        password: json["password"],
        email: json["email"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "paterno": paterno,
        "sexo": sexo,
        "password": password,
        "email": email,
        "fecha_nacimiento": fechaNacimiento.toIso8601String(),
        "foto": foto,
    };
}


// To parse this JSON data, do
//
//     final signUpFormResponseModel = signUpFormResponseModelFromJson(jsonString);


SignUpFormResponseModel signUpFormResponseModelFromJson(String str) => SignUpFormResponseModel.fromJson(json.decode(str));

String signUpFormResponseModelToJson(SignUpFormResponseModel data) => json.encode(data.toJson());

class SignUpFormResponseModel {
    String message;
    ObjectId objectId;

    SignUpFormResponseModel({
        this.message,
        this.objectId,
    });

    factory SignUpFormResponseModel.fromJson(Map<String, dynamic> json) => SignUpFormResponseModel(
        message: json["message"],
        objectId: ObjectId.fromJson(json["ObjectId"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "ObjectId": objectId.toJson(),
    };
}

class ObjectId {
    String id;

    ObjectId({
        this.id,
    });

    factory ObjectId.fromJson(Map<String, dynamic> json) => ObjectId(
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
    };
}
