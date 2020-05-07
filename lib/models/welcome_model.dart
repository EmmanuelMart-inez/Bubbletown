// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Participante participante;
    TarjetaSellos tarjetaSellos;
    int numSellos;
    double numPuntos;
    int totalNotificaciones;

    Welcome({
        this.participante,
        this.tarjetaSellos,
        this.numSellos,
        this.numPuntos,
        this.totalNotificaciones,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        participante: json["Participante"] == null ? null : Participante.fromJson(json["Participante"]),
        tarjetaSellos: json["tarjeta_sellos"] == null ? null : TarjetaSellos.fromJson(json["tarjeta_sellos"]),
        numSellos: json["num_sellos"] == null ? null : json["num_sellos"],
        numPuntos: json["num_puntos"] == null ? null : json["num_puntos"],
        totalNotificaciones: json["total_notificaciones"] == null ? null : json["total_notificaciones"],
    );

    Map<String, dynamic> toJson() => {
        "Participante": participante == null ? null : participante.toJson(),
        "tarjeta_sellos": tarjetaSellos == null ? null : tarjetaSellos.toJson(),
        "num_sellos": numSellos == null ? null : numSellos,
        "num_puntos": numPuntos == null ? null : numPuntos,
        "total_notificaciones": totalNotificaciones == null ? null : totalNotificaciones,
    };
}

class Participante {
    String id;
    String nombre;
    String sexo;

    Participante({
        this.id,
        this.nombre,
        this.sexo,
    });

    factory Participante.fromJson(Map<String, dynamic> json) => Participante(
        id: json["_id"] == null ? null : json["_id"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        sexo: json["sexo"] == null ? null : json["sexo"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "nombre": nombre == null ? null : nombre,
        "sexo": sexo == null ? null : sexo,
    };
}

class TarjetaSellos {
    String id;
    double cantidadTrigger;
    DateTime fechaInicio;
    DateTime fechaFin;
    List<String> producto;
    DateTime fechaCreacion;
    String iconoOn;
    String titulo;
    int numSellos;
    String iconoOff;
    String descripcion;

    TarjetaSellos({
        this.id,
        this.cantidadTrigger,
        this.fechaInicio,
        this.fechaFin,
        this.producto,
        this.fechaCreacion,
        this.iconoOn,
        this.titulo,
        this.numSellos,
        this.iconoOff,
        this.descripcion,
    });

    factory TarjetaSellos.fromJson(Map<String, dynamic> json) => TarjetaSellos(
        id: json["_id"] == null ? null : json["_id"],
        cantidadTrigger: json["cantidad_trigger"] == null ? null : json["cantidad_trigger"],
        fechaInicio: json["fecha_inicio"] == null ? null : DateTime.parse(json["fecha_inicio"]),
        fechaFin: json["fecha_fin"] == null ? null : DateTime.parse(json["fecha_fin"]),
        producto: json["producto"] == null ? null : List<String>.from(json["producto"].map((x) => x)),
        fechaCreacion: json["fecha_creacion"] == null ? null : DateTime.parse(json["fecha_creacion"]),
        iconoOn: json["icono_on"] == null ? null : json["icono_on"],
        titulo: json["titulo"] == null ? null : json["titulo"],
        numSellos: json["num_sellos"] == null ? null : json["num_sellos"],
        iconoOff: json["icono_off"] == null ? null : json["icono_off"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "cantidad_trigger": cantidadTrigger == null ? null : cantidadTrigger,
        "fecha_inicio": fechaInicio == null ? null : fechaInicio.toIso8601String(),
        "fecha_fin": fechaFin == null ? null : fechaFin.toIso8601String(),
        "producto": producto == null ? null : List<dynamic>.from(producto.map((x) => x)),
        "fecha_creacion": fechaCreacion == null ? null : fechaCreacion.toIso8601String(),
        "icono_on": iconoOn == null ? null : iconoOn,
        "titulo": titulo == null ? null : titulo,
        "num_sellos": numSellos == null ? null : numSellos,
        "icono_off": iconoOff == null ? null : iconoOff,
        "descripcion": descripcion == null ? null : descripcion,
    };
}


// OLD
// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

// class Welcome {
//     Participante participante;
//     int totalNotificaciones;

//     Welcome({
//         this.participante,
//         this.totalNotificaciones,
//     });

//     factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         participante: Participante.fromJson(json["Participante"]),
//         totalNotificaciones: json["total_notificaciones"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Participante": participante.toJson(),
//         "total_notificaciones": totalNotificaciones,
//     };
// }

// class Participante {
//     String id="";
//     TarjetaSellos tarjetaSellos;
//     String nombre="";
//     TarjetaPuntos tarjetaPuntos;
//     String sexo="";

//     Participante({
//         this.id,
//         this.tarjetaSellos,
//         this.nombre,
//         this.tarjetaPuntos,
//         this.sexo,
//     });

//     factory Participante.fromJson(Map<String, dynamic> json) => Participante(
//         id: json["_id"],
//         tarjetaSellos: TarjetaSellos.fromJson(json["tarjeta_sellos"]),
//         nombre: json["nombre"],
//         tarjetaPuntos: TarjetaPuntos.fromJson(json["tarjeta_puntos"]),
//         sexo: json["sexo"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "tarjeta_sellos": tarjetaSellos.toJson(),
//         "nombre": nombre,
//         "tarjeta_puntos": tarjetaPuntos.toJson(),
//         "sexo": sexo,
//     };
// }

// class TarjetaPuntos {
//     dynamic codigoBarras;
//     dynamic fechaVigencia;
//     dynamic qrImagen;
//     double balance;
//     dynamic fechaCreacion;

//     TarjetaPuntos({
//         this.codigoBarras,
//         this.fechaVigencia,
//         this.qrImagen,
//         this.balance,
//         this.fechaCreacion,
//     });

//     factory TarjetaPuntos.fromJson(Map<String, dynamic> json) => TarjetaPuntos(
//         codigoBarras: json["codigo_barras"],
//         fechaVigencia: json["fecha_vigencia"],
//         qrImagen: json["qr_imagen"],
//         balance: json["balance"],
//         fechaCreacion: json["fecha_creacion"],
//     );

//     Map<String, dynamic> toJson() => {
//         "codigo_barras": codigoBarras,
//         "fecha_vigencia": fechaVigencia,
//         "qr_imagen": qrImagen,
//         "balance": balance,
//         "fecha_creacion": fechaCreacion,
//     };
// }

// class TarjetaSellos {
//     String descripcion;
//     String id;
//     int numSellos;

//     TarjetaSellos({
//         this.descripcion,
//         this.id,
//         this.numSellos,
//     });

//     factory TarjetaSellos.fromJson(Map<String, dynamic> json) => TarjetaSellos(
//         descripcion: json["descripcion"],
//         id: json["_id"],
//         numSellos: json["num_sellos"],
//     );

//     Map<String, dynamic> toJson() => {
//         "descripcion": descripcion,
//         "_id": id,
//         "num_sellos": numSellos,
//     };
// }