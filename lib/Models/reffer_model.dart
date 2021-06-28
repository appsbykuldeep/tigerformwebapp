import 'dart:convert';

RefferModel refferModelFromJson(String str) =>
    RefferModel.fromJson(json.decode(str));

class RefferModel {
  RefferModel({
    this.candId,
    this.candName,
  });

  String? candId;
  String? candName;

  factory RefferModel.fromJson(Map<String, dynamic> json) => RefferModel(
        candId: json["Cand_id"],
        candName: json["Cand_name"],
      );
}
