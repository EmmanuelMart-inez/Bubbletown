// To parse this JSON data, do
//
//     final participanteModel = participanteModelFromJson(jsonString);

import 'dart:convert';

ParticipanteModel participanteModelFromJson(String str) => ParticipanteModel.fromJson(json.decode(str));

String participanteModelToJson(ParticipanteModel data) => json.encode(data.toJson());

class ParticipanteModel {
    String foto;
    DateTime fechaNacimiento;
    String nombre;
    TarjetaPuntos tarjetaPuntos;
    String password;
    String paterno;
    TarjetaSellos tarjetaSellos;
    String id;
    String email;

    ParticipanteModel({
        this.foto,
        this.fechaNacimiento,
        this.nombre,
        this.tarjetaPuntos,
        this.password,
        this.paterno,
        this.tarjetaSellos,
        this.id,
        this.email,
    });

    factory ParticipanteModel.fromJson(Map<String, dynamic> json) => ParticipanteModel(
        foto: json["foto"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        nombre: json["nombre"],
        tarjetaPuntos: TarjetaPuntos.fromJson(json["tarjeta_puntos"]),
        password: json["password"],
        paterno: json["paterno"],
        tarjetaSellos: TarjetaSellos.fromJson(json["tarjeta_sellos"]),
        id: json["_id"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "foto": foto,
        "fecha_nacimiento": fechaNacimiento.toIso8601String(),
        "nombre": nombre,
        "tarjeta_puntos": tarjetaPuntos.toJson(),
        "password": password,
        "paterno": paterno,
        "tarjeta_sellos": tarjetaSellos.toJson(),
        "_id": id,
        "email": email,
    };
}

class TarjetaPuntos {
    double balance;
    dynamic qrImagen;
    dynamic fechaVigencia;
    dynamic codigoBarras;
    dynamic fechaCreacion;

    TarjetaPuntos({
        this.balance,
        this.qrImagen,
        this.fechaVigencia,
        this.codigoBarras,
        this.fechaCreacion,
    });

    factory TarjetaPuntos.fromJson(Map<String, dynamic> json) => TarjetaPuntos(
        balance: json["balance"],
        qrImagen: json["qr_imagen"],
        fechaVigencia: json["fecha_vigencia"],
        codigoBarras: json["codigo_barras"],
        fechaCreacion: json["fecha_creacion"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
        "qr_imagen": qrImagen,
        "fecha_vigencia": fechaVigencia,
        "codigo_barras": codigoBarras,
        "fecha_creacion": fechaCreacion,
    };
}

class TarjetaSellos {
    String descripcion;
    dynamic producto;
    dynamic iconoOn;
    dynamic fechaInicio;
    dynamic fechaFin;
    int numSellos;
    dynamic titulo;
    String id;
    dynamic iconoOff;

    TarjetaSellos({
        this.descripcion,
        this.producto,
        this.iconoOn,
        this.fechaInicio,
        this.fechaFin,
        this.numSellos,
        this.titulo,
        this.id,
        this.iconoOff,
    });

    factory TarjetaSellos.fromJson(Map<String, dynamic> json) => TarjetaSellos(
        descripcion: json["descripcion"],
        producto: json["producto"],
        iconoOn: json["icono_on"],
        fechaInicio: json["fecha_inicio"],
        fechaFin: json["fecha_fin"],
        numSellos: json["num_sellos"],
        titulo: json["titulo"],
        id: json["_id"],
        iconoOff: json["icono_off"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "producto": producto,
        "icono_on": iconoOn,
        "fecha_inicio": fechaInicio,
        "fecha_fin": fechaFin,
        "num_sellos": numSellos,
        "titulo": titulo,
        "_id": id,
        "icono_off": iconoOff,
    };
}
