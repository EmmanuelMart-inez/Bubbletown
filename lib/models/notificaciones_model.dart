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
        notificaciones: json["Notificaciones"] == null ? null : List<Notificacione>.from(json["Notificaciones"].map((x) => Notificacione.fromJson(x))),
        total: json["Total"] == null ? null : json["Total"],
    );

    Map<String, dynamic> toJson() => {
        "Notificaciones": notificaciones == null ? null : List<dynamic>.from(notificaciones.map((x) => x.toJson())),
        "Total": total == null ? null : total,
    };
}

class Notificacione {
    IdNotificacion idNotificacion;
    String id;

    Notificacione({
        this.idNotificacion,
        this.id,
    });

    factory Notificacione.fromJson(Map<String, dynamic> json) => Notificacione(
        idNotificacion: json["id_notificacion"] == null ? null : IdNotificacion.fromJson(json["id_notificacion"]),
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "id_notificacion": idNotificacion == null ? null : idNotificacion.toJson(),
        "_id": id == null ? null : id,
    };
}

class IdNotificacion {
    String titulo;
    DateTime fecha;
    String imagenIcon;
    String id;
    String barText;
    String link;
    String mensaje;
    String tipoNotificacion;

    IdNotificacion({
        this.titulo,
        this.fecha,
        this.imagenIcon,
        this.id,
        this.barText,
        this.link,
        this.mensaje,
        this.tipoNotificacion,
    });

    factory IdNotificacion.fromJson(Map<String, dynamic> json) => IdNotificacion(
        titulo: json["titulo"] == null ? null : json["titulo"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        imagenIcon: json["imagenIcon"] == null ? null : json["imagenIcon"],
        id: json["_id"] == null ? null : json["_id"],
        barText: json["bar_text"] == null ? null : json["bar_text"],
        link: json["link"] == null ? null : json["link"],
        mensaje: json["mensaje"] == null ? null : json["mensaje"],
        tipoNotificacion: json["tipo_notificacion"] == null ? null : json["tipo_notificacion"],
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo == null ? null : titulo,
        "fecha": fecha == null ? null : fecha.toIso8601String(),
        "imagenIcon": imagenIcon == null ? null : imagenIcon,
        "_id": id == null ? null : id,
        "bar_text": barText == null ? null : barText,
        "link": link == null ? null : link,
        "mensaje": mensaje == null ? null : mensaje,
        "tipo_notificacion": tipoNotificacion == null ? null : tipoNotificacion,
    };
}


// OLD 
// // To parse this JSON data, do
// //
// //     final notificacionesModel = notificacionesModelFromJson(jsonString);

// import 'dart:convert';

// NotificacionesModel notificacionesModelFromJson(String str) => NotificacionesModel.fromJson(json.decode(str));

// String notificacionesModelToJson(NotificacionesModel data) => json.encode(data.toJson());

// class NotificacionesModel {
//     List<Notificacione> notificaciones;
//     int total;

//     NotificacionesModel({
//         this.notificaciones,
//         this.total,
//     });

//     factory NotificacionesModel.fromJson(Map<String, dynamic> json) => NotificacionesModel(
//         notificaciones: List<Notificacione>.from(json["Notificaciones"].map((x) => Notificacione.fromJson(x))),
//         total: json["Total"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Notificaciones": List<dynamic>.from(notificaciones.map((x) => x.toJson())),
//         "Total": total,
//     };
// }

// class Notificacione {
//     String imagenIcon;
//     DateTime fecha;
//     String titulo;
//     String tipoNotificacion;
//     String id;
//     String barText;
//     String mensaje;
//     String link;

//     Notificacione({
//         this.imagenIcon,
//         this.fecha,
//         this.titulo,
//         this.tipoNotificacion,
//         this.id,
//         this.barText,
//         this.mensaje,
//         this.link,
//     });

//     factory Notificacione.fromJson(Map<String, dynamic> json) => Notificacione(
//         imagenIcon: json["imagenIcon"],
//         fecha: DateTime.parse(json["fecha"]),
//         titulo: json["titulo"],
//         tipoNotificacion: json["tipo_notificacion"],
//         id: json["_id"],
//         barText: json["bar_text"],
//         mensaje: json["mensaje"],
//         link: json["link"],
//     );

//     Map<String, dynamic> toJson() => {
//         "imagenIcon": imagenIcon,
//         "fecha": fecha.toIso8601String(),
//         "titulo": titulo,
//         "tipo_notificacion": tipoNotificacion,
//         "_id": id,
//         "bar_text": barText,
//         "mensaje": mensaje,
//         "link": link,
//     };
// }
