// To parse this JSON data, do
//
//     final termModel = termModelFromJson(jsonString);

import 'dart:convert';

List<TermModel> termModelFromJson(String str) =>
    List<TermModel>.from(json.decode(str).map((x) => TermModel.fromJson(x)));

String termModelToJson(List<TermModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TermModel {
  TermModel({
    this.titel,
    this.detail,
  });

  String? titel;
  String? detail;

  factory TermModel.fromJson(Map<String, dynamic> json) => TermModel(
        titel: json["Titel"],
        detail: json["Detail"],
      );

  Map<String, dynamic> toJson() => {
        "Titel": titel,
        "Detail": detail,
      };
}
