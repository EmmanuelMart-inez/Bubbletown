// To parse this JSON data, do
//
//     final catalogomodel = catalogomodelFromJson(jsonString);

import 'dart:convert';

Catalogomodel catalogomodelFromJson(String str) => Catalogomodel.fromJson(json.decode(str));

String catalogomodelToJson(Catalogomodel data) => json.encode(data.toJson());

class Catalogomodel {
    List<Catalogo> catalogo;

    Catalogomodel({
        this.catalogo,
    });

    factory Catalogomodel.fromJson(Map<String, dynamic> json) => Catalogomodel(
        catalogo: List<Catalogo>.from(json["Catalogo"].map((x) => Catalogo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Catalogo": List<dynamic>.from(catalogo.map((x) => x.toJson())),
    };
}

class Catalogo {
    String imagen;
    String descripcion;
    DateTime fechaVigencia;
    String id;
    String titulo;
    String tipo;

    Catalogo({
        this.imagen,
        this.descripcion,
        this.fechaVigencia,
        this.id,
        this.titulo,
        this.tipo,
    });

    factory Catalogo.fromJson(Map<String, dynamic> json) => Catalogo(
        imagen: json["imagen"],
        descripcion: json["descripcion"],
        fechaVigencia: DateTime.parse(json["fecha_vigencia"]),
        id: json["_id"],
        titulo: json["titulo"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "imagen": imagen,
        "descripcion": descripcion,
        "fecha_vigencia": fechaVigencia.toIso8601String(),
        "_id": id,
        "titulo": titulo,
        "tipo": tipo,
    };
}
