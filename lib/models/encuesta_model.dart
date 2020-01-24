// To parse this JSON data, do
//
//     final encuestaModel = encuestaModelFromJson(jsonString);

import 'dart:convert';

EncuestaModel encuestaModelFromJson(String str) => EncuestaModel.fromJson(json.decode(str));

String encuestaModelToJson(EncuestaModel data) => json.encode(data.toJson());

class EncuestaModel {
    List<Pagina> paginas;
    DateTime fechaCreacion;
    String metrica;
    double puntos;
    String categoria;
    String id;

    EncuestaModel({
        this.paginas,
        this.fechaCreacion,
        this.metrica,
        this.puntos,
        this.categoria,
        this.id,
    });

    factory EncuestaModel.fromJson(Map<String, dynamic> json) => EncuestaModel(
        paginas: List<Pagina>.from(json["paginas"].map((x) => Pagina.fromJson(x))),
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        metrica: json["metrica"],
        puntos: json["puntos"],
        categoria: json["categoria"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "paginas": List<dynamic>.from(paginas.map((x) => x.toJson())),
        "fecha_creacion": fechaCreacion.toIso8601String(),
        "metrica": metrica,
        "puntos": puntos,
        "categoria": categoria,
        "_id": id,
    };
}

class Pagina {
    String tipo;
    String titulo;
    List<Opcione> opciones;
    String metrica;

    Pagina({
        this.tipo,
        this.titulo,
        this.opciones,
        this.metrica,
    });

    factory Pagina.fromJson(Map<String, dynamic> json) => Pagina(
        tipo: json["tipo"],
        titulo: json["titulo"],
        opciones: List<Opcione>.from(json["opciones"].map((x) => Opcione.fromJson(x))),
        metrica: json["metrica"],
    );

    Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "titulo": titulo,
        "opciones": List<dynamic>.from(opciones.map((x) => x.toJson())),
        "metrica": metrica,
    };
}

class Opcione {
    double rubrica;
    String icon;
    dynamic descripcion;
    String calificacion;

    Opcione({
        this.rubrica,
        this.icon,
        this.descripcion,
        this.calificacion,
    });

    factory Opcione.fromJson(Map<String, dynamic> json) => Opcione(
        rubrica: json["rubrica"],
        icon: json["icon"],
        descripcion: json["descripcion"],
        calificacion: json["calificacion"],
    );

    Map<String, dynamic> toJson() => {
        "rubrica": rubrica,
        "icon": icon,
        "descripcion": descripcion,
        "calificacion": calificacion,
    };
}

RespuestaEncuestaModel respuestaEncuestaModelFromJson(String str) => RespuestaEncuestaModel.fromJson(json.decode(str));

String respuestaEncuestaModelToJson(RespuestaEncuestaModel data) => json.encode(data.toJson());

class RespuestaEncuestaModel {
    String estado;
    List<String> respuestas;

    RespuestaEncuestaModel({
        this.estado,
        this.respuestas,
    });

    factory RespuestaEncuestaModel.fromJson(Map<String, dynamic> json) => RespuestaEncuestaModel(
        estado: json["estado"],
        respuestas: List<String>.from(json["respuestas"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "estado": estado,
        "respuestas": List<dynamic>.from(respuestas.map((x) => x)),
    };
}

