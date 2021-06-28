// To parse this JSON data, do
//
//     final imageSave = imageSaveFromJson(jsonString);

import 'dart:convert';

ImageSave imageSaveFromJson(String str) => ImageSave.fromJson(json.decode(str));

String imageSaveToJson(ImageSave data) => json.encode(data.toJson());

class ImageSave {
  ImageSave({
    this.staus = 0,
    this.id = 0,
    this.message = '',
  });

  int? staus;
  int? id;
  String? message;

  factory ImageSave.fromJson(Map<String, dynamic> json) => ImageSave(
        staus: json["Staus"],
        id: json["Id"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Staus": staus,
        "Id": id,
        "Message": message,
      };
}
