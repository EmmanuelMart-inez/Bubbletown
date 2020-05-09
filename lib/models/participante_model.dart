// To parse this JSON data, do
//
//     final participanteModel = participanteModelFromJson(jsonString);

import 'dart:convert';

ParticipanteModel participanteModelFromJson(String str) => ParticipanteModel.fromJson(json.decode(str));

String participanteModelToJson(ParticipanteModel data) => json.encode(data.toJson());

class ParticipanteModel {
    String nombre;
    String id;
    String email;
    String password;
    TarjetaPuntos tarjetaPuntos;
    String paterno;
    DateTime fechaNacimiento;
    TarjetaSellos tarjetaSellos;
    String foto;

    ParticipanteModel({
        this.nombre,
        this.id,
        this.email,
        this.password,
        this.tarjetaPuntos,
        this.paterno,
        this.fechaNacimiento,
        this.tarjetaSellos,
        this.foto,
    });

    factory ParticipanteModel.fromJson(Map<String, dynamic> json) => ParticipanteModel(
        nombre: json["nombre"] == null ? null : json["nombre"],
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        tarjetaPuntos: json["tarjeta_puntos"] == null ? null : TarjetaPuntos.fromJson(json["tarjeta_puntos"]),
        paterno: json["paterno"] == null ? null : json["paterno"],
        fechaNacimiento: json["fecha_nacimiento"] == null ? null : DateTime.parse(json["fecha_nacimiento"]),
        tarjetaSellos: json["tarjeta_sellos"] == null ? null : TarjetaSellos.fromJson(json["tarjeta_sellos"]),
        foto: json["foto"] == null ? null : json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre == null ? null : nombre,
        "_id": id == null ? null : id,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "tarjeta_puntos": tarjetaPuntos == null ? null : tarjetaPuntos.toJson(),
        "paterno": paterno == null ? null : paterno,
        "fecha_nacimiento": fechaNacimiento == null ? null : fechaNacimiento.toIso8601String(),
        "tarjeta_sellos": tarjetaSellos == null ? null : tarjetaSellos.toJson(),
        "foto": foto == null ? null : foto,
    };
}

class TarjetaPuntos {
    dynamic qrImagen;
    dynamic codigoBarras;
    double balance;
    dynamic fechaCreacion;
    dynamic fechaVigencia;

    TarjetaPuntos({
        this.qrImagen,
        this.codigoBarras,
        this.balance,
        this.fechaCreacion,
        this.fechaVigencia,
    });

    factory TarjetaPuntos.fromJson(Map<String, dynamic> json) => TarjetaPuntos(
        qrImagen: json["qr_imagen"],
        codigoBarras: json["codigo_barras"],
        balance: json["balance"] == null ? null : json["balance"],
        fechaCreacion: json["fecha_creacion"],
        fechaVigencia: json["fecha_vigencia"],
    );

    Map<String, dynamic> toJson() => {
        "qr_imagen": qrImagen,
        "codigo_barras": codigoBarras,
        "balance": balance == null ? null : balance,
        "fecha_creacion": fechaCreacion,
        "fecha_vigencia": fechaVigencia,
    };
}

class TarjetaSellos {
    dynamic titulo;
    int numSellos;
    String descripcion;
    String id;
    dynamic fechaFin;
    dynamic fechaInicio;
    String producto;
    dynamic iconoOn;
    dynamic iconoOff;

    TarjetaSellos({
        this.titulo,
        this.numSellos,
        this.descripcion,
        this.id,
        this.fechaFin,
        this.fechaInicio,
        this.producto,
        this.iconoOn,
        this.iconoOff,
    });

