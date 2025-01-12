// To parse this JSON data, do
//
//     final speakerModel = speakerModelFromJson(jsonString);

import 'dart:convert';

SpeakerModel speakerModelFromJson(String str) => SpeakerModel.fromJson(json.decode(str));

String speakerModelToJson(SpeakerModel data) => json.encode(data.toJson());

class SpeakerModel {
  dynamic contentEncoding;
  dynamic contentType;
  Data? data;
  int? jsonRequestBehavior;
  dynamic maxJsonLength;
  dynamic recursionLimit;

  SpeakerModel({
    this.contentEncoding,
    this.contentType,
    this.data,
    this.jsonRequestBehavior,
    this.maxJsonLength,
    this.recursionLimit,
  });

  factory SpeakerModel.fromJson(Map<String, dynamic> json) => SpeakerModel(
    contentEncoding: json["ContentEncoding"],
    contentType: json["ContentType"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
    jsonRequestBehavior: json["JsonRequestBehavior"],
    maxJsonLength: json["MaxJsonLength"],
    recursionLimit: json["RecursionLimit"],
  );

  Map<String, dynamic> toJson() => {
    "ContentEncoding": contentEncoding,
    "ContentType": contentType,
    "Data": data?.toJson(),
    "JsonRequestBehavior": jsonRequestBehavior,
    "MaxJsonLength": maxJsonLength,
    "RecursionLimit": recursionLimit,
  };
}

class Data {
  List<Result>? result;
  String? message;

  Data({
    this.result,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["Result"] == null ? [] : List<Result>.from(json["Result"]!.map((x) => Result.fromJson(x))),
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "Message": message,
  };
}

class Result {
  int? eventid;
  int? id;
  String? speakerName;
  String? speakerDesignation;
  String? speakerBio;
  String? speakerImage;
  String? speakerType;
  dynamic imagePath;
  int? order;
  dynamic orderId;

  Result({
    this.eventid,
    this.id,
    this.speakerName,
    this.speakerDesignation,
    this.speakerBio,
    this.speakerImage,
    this.speakerType,
    this.imagePath,
    this.order,
    this.orderId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    eventid: json["Eventid"],
    id: json["id"],
    speakerName: json["speaker_name"],
    speakerDesignation: json["speaker_designation"],
    speakerBio: json["speaker_bio"],
    speakerImage: json["speaker_image"],
    speakerType: json["speaker_type"],
    imagePath: json["image_path"],
    order: json["Order"],
    orderId: json["OrderId"],
  );

  Map<String, dynamic> toJson() => {
    "Eventid": eventid,
    "id": id,
    "speaker_name": speakerName,
    "speaker_designation": speakerDesignation,
    "speaker_bio": speakerBio,
    "speaker_image": speakerImage,
    "speaker_type": speakerType,
    "image_path": imagePath,
    "Order": order,
    "OrderId": orderId,
  };
}
