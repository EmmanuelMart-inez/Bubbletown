// To parse this JSON data, do
//
//     final notificacionesModel = notificacionesModelFromJson(jsonString);

import 'dart:convert';

NotificacionesModel notificacionesModelFromJson(String str) => NotificacionesModel.fromJson(json.decode(str));

String notificacionesModelToJson(NotificacionesModel data) => json.encode(data.toJson());

class NotificacionesModel {
    List<Notificacione> notificaciones;
    int total;

    NotificacionesModel({
        this.notificaciones,
        this.total,
    });

    factory NotificacionesModel.fromJson(Map<String, dynamic> json) => NotificacionesModel(
        notificaciones: List<Notificacione>.from(json["Notificaciones"].map((x) => Notificacione.fromJson(x))),
        total: json["Total"],
    );

    Map<String, dynamic> toJson() => {
        "Notificaciones": List<dynamic>.from(notificaciones.map((x) => x.toJson())),
        "Total": total,
    };
}

class Notificacione {
    String imagenIcon;
    DateTime fecha;
    String titulo;
    String tipoNotificacion;
    String id;
    String barText;
    String mensaje;

    Notificacione({
        this.imagenIcon,
        this.fecha,
        this.titulo,
        this.tipoNotificacion,
        this.id,
        this.barText,
        this.mensaje,
    });

    factory Notificacione.fromJson(Map<String, dynamic> json) => Notificacione(
        imagenIcon: json["imagenIcon"],
        fecha: DateTime.parse(json["fecha"]),
        titulo: json["titulo"],
        tipoNotificacion: json["tipo_notificacion"],
        id: json["_id"],
        barText: json["bar_text"],
        mensaje: json["mensaje"],
    );

    Map<String, dynamic> toJson() => {
        "imagenIcon": imagenIcon,
        "fecha": fecha.toIso8601String(),
        "titulo": titulo,
        "tipo_notificacion": tipoNotificacion,
        "_id": id,
        "bar_text": barText,
        "mensaje": mensaje,
    };
}
