// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Participante participante;
    int totalNotificaciones;

    Welcome({
        this.participante,
        this.totalNotificaciones,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        participante: Participante.fromJson(json["Participante"]),
        totalNotificaciones: json["total_notificaciones"],
    );

    Map<String, dynamic> toJson() => {
        "Participante": participante.toJson(),
        "total_notificaciones": totalNotificaciones,
    };
}

class Participante {
    String id="";
    TarjetaSellos tarjetaSellos;
    String nombre="";
    TarjetaPuntos tarjetaPuntos;
    String sexo="";

    Participante({
        this.id,
        this.tarjetaSellos,
        this.nombre,
        this.tarjetaPuntos,
        this.sexo,
    });

    factory Participante.fromJson(Map<String, dynamic> json) => Participante(
        id: json["_id"],
        tarjetaSellos: TarjetaSellos.fromJson(json["tarjeta_sellos"]),
        nombre: json["nombre"],
        tarjetaPuntos: TarjetaPuntos.fromJson(json["tarjeta_puntos"]),
        sexo: json["sexo"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "tarjeta_sellos": tarjetaSellos.toJson(),
        "nombre": nombre,
        "tarjeta_puntos": tarjetaPuntos.toJson(),
        "sexo": sexo,
    };
}

class TarjetaPuntos {
    dynamic codigoBarras;
    dynamic fechaVigencia;
    dynamic qrImagen;
    double balance;
    dynamic fechaCreacion;

    TarjetaPuntos({
        this.codigoBarras,
        this.fechaVigencia,
        this.qrImagen,
        this.balance,
        this.fechaCreacion,
    });

    factory TarjetaPuntos.fromJson(Map<String, dynamic> json) => TarjetaPuntos(
        codigoBarras: json["codigo_barras"],
        fechaVigencia: json["fecha_vigencia"],
        qrImagen: json["qr_imagen"],
        balance: json["balance"],
        fechaCreacion: json["fecha_creacion"],
    );

    Map<String, dynamic> toJson() => {
        "codigo_barras": codigoBarras,
        "fecha_vigencia": fechaVigencia,
        "qr_imagen": qrImagen,
        "balance": balance,
        "fecha_creacion": fechaCreacion,
    };
}

class TarjetaSellos {
    String descripcion;
    String id;
    int numSellos;

    TarjetaSellos({
        this.descripcion,
        this.id,
        this.numSellos,
    });

    factory TarjetaSellos.fromJson(Map<String, dynamic> json) => TarjetaSellos(
        descripcion: json["descripcion"],
        id: json["_id"],
        numSellos: json["num_sellos"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "_id": id,
        "num_sellos": numSellos,
    };
}