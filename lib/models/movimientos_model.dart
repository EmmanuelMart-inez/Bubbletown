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
        movimientos: List<Movimiento>.from(json["Movimientos"].map((x) => Movimiento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Movimientos": List<dynamic>.from(movimientos.map((x) => x.toJson())),
    };
}

class Movimiento {
    String nombre;
    String idParticipante;
    double total;
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
        nombre: json["nombre"],
        idParticipante: json["id_participante"],
        total: json["total"],
        imagenIcon: json["imagen_icon"],
        fecha: DateTime.parse(json["fecha"]),
        tipo: json["tipo"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "id_participante": idParticipante,
        "total": total,
        "imagen_icon": imagenIcon,
        "fecha": fecha.toIso8601String(),
        "tipo": tipo,
        "_id": id,
    };
}
