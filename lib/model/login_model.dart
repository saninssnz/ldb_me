// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? message;
  dynamic eventid;
  bool? status;
  int? id;
  String? useruniqueid;
  String? qrCode;
  String? doctorName;
  String? email;
  List<EventId>? eventIds;

  LoginModel({
    this.message,
    this.eventid,
    this.status,
    this.id,
    this.useruniqueid,
    this.qrCode,
    this.doctorName,
    this.email,
    this.eventIds,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["Message"],
    eventid: json["eventid"],
    status: json["Status"],
    id: json["id"],
    useruniqueid: json["Useruniqueid"],
    qrCode: json["QrCode"],
    doctorName: json["DoctorName"],
    email: json["Email"],
    eventIds: json["EventIds"] == null ? [] : List<EventId>.from(json["EventIds"]!.map((x) => EventId.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "eventid": eventid,
    "Status": status,
    "id": id,
    "Useruniqueid": useruniqueid,
    "QrCode": qrCode,
    "DoctorName": doctorName,
    "Email": email,
    "EventIds": eventIds == null ? [] : List<dynamic>.from(eventIds!.map((x) => x.toJson())),
  };
}

class EventId {
  int? id;
  int? userId;
  int? eventId;
  bool? isActive;
  dynamic dateTime;

  EventId({
    this.id,
    this.userId,
    this.eventId,
    this.isActive,
    this.dateTime,
  });

  factory EventId.fromJson(Map<String, dynamic> json) => EventId(
    id: json["Id"],
    userId: json["UserId"],
    eventId: json["EventId"],
    isActive: json["IsActive"],
    dateTime: json["DateTime"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "UserId": userId,
    "EventId": eventId,
    "IsActive": isActive,
    "DateTime": dateTime,
  };
}
