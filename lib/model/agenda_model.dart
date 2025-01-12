// To parse this JSON data, do
//
//     final agendaModel = agendaModelFromJson(jsonString);

import 'dart:convert';

AgendaModel agendaModelFromJson(String str) => AgendaModel.fromJson(json.decode(str));

String agendaModelToJson(AgendaModel data) => json.encode(data.toJson());

class AgendaModel {
  dynamic contentEncoding;
  dynamic contentType;
  Data? data;
  int? jsonRequestBehavior;
  dynamic maxJsonLength;
  dynamic recursionLimit;

  AgendaModel({
    this.contentEncoding,
    this.contentType,
    this.data,
    this.jsonRequestBehavior,
    this.maxJsonLength,
    this.recursionLimit,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) => AgendaModel(
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
  int? id;
  int? eventid;
  String? title;
  DateTime? date;
  String? time;
  dynamic starttime;
  dynamic endtime;
  String? topic;
  String? speakerName;
  String? day;
  String? specialcell;
  String? injection;

  Result({
    this.id,
    this.eventid,
    this.title,
    this.date,
    this.time,
    this.starttime,
    this.endtime,
    this.topic,
    this.speakerName,
    this.day,
    this.specialcell,
    this.injection,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    eventid: json["Eventid"],
    title: json["Title"]?.replaceAll('\t', ''),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    starttime: json["Starttime"],
    endtime: json["Endtime"],
    topic: json["topic"],
    speakerName: json["speaker_name"],
    day: json["day"],
    specialcell: json["specialcell"],
    injection: json["injection"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Eventid": eventid,
    "Title": title,
    "date": date,
    "time": time,
    "Starttime": starttime,
    "Endtime": endtime,
    "topic": topic,
    "speaker_name": speakerName,
    "day": day,
    "specialcell": specialcell,
    "injection": injection,
  };
}

