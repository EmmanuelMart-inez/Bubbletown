// To parse this JSON data, do
//
//     final catalogo = catalogoFromJson(jsonString);

import 'dart:convert';

Catalogo catalogoFromJson(String str) => Catalogo.fromJson(json.decode(str));

String catalogoToJson(Catalogo data) => json.encode(data.toJson());

class Catalogo {
    List<CatalogoElement> catalogo;

    Catalogo({
        this.catalogo,
    });

    factory Catalogo.fromJson(Map<String, dynamic> json) => Catalogo(
        catalogo: List<CatalogoElement>.from(json["Catalogo"].map((x) => CatalogoElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Catalogo": List<dynamic>.from(catalogo.map((x) => x.toJson())),
    };
}

class CatalogoElement {
    String imagen;
    String descripcion;
    DateTime fechaVigencia;
    String id;
    String titulo;
    String tipo;

    CatalogoElement({
        this.imagen,
        this.descripcion,
        this.fechaVigencia,
        this.id,
        this.titulo,
        this.tipo,
    });

    factory CatalogoElement.fromJson(Map<String, dynamic> json) => CatalogoElement(
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
