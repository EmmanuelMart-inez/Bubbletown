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
        premios: List<Premio>.from(json["Premios"].map((x) => Premio.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Premios": List<dynamic>.from(premios.map((x) => x.toJson())),
    };
}

class Premio {
    int puntos;
    String idParticipante;
    String nombre;
    String codigoQr;
    String imagenDisplay;
    DateTime fechaVigencia;
    DateTime fechaRedencion;
    int codigoBarras;
    String id;
    DateTime fechaCreacion;
    String imagenIcon;

    Premio({
        this.puntos,
        this.idParticipante,
        this.nombre,
        this.codigoQr,
        this.imagenDisplay,
        this.fechaVigencia,
        this.fechaRedencion,
        this.codigoBarras,
        this.id,
        this.fechaCreacion,
        this.imagenIcon,
    });

    factory Premio.fromJson(Map<String, dynamic> json) => Premio(
        puntos: json["puntos"],
        idParticipante: json["id_participante"],
        nombre: json["nombre"],
        codigoQr: json["codigo_qr"],
        imagenDisplay: json["imagen_display"],
        fechaVigencia: DateTime.parse(json["fecha_vigencia"]),
        fechaRedencion: DateTime.parse(json["fecha_redencion"]),
        codigoBarras: json["codigo_barras"],
        id: json["_id"],
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        imagenIcon: json["imagen_icon"],
    );

    Map<String, dynamic> toJson() => {
        "puntos": puntos,
        "id_participante": idParticipante,
        "nombre": nombre,
        "codigo_qr": codigoQr,
        "imagen_display": imagenDisplay,
        "fecha_vigencia": fechaVigencia.toIso8601String(),
        "fecha_redencion": fechaRedencion.toIso8601String(),
        "codigo_barras": codigoBarras,
        "_id": id,
        "fecha_creacion": fechaCreacion.toIso8601String(),
        "imagen_icon": imagenIcon,
    };
}
