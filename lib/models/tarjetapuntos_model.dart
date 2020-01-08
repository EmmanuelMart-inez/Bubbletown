// To parse this JSON data, do
//
//     final miTarjeta = miTarjetaFromJson(jsonString);

import 'dart:convert';

MiTarjeta miTarjetaFromJson(String str) => MiTarjeta.fromJson(json.decode(str));

String miTarjetaToJson(MiTarjeta data) => json.encode(data.toJson());

class MiTarjeta {
    String id;
    String nombre;
    TarjetaPuntos tarjetaPuntos;

    MiTarjeta({
        this.id,
        this.nombre,
        this.tarjetaPuntos,
    });

    factory MiTarjeta.fromJson(Map<String, dynamic> json) => MiTarjeta(
        id: json["_id"],
        nombre: json["nombre"],
        tarjetaPuntos: TarjetaPuntos.fromJson(json["tarjeta_puntos"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "tarjeta_puntos": tarjetaPuntos.toJson(),
    };
}

class TarjetaPuntos {
    dynamic codigoBarras;
    dynamic fechaVigencia;
    dynamic qrImagen;
    int balance;
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
