// To parse this JSON data, do
//
//     final ayudaModel = ayudaModelFromJson(jsonString);

import 'dart:convert';

AyudaModel ayudaModelFromJson(String str) => AyudaModel.fromJson(json.decode(str));

String ayudaModelToJson(AyudaModel data) => json.encode(data.toJson());

class AyudaModel {
    List<Ayuda> ayuda;

    AyudaModel({
        this.ayuda,
    });

    factory AyudaModel.fromJson(Map<String, dynamic> json) => AyudaModel(
        ayuda: List<Ayuda>.from(json["Ayuda"].map((x) => Ayuda.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Ayuda": List<dynamic>.from(ayuda.map((x) => x.toJson())),
    };
}

class Ayuda {
    String imagenIcon;
    String id;
    String descripcion;
    String titulo;

    Ayuda({
        this.imagenIcon,
        this.id,
        this.descripcion,
        this.titulo,
    });

    factory Ayuda.fromJson(Map<String, dynamic> json) => Ayuda(
        imagenIcon: json["imagen_icon"],
        id: json["_id"],
        descripcion: json["descripcion"],
        titulo: json["titulo"],
    );

    Map<String, dynamic> toJson() => {
        "imagen_icon": imagenIcon,
        "_id": id,
        "descripcion": descripcion,
        "titulo": titulo,
    };
}