// To parse this JSON data, do
//
//     final applicationModel = applicationModelFromJson(jsonString);

import 'dart:convert';

ApplicationModel applicationModelFromJson(String str) =>
    ApplicationModel.fromJson(json.decode(str));

String applicationModelToJson(ApplicationModel data) =>
    json.encode(data.toJson());

class ApplicationModel {
  ApplicationModel({
    this.termacceped,
    this.refferid,
    this.name,
    this.father,
    this.mother,
    this.mobile,
    this.altMobile = '',
    this.email = '',
    this.expirence = '',
    this.qualification,
    this.city,
    this.gender,
    this.post,
    this.appliedfor,
    this.payableamt,
    this.address,
  });

  bool? termacceped;
  String? refferid;
  String? name;
  String? father;
  String? mother;
  String? mobile;
  String? altMobile;
  String? email;
  String? expirence;
  String? qualification;
  String? city;
  String? gender;
  String? post;
  String? appliedfor;
  String? payableamt;
  String? address;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
        termacceped: json["termacceped"],
        refferid: json["refferid"],
        name: json["name"],
        father: json["father"],
        mother: json["Mother"],
        mobile: json["mobile"],
        altMobile: json["alt_mobile"],
        email: json["email"],
        expirence: json["expirence"],
        qualification: json["qualification"],
        city: json["city"],
        gender: json["gender"],
        post: json["post"],
        appliedfor: json["appliedfor"],
        payableamt: json["payableamt"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "termacceped": termacceped,
        "refferid": refferid,
        "name": name,
        "father": father,
        "Mother": mother,
        "mobile": mobile,
        "alt_mobile": altMobile,
        "email": email,
        "expirence": expirence,
        "qualification": qualification,
        "city": city,
        "gender": gender,
        "post": post,
        "appliedfor": appliedfor,
        "payableamt": payableamt,
        "address": address,
      };
}

/*
{"termacceped":true,
"refferid":"Kuldeep",
"name":"Kuldeep",
"father":"Vijay",
"Mother":"Vijay",
"mobile":"8318891622",
"alt_mobile":"8318891622",
"email":"test@gmail.com",
"expirence":"5tjhpass",
"qualification":"5th",
"city":"Lucknow",
"gender":"Male",
"post":"Bouncer",
"appliedfor":"Registation",
"payableamt":"500",
"address":"bakshi ka talab , lucknw"
}

*/