    factory TarjetaSellos.fromJson(Map<String, dynamic> json) => TarjetaSellos(
        titulo: json["titulo"],
        numSellos: json["num_sellos"] == null ? null : json["num_sellos"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        id: json["_id"] == null ? null : json["_id"],
        fechaFin: json["fecha_fin"],
        fechaInicio: json["fecha_inicio"],
        producto: json["producto"] == null ? null : json["producto"],
        iconoOn: json["icono_on"],
        iconoOff: json["icono_off"],
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "num_sellos": numSellos == null ? null : numSellos,
        "descripcion": descripcion == null ? null : descripcion,
        "_id": id == null ? null : id,
        "fecha_fin": fechaFin,
        "fecha_inicio": fechaInicio,
        "producto": producto == null ? null : producto,
        "icono_on": iconoOn,
        "icono_off": iconoOff,
    };
}



// OLD Participante Model
// 
// // To parse this JSON data, do
// //
// //     final participanteModel = participanteModelFromJson(jsonString);

// import 'dart:convert';

// ParticipanteModel participanteModelFromJson(String str) => ParticipanteModel.fromJson(json.decode(str));

// String participanteModelToJson(ParticipanteModel data) => json.encode(data.toJson());

// class ParticipanteModel {
//     String foto;
//     DateTime fechaNacimiento;
//     String nombre;
//     TarjetaPuntos tarjetaPuntos;
//     String password;
//     String paterno;
//     TarjetaSellos tarjetaSellos;
//     String id;
//     String email;

//     ParticipanteModel({
//         this.foto,
//         this.fechaNacimiento,
//         this.nombre,
//         this.tarjetaPuntos,
//         this.password,
//         this.paterno,
//         this.tarjetaSellos,
//         this.id,
//         this.email,
//     });

//     factory ParticipanteModel.fromJson(Map<String, dynamic> json) => ParticipanteModel(
//         foto: json["foto"],
//         fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
//         nombre: json["nombre"],
//         tarjetaPuntos: TarjetaPuntos.fromJson(json["tarjeta_puntos"]),
//         password: json["password"],
//         paterno: json["paterno"],
//         tarjetaSellos: TarjetaSellos.fromJson(json["tarjeta_sellos"]),
//         id: json["_id"],
//         email: json["email"],
//     );

//     Map<String, dynamic> toJson() => {
//         "foto": foto,
//         "fecha_nacimiento": fechaNacimiento.toIso8601String(),
//         "nombre": nombre,
//         "tarjeta_puntos": tarjetaPuntos.toJson(),
//         "password": password,
//         "paterno": paterno,
//         "tarjeta_sellos": tarjetaSellos.toJson(),
//         "_id": id,
//         "email": email,
//     };
// }

// class TarjetaPuntos {
//     double balance;
//     dynamic qrImagen;
//     dynamic fechaVigencia;
//     dynamic codigoBarras;
//     dynamic fechaCreacion;

//     TarjetaPuntos({
//         this.balance,
//         this.qrImagen,
//         this.fechaVigencia,
//         this.codigoBarras,
//         this.fechaCreacion,
//     });

//     factory TarjetaPuntos.fromJson(Map<String, dynamic> json) => TarjetaPuntos(
//         balance: json["balance"],
//         qrImagen: json["qr_imagen"],
//         fechaVigencia: json["fecha_vigencia"],
//         codigoBarras: json["codigo_barras"],
//         fechaCreacion: json["fecha_creacion"],
//     );

//     Map<String, dynamic> toJson() => {
//         "balance": balance,
//         "qr_imagen": qrImagen,
//         "fecha_vigencia": fechaVigencia,
//         "codigo_barras": codigoBarras,
//         "fecha_creacion": fechaCreacion,
//     };
// }

// class TarjetaSellos {
//     String descripcion;
//     dynamic producto;
//     dynamic iconoOn;
//     dynamic fechaInicio;
//     dynamic fechaFin;
//     int numSellos;
//     dynamic titulo;
//     String id;
//     dynamic iconoOff;

//     TarjetaSellos({
//         this.descripcion,
//         this.producto,
//         this.iconoOn,
//         this.fechaInicio,
//         this.fechaFin,
//         this.numSellos,
//         this.titulo,
//         this.id,
//         this.iconoOff,
//     });

//     factory TarjetaSellos.fromJson(Map<String, dynamic> json) => TarjetaSellos(
//         descripcion: json["descripcion"],
//         producto: json["producto"],
//         iconoOn: json["icono_on"],
//         fechaInicio: json["fecha_inicio"],
//         fechaFin: json["fecha_fin"],
//         numSellos: json["num_sellos"],
//         titulo: json["titulo"],
//         id: json["_id"],
//         iconoOff: json["icono_off"],
//     );

//     Map<String, dynamic> toJson() => {
//         "descripcion": descripcion,
//         "producto": producto,
//         "icono_on": iconoOn,
//         "fecha_inicio": fechaInicio,
//         "fecha_fin": fechaFin,
//         "num_sellos": numSellos,
//         "titulo": titulo,
//         "_id": id,
//         "icono_off": iconoOff,
//     };
// }
