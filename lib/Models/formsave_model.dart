// To parse this JSON data, do
//
//     final formStatus = formStatusFromJson(jsonString);

import 'dart:convert';

FormStatus formStatusFromJson(String str) =>
    FormStatus.fromJson(json.decode(str));

String formStatusToJson(FormStatus data) => json.encode(data.toJson());

class FormStatus {
  FormStatus({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory FormStatus.fromJson(Map<String, dynamic> json) => FormStatus(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
