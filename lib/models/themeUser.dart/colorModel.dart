// To parse this JSON data, do
//
//     final themeModel = themeModelFromJson(jsonString);

import 'dart:convert';

ThemeModel themeModelFromJson(String str) => ThemeModel.fromJson(json.decode(str));

String themeModelToJson(ThemeModel data) => json.encode(data.toJson());

class ThemeModel {
    String color1;
    String color2;
    String color3;
    String color4;

    ThemeModel({
        this.color1,
        this.color2,
        this.color3,
        this.color4,
    });

    factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
        color1: json["color1"],
        color2: json["color2"],
        color3: json["color3"],
        color4: json["color4"],
    );

    Map<String, dynamic> toJson() => {
        "color1": color1,
        "color2": color2,
        "color3": color3,
        "color4": color4,
    };
}
