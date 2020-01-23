// To parse this JSON data, do
//
//     final movimientosModel = movimientosModelFromJson(jsonString);

import 'dart:convert';

MovimientosModel movimientosModelFromJson(String str) => MovimientosModel.fromJson(json.decode(str));

String movimientosModelToJson(MovimientosModel data) => json.encode(data.toJson());

class MovimientosModel {
    List<Movimiento> movimientos;

    MovimientosModel({
        this.movimientos,
    });

    factory MovimientosModel.fromJson(Map<String, dynamic> json) => MovimientosModel(
        movimientos: json["Movimientos"] == null ? null : List<Movimiento>.from(json["Movimientos"].map((x) => Movimiento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Movimientos": movimientos == null ? null : List<dynamic>.from(movimientos.map((x) => x.toJson())),
    };
}

class Movimiento {
    String nombre;
    String idParticipante;
    int total;
    String imagenIcon;
    DateTime fecha;
    String tipo;
    String id;

    Movimiento({
        this.nombre,
        this.idParticipante,
        this.total,
        this.imagenIcon,
        this.fecha,
        this.tipo,
        this.id,
    });

    factory Movimiento.fromJson(Map<String, dynamic> json) => Movimiento(
        nombre: json["nombre"] == null ? null : json["nombre"],
        idParticipante: json["id_participante"] == null ? null : json["id_participante"],
        total: json["total"] == null ? null : json["total"],
        imagenIcon: json["imagen_icon"] == null ? null : json["imagen_icon"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        tipo: json["tipo"] == null ? null : json["tipo"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre == null ? null : nombre,
        "id_participante": idParticipante == null ? null : idParticipante,
        "total": total == null ? null : total,
        "imagen_icon": imagenIcon == null ? null : imagenIcon,
        "fecha": fecha == null ? null : fecha.toIso8601String(),
        "tipo": tipo == null ? null : tipo,
        "_id": id == null ? null : id,
    };
}