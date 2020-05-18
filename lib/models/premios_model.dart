// To parse this JSON data, do
//
//     final premiosModel = premiosModelFromJson(jsonString);

import 'dart:convert';

PremiosModel premiosModelFromJson(String str) => PremiosModel.fromJson(json.decode(str));

String premiosModelToJson(PremiosModel data) => json.encode(data.toJson());

class PremiosModel {
    List<Premio> premios;

    PremiosModel({
        this.premios,
    });

    factory PremiosModel.fromJson(Map<String, dynamic> json) => PremiosModel(
        premios: json["Premios"] == null ? null : List<Premio>.from(json["Premios"].map((x) => Premio.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Premios": premios == null ? null : List<dynamic>.from(premios.map((x) => x.toJson())),
    };
}

class Premio {
    int codigoBarras;
    DateTime fechaVigencia;
    String imagenDisplay;
    String id;
    DateTime fechaCreacion;
    int puntos;
    String codigoQr;
    String nombre;
    String imagenIcon;

    Premio({
        this.codigoBarras,
        this.fechaVigencia,
        this.imagenDisplay,
        this.id,
        this.fechaCreacion,
        this.puntos,
        this.codigoQr,
        this.nombre,
        this.imagenIcon,
    });

    factory Premio.fromJson(Map<String, dynamic> json) => Premio(
        codigoBarras: json["codigo_barras"] == null ? null : json["codigo_barras"],
        fechaVigencia: json["fecha_vigencia"] == null ? null : DateTime.parse(json["fecha_vigencia"]),
        imagenDisplay: json["imagen_display"] == null ? null : json["imagen_display"],
        id: json["_id"] == null ? null : json["_id"],
        fechaCreacion: json["fecha_creacion"] == null ? null : DateTime.parse(json["fecha_creacion"]),
        puntos: json["puntos"] == null ? null : json["puntos"],
        codigoQr: json["codigo_qr"] == null ? null : json["codigo_qr"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        imagenIcon: json["imagen_icon"] == null ? null : json["imagen_icon"],
    );

    Map<String, dynamic> toJson() => {
        "codigo_barras": codigoBarras == null ? null : codigoBarras,
        "fecha_vigencia": fechaVigencia == null ? null : fechaVigencia.toIso8601String(),
        "imagen_display": imagenDisplay == null ? null : imagenDisplay,
        "_id": id == null ? null : id,
        "fecha_creacion": fechaCreacion == null ? null : fechaCreacion.toIso8601String(),
        "puntos": puntos == null ? null : puntos,
        "codigo_qr": codigoQr == null ? null : codigoQr,
        "nombre": nombre == null ? null : nombre,
        "imagen_icon": imagenIcon == null ? null : imagenIcon,
    };
}



// OLD
// // To parse this JSON data, do
// //
// //     final premiosModel = premiosModelFromJson(jsonString);

// import 'dart:convert';

// PremiosModel premiosModelFromJson(String str) => PremiosModel.fromJson(json.decode(str));

// String premiosModelToJson(PremiosModel data) => json.encode(data.toJson());

// class PremiosModel {
//     List<Premio> premios;

//     PremiosModel({
//         this.premios,
//     });

//     factory PremiosModel.fromJson(Map<String, dynamic> json) => PremiosModel(
//         premios: List<Premio>.from(json["Premios"].map((x) => Premio.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "Premios": List<dynamic>.from(premios.map((x) => x.toJson())),
//     };
// }

// class Premio {
//     int puntos;
//     String idParticipante;
//     String nombre;
//     String codigoQr;
//     String imagenDisplay;
//     DateTime fechaVigencia;
//     int codigoBarras;
//     String id;
//     DateTime fechaCreacion;
//     String imagenIcon;

//     Premio({
//         this.puntos,
//         this.idParticipante,
//         this.nombre,
//         this.codigoQr,
//         this.imagenDisplay,
//         this.fechaVigencia,
//         this.codigoBarras,
//         this.id,
//         this.fechaCreacion,
//         this.imagenIcon,
//     });

//     factory Premio.fromJson(Map<String, dynamic> json) => Premio(
//         puntos: json["puntos"],
//         idParticipante: json["id_participante"],
//         nombre: json["nombre"],
//         codigoQr: json["codigo_qr"],
//         imagenDisplay: json["imagen_display"],
//         fechaVigencia: DateTime.parse(json["fecha_vigencia"]),
//         codigoBarras: json["codigo_barras"],
//         id: json["_id"],
//         fechaCreacion: DateTime.parse(json["fecha_creacion"]),
//         imagenIcon: json["imagen_icon"],
//     );

//     Map<String, dynamic> toJson() => {
//         "puntos": puntos,
//         "id_participante": idParticipante,
//         "nombre": nombre,
//         "codigo_qr": codigoQr,
//         "imagen_display": imagenDisplay,
//         "fecha_vigencia": fechaVigencia.toIso8601String(),
//         "codigo_barras": codigoBarras,
//         "_id": id,
//         "fecha_creacion": fechaCreacion.toIso8601String(),
//         "imagen_icon": imagenIcon,
//     };
// }
